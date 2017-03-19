//
//  MPCreateWalletViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateWalletViewController.h"
#import "MPEditAccountNameViewController.h"
#import "MPEditAccountMoneyViewController.h"
#import "MPEditAccountColorViewController.h"
#import "MPEditAccountTableViewCell.h"
#import "MPAccountManager.h"

@interface MPCreateWalletViewController ()

@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, assign) double balance;
@property (nonatomic, copy) NSString *accountColor;

@end

@implementation MPCreateWalletViewController

static NSString *CellID = @"CellID";

- (instancetype)init
{
  return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupNav];
  [self.tableView registerClass:[MPEditAccountTableViewCell class] forCellReuseIdentifier:CellID];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self.tableView reloadData];
}

- (void)setupNav
{
  self.title = @"新建账户";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
}

- (void)confirm
{
  if(!self.accountName)
  {
    [SVProgressHUD showTips:@"请填写账户名称"];
    return;
  }
  MPAccountModel *account = [[MPAccountModel alloc] init];
  account.accountName = _accountName;
  account.money = _balance;
  account.colorStr = _accountColor;
  [[MPAccountManager shareManager] insertAccount:account];
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  MPEditAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
  
  if(indexPath.row == 0)
  {
    cell.myTitle = @"账户名称";
  }
  else if(indexPath.row == 1)
  {
    cell.myTitle = @"金额";
    cell.myDetailTitle = [MyUtils numToString:self.balance];
  }
  else if(indexPath.row == 2)
  {
    cell.myTitle = @"账户颜色";
    cell.selectedColor = self.accountColor;
  }
  return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row == 0)
  {
    // 账户名称
    MPEditAccountNameViewController *vc = [[MPEditAccountNameViewController alloc] init];
    vc.accountName = self.accountName;
    [vc setDoneBlock:^(NSString *accountName) {
      self.accountName = accountName;
    }];
    [self.navigationController pushViewController:vc animated:YES];
  }
  else if(indexPath.row == 1)
  {
    // 金额
    MPEditAccountMoneyViewController *vc = [[MPEditAccountMoneyViewController alloc] init];
    vc.banlance = self.balance;
    [vc setBanlanceBlock:^(double balance) {
      self.balance = balance;
    }];
    [self.navigationController pushViewController:vc animated:YES];
  }
  else if(indexPath.row == 2)
  {
    // 账户颜色
    MPEditAccountColorViewController *vc = [[MPEditAccountColorViewController alloc] init];
    vc.hexColor = self.accountColor;
    [vc setDidSelectColor:^(NSString *hexColor) {
      self.accountColor = hexColor;
    }];
    [self.navigationController pushViewController:vc animated:YES];
  }
}

#pragma mark - getter
- (NSString *)accountColor
{
  if(_accountColor == nil)
  {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"color.plist" ofType:nil];
    NSArray *colorArr = [NSArray arrayWithContentsOfFile:path];
    _accountColor = colorArr.firstObject;
  }
  return _accountColor;
}


@end
