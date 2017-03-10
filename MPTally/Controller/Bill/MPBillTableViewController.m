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

@interface MPBillTableViewController ()

@property (nonatomic, strong) RLMResults *billModelArray;

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

- (RLMResults *)billModelArray
{
  if(_billModelArray == nil)
  {
    _billModelArray = [MPBillModel allObjects];
  }
  return _billModelArray;
}

@end
