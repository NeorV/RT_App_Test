//
//  ERTNewsCell.m
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import "ERTNewsCell.h"
#import "NSDate+RT.h"

#define CELL_FONT [UIFont fontWithName:@"HelveticaNeue" size:13]

static const CGFloat CELL_LEFT_OFFSET_BODY = 12.0f;
static const CGFloat CELL_RIGHT_OFFSET_BODY = 12.0f;

static const CGFloat CELL_BODY_HEIGHT_INSET = 20.0f;
static const CGFloat CELL_HEADE4_HEIGHT_INSET = 50.0f;
static const CGFloat CELL_BOTTOM_HEIGHT_INSET = 26.0f;

@interface ERTNewsCell ()

@property (nonatomic, weak) IBOutlet UILabel *headLabel;
@property (nonatomic, weak) IBOutlet UILabel *bodyLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfLikeLabel;

@end

@implementation ERTNewsCell

- (void)awakeFromNib
{

}

#pragma mark - Cell Height

+ (CGFloat)heightCellForText:(NSString *)text andWitdh:(CGFloat)width
{
    CGFloat labelWidth = width - (CELL_LEFT_OFFSET_BODY + CELL_RIGHT_OFFSET_BODY);
    CGSize constraint = CGSizeMake(labelWidth, 20000.0f);
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text
                                                                         attributes:@{
                                                                                      NSFontAttributeName:CELL_FONT}];
    
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    
    return rect.size.height + CELL_BODY_HEIGHT_INSET + CELL_HEADE4_HEIGHT_INSET + CELL_BOTTOM_HEIGHT_INSET;
}

#pragma mark - Setters

- (void)setHead:(NSString *)head
{
    _head = head;
    self.headLabel.text = head;
}

- (void)setBody:(NSString *)body
{
    _body = body;
    self.bodyLabel.text = body;
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    
    self.dateLabel.text = [date rtDateString];
}

- (void)setNumberOfLike:(NSUInteger)numberOfLike
{
    _numberOfLike = numberOfLike;
    self.numberOfLikeLabel.text = [NSString stringWithFormat:@"Оценили: %ld", numberOfLike];
}

@end
