//
//  LTBookRefreshView.m
//  Litres
//
//  Created by Sergey Yefanov on 28.11.14.
//
//

#import "LTBookRefreshView.h"

static NSInteger const START_PERCENT_ANIMATION = 26;
static NSInteger const MAX_PERCENT_ANIMATION = 100;

CGFloat const TIME_FOR_FINISH_BOOK_ANIMATION = 1.2;

@implementation LTBookRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)didDisengageRefreshWithPercent:(NSInteger)percent
{
    NSInteger tempPercent = (percent - START_PERCENT_ANIMATION) > 0 ? percent - START_PERCENT_ANIMATION : 0;
    if (tempPercent < (MAX_PERCENT_ANIMATION - START_PERCENT_ANIMATION))
    {
        NSUInteger image_number = 12. / (MAX_PERCENT_ANIMATION - START_PERCENT_ANIMATION) * tempPercent;
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Preloader_37_%lu.png", (unsigned long)image_number]];
    }
    else if (percent >= 100)
    {
        _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Preloader_37_%d.png", 12]];
    }
}

- (void)startRefreshing
{
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSInteger idx = 12; idx < 15; idx++)
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Preloader_37_%ld", (long)idx]]];
    
    _imageView.animationImages = array;
    _imageView.animationDuration = 0.4;
    _imageView.animationRepeatCount = 0;
    
    [_imageView startAnimating];
}

- (void)finishRefreshing
{
    [_imageView stopAnimating];
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSInteger idx = 14; idx < 26; idx++)
        [array addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Preloader_37_%ld", (long)idx]]];
    
    _imageView.animationImages = array;
    _imageView.animationDuration = TIME_FOR_FINISH_BOOK_ANIMATION;
    _imageView.animationRepeatCount = 1;
    
    _imageView.image = [UIImage imageNamed:@"Preloader_35_25.png"];
    [_imageView startAnimating];
}


@end
