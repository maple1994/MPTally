//
//  MPWalletTableViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPWalletTableViewController.h"
#import "MPWalletTableViewCell.h"
#import "MPWalletBalanceHeaderView.h"
#import "MPAccountManager.h"

#define kRowHeight 60

@interface MPWalletTableViewController ()

/// 余额Header
@property (nonatomic, strong) MPWalletBalanceHeaderView *balanceHeaderView;
/// 模型数组
@property (nonatomic, strong) RLMResults *accountArray;

@end

@implementation MPWalletTableViewController

static NSString *WalletCellID = @"WalletCellID";

- (instancetype)init
{
  return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(MPWalletTableViewCell.class) bundle:nil] forCellReuseIdentifier:WalletCellID];
  self.tableView.rowHeight = kRowHeight;
  self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accountArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WalletCellID forIndexPath:indexPath];
  cell.account = self.accountArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  return self.balanceHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return kRowHeight;
}

#pragma mark - get
- (RLMResults *)accountArray
{
  if(_accountArray == nil)
  {
    _accountArray = [[MPAccountManager shareManager] getAccountList];
  }
  return _accountArray;
}

- (MPWalletBalanceHeaderView *)balanceHeaderView
{
  if(_balanceHeaderView == nil)
  {
    _balanceHeaderView = [MPWalletBalanceHeaderView viewFromNib];
  }
  return _balanceHeaderView;
}

@end
