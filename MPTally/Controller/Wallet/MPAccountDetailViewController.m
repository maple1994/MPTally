//
//  MPAccountDetailViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountDetailViewController.h"
#import "MPAccountDetailHeaderView.h"
#import "MPBillManager.h"
#import "MPAccountBillTableViewCell.h"
#import "MPEditAccountMoneyViewController.h"
#import "MPCreateAccountViewController.h"
#import "MPBillDetailViewController.h"

@interface MPAccountDetailViewController ()<UITableViewDelegate, UITableViewDataSource, MPAccountDetailHeaderViewDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *topbarView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, weak) MPAccountDetailHeaderView *detailView;
/// 分组的账单模型数组
@property (nonatomic, strong) NSMutableArray *billGroupedArray;
/// 当前用户选择的日期
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation MPAccountDetailViewController

#pragma mark - UI
static NSString *BillCellID = @"BillCellID";

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(MPAccountBillTableViewCell.class) bundle:nil] forCellReuseIdentifier:BillCellID];
  [self setupUI];
  [self setupNav];
}

- (void)setupUI
{
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 176)];
  [self.tableView addSubview:self.tableHeaderView];
  [self.topbarView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.leading.trailing.equalTo(self.view);
    make.height.mas_equalTo(64);
  }];
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.topbarView.mas_bottom);
    make.leading.trailing.bottom.equalTo(self.view);
  }];
}

- (void)setupNav
{
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
  self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
  UILabel *label = [[UILabel alloc] init];
  label.text = _accountModel.accountName;
  label.textColor = [UIColor whiteColor];
  [label sizeToFit];
  self.navigationItem.titleView = label;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  [self.tableView reloadData];
  // 设置导航栏背景为透明
  [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
  // 隐藏导航栏底部黑线
  self.navigationController.navigationBar.shadowImage = [UIImage new];
  self.detailView.account = _accountModel;
  self.topbarView.backgroundColor = [UIColor colorWithHexString:_accountModel.colorStr];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  // 还原导航栏样式
  [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
  self.navigationController.navigationBar.shadowImage = nil;
  self.navigationController.navigationBar.tintColor = kNavTintColor;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

#pragma mark - private
- (void)setting
{
  MPCreateAccountViewController *vc = [[MPCreateAccountViewController alloc] init];
  vc.account = _accountModel;
  [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)sectionHeaderView:(MPBillModel *)bill
{
  UIView *header = [[UIView alloc] init];
  UILabel *dateLabel = [[UILabel alloc] init];
  dateLabel.textColor = [UIColor lightGrayColor];
  dateLabel.font = [UIFont systemFontOfSize:13];
  [header addSubview:dateLabel];
  [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(header).offset(10);
    make.bottom.equalTo(header);
  }];
  
  NSDate *date = [MyUtils dateStrToDate:bill.dateStr];
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"MM月dd日";
  dateLabel.text = [fmt stringFromDate:date];
  return header;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return self.billGroupedArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSArray *arr = self.billGroupedArray[section];
  return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  MPAccountBillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BillCellID];
  NSArray *arr = self.billGroupedArray[indexPath.section];
  MPBillModel *bill = arr[indexPath.row];
  cell.bill = bill;
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  NSArray *arr = self.billGroupedArray[section];
  MPBillModel *bill = arr.firstObject;
  UIView *headerView = [self sectionHeaderView:bill];
  return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  return 0.01;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSArray *tmp = self.billGroupedArray[indexPath.section];
  MPBillDetailViewController *vc = [[MPBillDetailViewController alloc] init];
  vc.bill = tmp[indexPath.row];
  [vc setDelteBlock:^(MPBillModel *bill) {
    [[MPBillManager shareManager] deleteBill:bill];
    self.billGroupedArray = nil;
  }];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - MPAccountDetailHeaderViewDelegate
- (void)accountDetailHeaderView:(MPAccountDetailHeaderView *)header didChangeDate:(NSDate *)date
{
  self.selectedDate = date;
  self.billGroupedArray = nil;
  [self.tableView reloadData];
}

- (void)accountDetailHeaderView:(MPAccountDetailHeaderView *)header didEditBalance:(UIButton *)button
{
  MPEditAccountMoneyViewController *vc = [[MPEditAccountMoneyViewController alloc] init];
  vc.banlance = _accountModel.money;
  [vc setBanlanceBlock:^(double balance) {
    [kRealm transactionWithBlock:^{
      _accountModel.money = balance;
      header.account = _accountModel;
    }];
  }];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (NSDate *)selectedDate
{
  if(_selectedDate == nil)
  {
    // 默认是当前日期
    _selectedDate = [NSDate date];
  }
  return _selectedDate;
}

- (NSMutableArray *)billGroupedArray
{
  if(_billGroupedArray == nil)
  {
    _billGroupedArray = [NSMutableArray array];
    NSMutableArray *group = [NSMutableArray array];
    RLMResults *results = [[MPBillManager shareManager] getBillsInAccount:_accountModel inAnMonth:self.selectedDate];
    if(results.count >= 1)
    {
      // 上一个bill模型
      MPBillModel *prebill = results.firstObject;
      [group addObject:prebill];
      for(int i = 1; i < results.count; i++)
      {
        MPBillModel *bill = results[i];
        if([prebill.dateStr isEqualToString:bill.dateStr])
        {
          // 相同日期，加入到同一group中
          [group addObject:bill];
        }
        else
        {
          // 不同日期
          [_billGroupedArray addObject:group];
          // 创建新的组
          group = [NSMutableArray array];
          [group addObject:bill];
          prebill = bill;
        }
      }
      if(group.count > 0)
        [_billGroupedArray addObject:group];
    }
  }
  
  return _billGroupedArray;
}


- (UIView *)tableHeaderView
{
  if(_tableHeaderView == nil)
  {
    _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 176 - 480, kScreenW, 480)];
    _tableHeaderView.backgroundColor = [UIColor colorWithHexString:self.accountModel.colorStr];
    MPAccountDetailHeaderView *detailView = [MPAccountDetailHeaderView viewFromNib];
    detailView.account = _accountModel;
    self.detailView = detailView;
    detailView.delegate = self;
    [_tableHeaderView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.trailing.bottom.equalTo(_tableHeaderView);
      make.height.mas_equalTo(176);
    }];
  }
  return _tableHeaderView;
}

- (UITableView *)tableView
{
  if(_tableView == nil)
  {
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    view.delegate = self;
    view.dataSource = self;
    view.backgroundColor = colorWithRGB(245, 245, 245);
    view.rowHeight = 50;
    view.separatorColor = colorWithRGB(240, 240, 240);
    _tableView = view;
    [self.view addSubview:view];
  }
  return _tableView;
}

- (UIView *)topbarView
{
  if(_topbarView == nil)
  {
    UIView *view = [[UIView alloc] init];
    _topbarView = view;
    _topbarView.backgroundColor = [UIColor colorWithHexString:_accountModel.colorStr];
    [self.view addSubview:view];
  }
  return _topbarView;
}

@end
