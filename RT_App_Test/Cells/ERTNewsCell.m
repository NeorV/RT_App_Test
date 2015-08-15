//
//  ERTNewsCell.m
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import "ERTNewsCell.h"

@interface ERTNewsCell ()

@property (nonatomic, weak) IBOutlet UIImageView *cellImageView;
@property (nonatomic, weak) IBOutlet UILabel *headLabel;
@property (nonatomic, weak) IBOutlet UILabel *bodyLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberOfLikeLabel;

@end

@implementation ERTNewsCell

- (void)awakeFromNib
{
    // Initialization code
}


#pragma mark - Setters

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.cellImageView.image = image;
}

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
    self.dateLabel.text = @"10 часов назад";
}

- (void)setNumberOfLike:(NSUInteger)numberOfLike
{
    _numberOfLike = numberOfLike;
    self.numberOfLikeLabel.text = [NSString stringWithFormat:@"%ld", numberOfLike];
}

@end
