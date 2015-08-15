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
#import "UIImageView+AFNetworking.h"
#import "LTBookRefreshControl.h"
#import "ERTNews.h"

static NSString * const ERT_NEWS_CELL_IDENTIFER = @"ERT_NEWS_CELL_IDENTIFER";

@interface ERTMainVC () <UITableViewDelegate, UITableViewDataSource, LTRefreshControlDelegate>

@property (nonatomic, weak) IBOutlet UITableView                *tableView;
@property (nonatomic)                UINib                      *cellNib;
@property (nonatomic)                NSArray                    *newsArr;
@property (nonatomic)                LTBookRefreshControl       *refreshControl;

@end

@implementation ERTMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initRefreshHeader];
    [self requestNews];
    
    _cellNib = [UINib nibWithNibName:@"ERTNewsCell" bundle:nil];
}

- (void)_initRefreshHeader
{
    if (_refreshControl == nil)
    {
        _refreshControl = [[LTBookRefreshControl alloc] initWithScrollView:_tableView delegate:self];
        _refreshControl.topEnabled = YES;
        _refreshControl.inFrontOfScroll = YES;
        _refreshControl.offsetYForBook = 20;
    }
}

#pragma mark - UITableView DataSource

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    ERTNewsCell* cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:ERT_NEWS_CELL_IDENTIFER];
    
    if (cell == nil)
    {
        cell = [_cellNib instantiateWithOwner:self options:nil][0];
    }
    
    ERTNews *news = self.newsArr[indexPath.row];
    
    cell.head = news.title;
    cell.body = news.summary;
    cell.date = [NSDate rtStyleToDate:news.time];
    cell.numberOfLike = news.likeCount.integerValue;
    NSURL *imageUrl = [NSURL URLWithString:news.image];
    [cell.cellImageView setImageWithURL:imageUrl];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArr.count;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ERTNews *news = self.newsArr[indexPath.row];
    return [ERTNewsCell heightCellForText:news.summary andWitdh:self.tableView.frame.size.width];
}

#pragma mark - Refresh Controll

- (void)refreshControlDidEngageRefresh:(LTBookRefreshControl *)refreshControl
{
    [self requestNews];
}

#pragma mark - Request News

- (void)requestNews
{
    [ERTNetworkManager requestNewsSuccess:^(NSArray *news)
     {
         self.newsArr = news;
         [self.tableView reloadData];
         [self.refreshControl finishRefreshing];
     }
                                  failure:^(NSError *error)
     {
         [self.refreshControl finishRefreshing];
     }];
}

@end
