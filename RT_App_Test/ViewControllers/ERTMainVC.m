//
//  ViewController.m
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import "ERTMainVC.h"
#import "ERTNewsCell.h"
#import "ERTNetworkManager.h"
#import "NSDate+RT.h"
#import "UIKit+AFNetworking.h"

static NSString * const ERT_NEWS_CELL_IDENTIFER = @"ERT_NEWS_CELL_IDENTIFER";

@interface ERTMainVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic)                UINib       *cellNib;
@property (nonatomic)                NSArray     *newsArr;

@end

@implementation ERTMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ERTNetworkManager requestNewsSuccess:^(NSArray *news)
    {
        self.newsArr = news;
        [self.tableView reloadData];
    }
                                  failure:nil];
    
    _cellNib = [UINib nibWithNibName:@"ERTNewsCell" bundle:nil];
}

#pragma mark - UITableView Delegate Methods

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    ERTNewsCell* cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:ERT_NEWS_CELL_IDENTIFER];
    
    if (cell == nil)
    {
        cell = [_cellNib instantiateWithOwner:self options:nil][0];
    }
    
    cell.head = self.newsArr[indexPath.row][@"title"];
    cell.body = self.newsArr[indexPath.row][@"summary"];
    cell.date = [NSDate rtStyleToDate:self.newsArr[indexPath.row][@"time"]];
    cell.numberOfLike = [self.newsArr[indexPath.row][@"like_count"] integerValue];
    NSURL *url = [NSURL URLWithString:self.newsArr[indexPath.row][@"image"]];
    [cell.cellImageView setImageWithURL:url];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [ERTNewsCell heightCellForText:self.newsArr[indexPath.row][@"summary"] andWitdh:self.tableView.frame.size.width];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArr.count;
}

@end
