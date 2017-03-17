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
#import "MPTopBarView.h"
#import "MPTableView.h"
#import "MPBillManager.h"
#import "MPCreateBillViewController.h"
#import "MPTimeLineHeaderModel.h"

@interface MPBillTableViewController ()<UITableViewDelegate, UITableViewDataSource, TopBarViewDelegate, MPBookListViewDelegate, MPTimeLineItemTableViewCellDelegate>

/// 从数据库查询的Bill数据
@property (nonatomic, strong) RLMResults *billModelArray;
/// tableView的Header
@property (nonatomic, strong) MPTimeLineHeaderView *headerView;
/// Realm通知token
@property (nonatomic, strong) RLMNotificationToken *token;
/// 时间线数组
@property (nonatomic, strong) NSMutableArray *timeLineModelArray;
/// 替代导航栏的
@property (nonatomic, weak) MPTopBarView *topBarView;
/// 账本容器
@property (nonatomic, weak) MPBookListView *bookListView;
/// 账本列表的高度
@property (nonatomic, assign) CGFloat bookListViewH;
/// 当显示账本列表时，列表下隐藏的control
@property (nonatomic, weak) UIControl *ctrl;
/// 记录处于编辑状态的Cell
@property (nonatomic, weak) MPTimeLineItemTableViewCell *editingCell;
@property (nonatomic, weak) MPTableView *tableView;

@end

@implementation MPBillTableViewController

static NSString *ItemCellID = @"ItemCellID";
static NSString *DayCellID = @"DayCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self setupUI];
  self.tableView.rowHeight = 75;
  [self setupnNotificationToken];
  
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.tableView registerClass:MPTimeLineItemTableViewCell.class forCellReuseIdentifier:ItemCellID];
  [self.tableView registerClass:MPTimeLineDayTableViewCell.class forCellReuseIdentifier:DayCellID];
//  [self resetData];
  [self setupNav];
}

- (void)setupUI
{
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self.bookListView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view.mas_top);
    make.leading.trailing.equalTo(self.view);
    make.height.mas_equalTo(_bookListViewH);
  }];
  [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.bookListView.mas_bottom);
    make.leading.trailing.equalTo(self.view);
    make.height.mas_equalTo(44);
  }];
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.topBarView.mas_bottom);
    make.leading.trailing.bottom.equalTo(self.view);
  }];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self.navigationController setNavigationBarHidden:NO];
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
  kFuncNameLog;
  [self.tabBarController.tabBar setHidden:!self.tabBarController.tabBar.isHidden];
}

- (void)resetData
{
  MPTimeLineHeaderModel *model = [[MPTimeLineHeaderModel alloc] initWithBill:self.billModelArray.firstObject];
  self.headerView.model = model;
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

/// 添加遮罩
- (void)addHUD
{
  UIControl *ctrl = [[UIControl alloc] init];
  [self.view addSubview:ctrl];
  [ctrl addTarget:self action:@selector(removeHUD:) forControlEvents:UIControlEventTouchUpInside];
  [ctrl mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.bookListView.mas_bottom);
    make.leading.trailing.bottom.equalTo(self.view);
  }];
  self.ctrl = ctrl;
}

/// 去除遮罩
- (void)removeHUD:(UIControl *)ctrl
{
  [ctrl removeFromSuperview];
  [self.bookListView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view.mas_top);
  }];
  [UIView animateWithDuration:0.25 animations:^{
    [self.view layoutIfNeeded];
    [self.tabBarController.tabBar setHidden:NO];
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
    cell.delegate = self;
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  // 在滚动的时候隐藏cell的编辑视图
  for (UITableViewCell *cell in self.tableView.visibleCells)
  {
    if([cell isKindOfClass:[MPTimeLineItemTableViewCell class]])
    {
      MPTimeLineItemTableViewCell *cell1 = (MPTimeLineItemTableViewCell *)cell;
      [cell1 hideEditView];
    }
  }
}

#pragma mark - MPTimeLineItemTableViewCellDelegate
- (void)timeLineItemCellDidShowEditView:(MPTimeLineItemTableViewCell *)cell
{
  self.editingCell = cell;
}

- (void)timeLineItemCellDidClickEdit:(MPTimeLineItemTableViewCell *)cell
{
  MPCreateBillViewController *vc = [[MPCreateBillViewController alloc] init];
  vc.selectedBill = cell.bill;
  [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

- (void)timeLineItemCellDidClickDelete:(MPTimeLineItemTableViewCell *)cell
{
  [[MPBillManager shareManager] deleteBill:cell.bill];
}

#pragma mark - MPBookListViewDelegate
- (void)bookListView:(MPBookListView *)listView didChangeBook:(MPBookModel *)book
{
  // 切换账本，重新设置数据
  [self removeHUD:self.ctrl];
  [[MPBookManager shareManager] setCurrentBook:book];
  self.billModelArray = nil;
  self.token = nil;
  [self resetData];
  [self setupnNotificationToken];
}

#pragma mark - TopBarViewDelegate
- (void)topBarView:(MPTopBarView *)topBar didClickTitleButton:(UIButton *)button
{
  [self.bookListView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self.view.mas_top).offset(_bookListViewH);
  }];
  [self addHUD];
  [UIView animateWithDuration:0.25 animations:^{
    [self.view layoutIfNeeded];
    [self.tabBarController.tabBar setHidden:YES];
  }];
}

#pragma mark - getter or setter
- (void)setEditingCell:(MPTimeLineItemTableViewCell *)editingCell
{
  [_editingCell hideEditView];
  _editingCell = editingCell;
}
- (MPBookListView *)bookListView
{
  if(_bookListView == nil)
  {
    CGFloat itemW = (kScreenW - 5 * 10) / 4.0;
    CGFloat itemH = itemW * 1.35;
    self.bookListViewH = ceilf(itemH) + 30;
    MPBookListView *view = [[MPBookListView alloc] initWithItemSize:CGSizeMake(ceilf(itemW), ceilf(itemH))];
    _bookListView = view;
    view.delegate = self;
    _bookListView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
  }
  return _bookListView;
}

- (MPTopBarView *)topBarView
{
  if(_topBarView == nil)
  {
    MPTopBarView *view = [[MPTopBarView alloc] init];
    view.delegate = self;
    _topBarView = view;
    [self.view addSubview:view];
  }
  return _topBarView;
}


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

- (MPTableView *)tableView
{
  if(_tableView == nil)
  {
    MPTableView *view = [[MPTableView alloc] init];
    view.delegate = self;
    view.dataSource = self;
    _tableView = view;
    [self.view addSubview:view];
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
