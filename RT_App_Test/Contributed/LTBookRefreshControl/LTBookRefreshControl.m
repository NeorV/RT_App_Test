//
//  LTRefreshControl.m
//  Litres
//
//  Created by Sergey Yefanov on 28.11.14.
//
//

#import "LTBookRefreshControl.h"
#import "LTBookRefreshView.h"

static CGFloat const OFFSET_FOR_ACTIVATION = 100.0;

@interface LTBookRefreshControl ()

@property (nonatomic, weak) id<LTRefreshControlDelegate>    delegate;
@property (nonatomic)       LTBookRefreshView *             topView;
@property (nonatomic)       CGPoint                         startPoint;
@property (nonatomic)       BOOL                            startPointIsInitialized;
@property (nonatomic)       BOOL                            startPointFound;

@end

@implementation LTBookRefreshControl

#pragma mark - Initialization

- (instancetype)initWithScrollView:(UIScrollView *)scrollView delegate:(id<LTRefreshControlDelegate>)delegate
{
    if (self = [super init])
    {
        _scrollView = scrollView;
        _delegate = delegate;

        self.enableInsetTop = OFFSET_FOR_ACTIVATION;
        [_scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld context:NULL];
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:NULL];
        self.contentOffsetForLoading = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 43 : 64 + 20;
        self.offsetYForBook = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 68 : 4;
    }
    
    return self;
}

- (void)initTopView
{
    if (!CGRectIsEmpty(_scrollView.frame))
    {
        CGRect topViewFrame = CGRectMake(_scrollView.frame.size.width / 2 - 16, _offsetYForBook, 32, 32);
        if (_topView == nil)
        {
            _topView = [[LTBookRefreshView alloc] initWithFrame:topViewFrame];
            [_scrollView.superview addSubview:_topView];
            
            if(!_inFrontOfScroll)
                [_scrollView.superview bringSubviewToFront:_scrollView];
            
            _topView.hidden = YES;
        }
        else
        {
            _topView.frame = topViewFrame;
        }
    }
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqual:@"contentSize"])
    {
        if (self.topEnabled)
        {
            [self initTopView];
        }
    }
    else if ([keyPath isEqualToString:@"contentOffset"])
    {
        static BOOL isOffseting = NO;
        
        if (_refreshingDirection == RefreshingDirectionNone)
        {
            if (!self.startPointIsInitialized)
            {
                self.startPoint = CGPointMake(0, 0);// _scrollView.contentInset.top);// ? _scrollView.contentInset.top - 24 : _scrollView.contentInset.top);
                self.startPointIsInitialized = YES;
            }
            
            CGPoint offsetPoint = [(NSValue*)change[@"old"] CGPointValue];
            CGPoint resultPoint = (CGPoint){offsetPoint.x - self.startPoint.x, offsetPoint.y - self.startPoint.y};
            
            if (resultPoint.y >= -_scrollView.contentInset.top)
            {
                self.startPointFound = YES;
                isOffseting = NO;
            }
            
            if (self.scrollView.isDragging)
                _topView.hidden = NO;
            
            if (self.startPointFound)
                [self _dragOffset:resultPoint];
        }
        else if (_refreshingDirection == RefreshingDirectionTop)
        {
            CGPoint offsetPoint = [(NSValue*)change[@"old"] CGPointValue];
            CGPoint resultPoint = (CGPoint){offsetPoint.x - self.startPoint.x, offsetPoint.y - self.startPoint.y};
            
            if (resultPoint.y == -self.contentOffsetForLoading)
                isOffseting = NO;
            
            if (resultPoint.y < 0 && ABS(resultPoint.y) < self.contentOffsetForLoading)
            {
                if (!((UIScrollView *)object).isTracking && !isOffseting)
                {
                    [self.scrollView setContentOffset:CGPointMake(0, -self.contentOffsetForLoading)
                                             animated:YES];
                    isOffseting = YES;
                }
            }
        }
    }
}

#pragma mark - Setters

- (void)setInFrontOfScroll:(BOOL)inFrontOfScroll
{
    _inFrontOfScroll = inFrontOfScroll;
    
    if(inFrontOfScroll)
       [self.scrollView.superview bringSubviewToFront:self.topView];
    else
       [self.scrollView.superview bringSubviewToFront:self.scrollView];
}

- (void)setHidden:(BOOL)hidden
{
    _hidden = hidden;
    self.topView.hidden = hidden;
}

#pragma mark -

- (void)_dragOffset:(CGPoint)point
{
    if ( self.topEnabled && self.scrollView.contentOffset.y < _scrollView.contentInset.top)
    {
        NSInteger percent = -(point.y + _scrollView.contentInset.top) / _enableInsetTop * 100;
        percent = MAX(percent, 0);
        
        _topView.hidden = percent <= 0;
        [self.topView didDisengageRefreshWithPercent:percent];
        
        if (point.y < -self.enableInsetTop)
            if (self.scrollView.decelerating && self.scrollView.dragging == NO)
                [self _engageRefresh];
    }
}

- (void)_engageRefresh
{
    _refreshingDirection = RefreshingDirectionTop;
    [_scrollView setContentOffset:CGPointMake(0, -self.contentOffsetForLoading) animated:YES];
    [self _didEngageRefresh];
}

- (void)_didEngageRefresh
{
    [self.topView startRefreshing];
    
    if ([self.delegate respondsToSelector:@selector(refreshControlDidEngageRefresh:)])
        [self.delegate refreshControlDidEngageRefresh:self];
}

- (void)setTopEnabled:(BOOL)topEnabled
{
    _topEnabled = topEnabled;
    
    if (_topEnabled)
    {
        if (self.topView == nil)
            [self initTopView];
    }
    else
    {
        [self.topView removeFromSuperview];
        self.topView = nil;
    }
}

#pragma mark - Public methods

- (void)startRefreshing
{
    CGPoint point = CGPointMake(0, - _scrollView.contentInset.top);
    
    float topH = self.enableInsetTop < 45 ? 45 : self.enableInsetTop;
    point = CGPointMake(0, -topH);
    
    __weak LTBookRefreshControl *weakSelf = self;
    
    [_scrollView setContentOffset:point animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf _engageRefresh];
    });
}

- (void)finishRefreshing
{
    [self.topView finishRefreshing];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((TIME_FOR_FINISH_BOOK_ANIMATION - 0.3) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.scrollView.contentOffset.y <= -self.contentOffsetForLoading)
        {
            CGPoint offset = CGPointMake(0, - _scrollView.contentInset.top);
            [_scrollView setContentOffset:offset animated:YES];
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((TIME_FOR_FINISH_BOOK_ANIMATION) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.topView.hidden = YES;
    });
    
    _refreshingDirection = RefreshingDirectionNone;
}

#pragma mark - Dealloc

- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
