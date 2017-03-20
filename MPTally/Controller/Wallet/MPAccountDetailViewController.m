//
//  MPAccountDetailViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountDetailViewController.h"

@interface MPAccountDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *topbarView;

@end

@implementation MPAccountDetailViewController

#pragma mark - UI
static NSString *BillCellID = @"BillCellID";

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BillCellID];
  [self setupUI];
  [self setupNav];
}

- (void)setupUI
{
  self.automaticallyAdjustsScrollViewInsets = NO;
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 176 - 480, kScreenW, 480)];
  headerView.backgroundColor = [UIColor colorWithHexString:self.accountModel.colorStr];
  self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 176)];
  [self.tableView addSubview:headerView];
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
  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
  [self.tableView reloadData];
  // 设置导航栏背景为透明
  [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
  // 隐藏导航栏底部黑线
  self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  // 还原导航栏样式
  [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
  self.navigationController.navigationBar.shadowImage = nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
  return UIStatusBarStyleLightContent;
}

#pragma mark - private
- (void)setting
{
  kFuncNameLog;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BillCellID];
  cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
  return cell;
}

#pragma mark - getter
- (UITableView *)tableView
{
  if(_tableView == nil)
  {
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    view.delegate = self;
    view.dataSource = self;
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
