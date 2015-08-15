//
//  ERTNewsCell.h
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ERTNewsCell : UITableViewCell

@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *head;
@property (nonatomic) NSString *body;
@property (nonatomic) NSDate *date;
@property (nonatomic) NSUInteger numberOfLike;

+ (CGFloat)heightCellForText:(NSString *)text andWitdh:(CGFloat)width;

@end
