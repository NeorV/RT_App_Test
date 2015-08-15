//
//  LTRefreshControl.h
//  Litres
//
//  Created by Sergey Yefanov on 28.11.14.
//
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    RefreshingDirectionNone    = 0,
    RefreshingDirectionTop     = 1 << 0,
} RefreshingDirections;

@protocol LTRefreshControlDelegate;

@interface LTBookRefreshControl : NSObject

@property (nonatomic, readonly) RefreshingDirections    refreshingDirection;
@property (nonatomic, readonly) UIScrollView *          scrollView;
@property (nonatomic)           BOOL                    topEnabled;
@property (nonatomic)           CGFloat                 enableInsetTop;
@property (nonatomic)           CGFloat                 contentOffsetForLoading;
@property (nonatomic)           CGFloat                 offsetYForBook;
@property (nonatomic)           BOOL                    inFrontOfScroll;
@property (nonatomic)           BOOL                    hidden;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView
                          delegate:(id<LTRefreshControlDelegate>)delegate;
- (void)startRefreshing;
- (void)finishRefreshing;

@end

@protocol LTRefreshControlDelegate <NSObject>

@optional
- (void)refreshControlDidEngageRefresh:(LTBookRefreshControl *)refreshControl;

@end



