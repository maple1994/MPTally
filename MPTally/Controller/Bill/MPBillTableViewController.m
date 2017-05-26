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
#import "MPDayBillModel.h"
#import "MPTimeLineYearMonthMarkView.h"

#define kRowHeight 75    // cell的行高
#define kTopNavBarH 44   // “导航栏"的高度
#define kHeaderViewH 100 // headerView的高度

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
/// 记录当前头部显示的年月
@property (nonatomic, copy) NSString *curYMDateStr;
/// 记录切换之前的年月
@property (nonatomic, copy) NSString *preYMDateStr;
@property (nonatomic, assign) CGFloat lastPosition;
@property (nonatomic, assign) CGFloat currentPostion;
@property (nonatomic, weak) MPTableView *tableView;

@end

@implementation MPBillTableViewController

static NSString *ItemCellID = @"ItemCellID";
static NSString *DayCellID = @"DayCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self setupUI];
  self.tableView.rowHeight = kRowHeight;
  [self setupnNotificationToken];
    self.navigationItem.title = @"";
  
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.tableView registerClass:MPTimeLineItemTableViewCell.class forCellReuseIdentifier:ItemCellID];
  [self.tableView registerClass:MPTimeLineDayTableViewCell.class forCellReuseIdentifier:DayCellID];
}
    
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    make.height.mas_equalTo(kTopNavBarH);
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

/// 重置数据
- (void)resetData
{
  [self resetHeaderView];
  self.timeLineModelArray = [MPTimeLineModel timeLineArrayWithResults:self.billModelArray];
  [self.tableView reloadData];
}

/// 重置月份Header的数据
- (void)resetHeaderView
{
  MPTimeLineHeaderModel *model = [[MPTimeLineHeaderModel alloc] initWithDateStr:self.curYMDateStr];
  self.headerView.model = model;

}

/// 设置数据库数据变化时的操作
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
    NSInteger index = indexPath.row + 1;
    if(index < self.timeLineModelArray.count)
    {
      MPTimeLineModel *nextModel = self.timeLineModelArray[index];
      if(nextModel.type == TimeLineDayItem)
      {
        // 判断是否同年同月
        if(![MyUtils firstDateStr:model.bill.dateStr isSameYearMonthNextDateStr:nextModel.dayBill.dateStr])
        {
          // 时间线显示月份
          cell.timeLineTime = nextModel.dayBill.dateStr;
        }
        else
        {
          // 时间线不显示月份
          cell.timeLineTime = nil;
        }
      }
      else
      {
        // 时间线不显示月份
        cell.timeLineTime = nil;
      }
    }
      if (indexPath.row == self.timeLineModelArray.count - 1) {
          cell.timeLineTime = nil;
      }
    return cell;

  }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return kHeaderViewH;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat offy = scrollView.contentOffset.y;
  if(offy < 0)
    return;
  // 计算当前顶部的Cell对应的下表
  NSInteger index = offy / kRowHeight;
  if(index < self.timeLineModelArray.count)
  {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    MPTimeLineItemTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    // 判断cell中的月份结点是否出现了
    if([cell isKindOfClass:[MPTimeLineItemTableViewCell class]] && cell.timeLineTime)
    {
      // 将月份结点坐标系转化为self.view的坐标系
      CGRect rectInSuperview = [cell.lineView convertRect:cell.lineView.dotView.frame toView:self.view];
      // 结点与headerView相交，计算结点时间的金额
      if(rectInSuperview.origin.y <= kHeaderViewH + kTopNavBarH)
      {
        if(cell.timeLineTime != _curYMDateStr)
        {
          _curYMDateStr = cell.timeLineTime;
          [self resetHeaderView];
        }
      }
      // 结点上半部分与headerView相交，计算该Cell的bill.dateStr的金额
      // 结点上半部分的 = categoryIconH(25) + 结点以上线条的长度(25 - 3)
      else if(rectInSuperview.origin.y > kHeaderViewH + kTopNavBarH && rectInSuperview.origin.y <= kHeaderViewH + kTopNavBarH + 47)
      {
        if(cell.bill.dateStr != _curYMDateStr)
        {
          _curYMDateStr = cell.bill.dateStr;
          [self resetHeaderView];
        }
      }
    }
  }
}

/// 结束滚动时调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  // 当scrollView快速滚动时，scrollViewDidScroll调用的不够频繁，因此里面计算header数据需要在滚动结束时，再进行一次判断
  CGFloat offy = scrollView.contentOffset.y;
  if(offy < 0)
    return;
  // 计算当前顶部的Cell对应的下标
  NSInteger index = offy / kRowHeight;
  if(index < self.timeLineModelArray.count)
  {
    // 找出离顶部最近的TimeLineNormalItem类型的模型，进行数据检查
    MPTimeLineModel *model = self.timeLineModelArray[index];
    while(model.type != TimeLineNormalItem && index + 1 < self.timeLineModelArray.count)
    {
      model = self.timeLineModelArray[++index];
      break;
    }
    if(model.bill.dateStr != _curYMDateStr)
    {
      _curYMDateStr = model.bill.dateStr;
      [self resetHeaderView];
    }
  }
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
    // 发送表单数据改变的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kBillsDataChangeNotification object:nil];
}

#pragma mark - MPBookListViewDelegate
- (void)bookListView:(MPBookListView *)listView didChangeBook:(MPBookModel *)book
{
  // 切换账本，重新设置数据
  [self removeHUD:self.ctrl];
  [[MPBookManager shareManager] setCurrentBook:book];
  self.billModelArray = nil;
  self.token = nil;
  self.curYMDateStr = nil;
  [self resetData];
  [self setupnNotificationToken];
    self.topBarView.title = book.bookName;
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

- (NSString *)curYMDateStr
{
  if(_curYMDateStr == nil)
  {
    MPBillModel *bill = self.billModelArray.firstObject;
    _curYMDateStr = bill.dateStr;
  }
  return _curYMDateStr;
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
    _billModelArray = [[MPBillManager shareManager] getBillsInCurrentBook];
  }
  return _billModelArray;
}

- (MPTableView *)tableView
{
  if(_tableView == nil)
  {
    MPTableView *view = [[MPTableView alloc] init];
    view.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
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
