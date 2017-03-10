//
//  MPBillTableViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBillTableViewController.h"
#import "MPCategoryManager.h"
#import "MPTimeLineItemTableViewCell.h"
#import "MPTimeLineHeaderView.h"

@interface MPBillTableViewController ()

@property (nonatomic, strong) RLMResults *billModelArray;
@property (nonatomic, strong) MPTimeLineHeaderView *headerView;

@end

@implementation MPBillTableViewController

static NSString *ItemCellID = @"ItemCellID";
- (void)viewDidLoad
{
    [super viewDidLoad];
  self.tableView.rowHeight = 75;
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.tableView registerClass:MPTimeLineItemTableViewCell.class forCellReuseIdentifier:ItemCellID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.billModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  MPTimeLineItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemCellID];
  cell.bill = self.billModelArray[indexPath.row];
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 100;
}

#pragma mark - getter
- (RLMResults *)billModelArray
{
  if(_billModelArray == nil)
  {
    _billModelArray = [MPBillModel allObjects];
  }
  return _billModelArray;
}

- (MPTimeLineHeaderView *)headerView
{
  if(_headerView == nil)
  {
    _headerView = [[MPTimeLineHeaderView alloc] init];
    _headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
  }
  return _headerView;
}

@end
