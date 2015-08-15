//
//  LTBookRefreshView.h
//  Litres
//
//  Created by Sergey Yefanov on 28.11.14.
//
//

#import <UIKit/UIKit.h>
#import "LTBookRefreshControl.h"

extern CGFloat const TIME_FOR_FINISH_BOOK_ANIMATION;

@interface LTBookRefreshView : UIView

@property (nonatomic,strong) UIImageView *imageView;

- (void)didDisengageRefreshWithPercent:(NSInteger)percent;
- (void)startRefreshing;
- (void)finishRefreshing;

@end 