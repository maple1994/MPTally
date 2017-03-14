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
#import "MPBookListView.h"

@interface MPBillTableViewController ()<UITableViewDelegate, UITableViewDataSource>

/// 从数据库查询的Bill数据
@property (nonatomic, strong) RLMResults *billModelArray;
/// tableView的Header
@property (nonatomic, strong) MPTimeLineHeaderView *headerView;
/// Realm通知token
@property (nonatomic, strong) RLMNotificationToken *token;
/// 时间线数组
@property (nonatomic, strong) NSMutableArray *timeLineModelArray;
@property (nonatomic, weak) UITableView *tableView;

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
//  [self resetData];
  [self setupNav];
}

- (void)setupNav
{
  UIButton *button = [[UIButton alloc] init];
  [button setTitle:@"默认账本" forState:UIControlStateNormal];
  [button sizeToFit];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.titleView = button;
}

- (void)buttonClick
{
  
}

- (void)resetData
{
//  self.timeLineModelArray = [[MPTimeLineModel alloc] getModelArrayWithResults:self.billModelArray];
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
    dayCell.dayBill = model.dayBill;
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

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//  CGFloat offy = scrollView.contentOffset.y;
//  NSInteger index = offy / 75;
//  
//}

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

- (UITableView *)tableView
{
  if(_tableView == nil)
  {
    UITableView *view = [[UITableView alloc] init];
    view.delegate = self;
    view.dataSource = self;
    _tableView = view;
    [self.view addSubview:view];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.view);
    }];
  }
  return _tableView;
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
