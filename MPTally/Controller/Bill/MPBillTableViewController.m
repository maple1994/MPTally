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
#import "MPBookManager.h"
#import "MPTimeLineDayTableViewCell.h"
#import "MPTimeLineModel.h"

@interface MPBillTableViewController ()

/// 从数据库查询的Bill数据
@property (nonatomic, strong) RLMResults *billModelArray;
/// tableView的Header
@property (nonatomic, strong) MPTimeLineHeaderView *headerView;
/// Realm通知token
@property (nonatomic, strong) RLMNotificationToken *token;
/// 时间线数组
@property (nonatomic, strong) NSMutableArray *timeLineModelArray;

@end

@implementation MPBillTableViewController

static NSString *ItemCellID = @"ItemCellID";
static NSString *DayCellID = @"DayCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.tableView.rowHeight = 75;
  [self setupnNotificationToken];
  
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.tableView registerClass:MPTimeLineItemTableViewCell.class forCellReuseIdentifier:ItemCellID];
  [self.tableView registerClass:MPTimeLineDayTableViewCell.class forCellReuseIdentifier:DayCellID];
  [self resetData];
}

- (void)resetData
{
  self.timeLineModelArray = [MPTimeLineModel timeLineArrayWithResults:self.billModelArray];
  [self.tableView reloadData];
}

- (void)setupnNotificationToken
{
  __weak typeof(self)weakSelf = self;
  self.token = [self.billModelArray addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
    [weakSelf resetData];
  }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.timeLineModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  MPTimeLineModel *model = self.timeLineModelArray[indexPath.row];
  if(model.type == TimeLineDayItem)
  {
    MPTimeLineDayTableViewCell *dayCell = [tableView dequeueReusableCellWithIdentifier:DayCellID];
    dayCell.dateStr = model.dateStr;
    return dayCell;
  }
  else
  {
    MPTimeLineItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ItemCellID];
    cell.bill = model.bill;
    return cell;

  }
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
    MPBookModel *book = [[MPBookManager shareManager] getCurrentBook];
    _billModelArray = [MPBillModel objectsWhere:@"book=%@", book];
    
    // 首先根据dateStr（账单时间）进行排序
    RLMSortDescriptor *desc1 = [RLMSortDescriptor sortDescriptorWithKeyPath:@"dateStr" ascending:NO];
    // 再根据recordDate（记录时间）进行排序
    RLMSortDescriptor *desc2 = [RLMSortDescriptor sortDescriptorWithKeyPath:@"recordDate" ascending:NO];
    _billModelArray = [_billModelArray sortedResultsUsingDescriptors:@[desc1, desc2]];
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
