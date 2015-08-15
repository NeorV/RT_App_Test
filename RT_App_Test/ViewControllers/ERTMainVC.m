//
//  ViewController.m
//  RT_App_Test
//
//  Created by Sergey Yefanov on 15.08.15.
//  Copyright (c) 2015 Sergey Yefanov. All rights reserved.
//

#import "ERTMainVC.h"
#import "ERTNewsCell.h"

static NSString * const ERT_NEWS_CELL_IDENTIFER = @"ERT_NEWS_CELL_IDENTIFER";

@interface ERTMainVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic)                UINib       *cellNib;

@end

@implementation ERTMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    cell.head = @"Заголовок";
    cell.body = @"Тут будет новость";
    cell.date = [NSDate date];
    cell.numberOfLike = 5;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end
