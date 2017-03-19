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

@interface MPCreateWalletViewController ()

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
}

- (void)setupNav
{
  self.title = @"新建账户";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirm)];
}

- (void)confirm
{
  
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
  if(cell == nil)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
  }
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.textLabel.font = [UIFont systemFontOfSize:15];
  if(indexPath.row == 0)
  {
    cell.textLabel.text = @"账户名称";
  }
  else if(indexPath.row == 1)
  {
    cell.textLabel.text = @"金额";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.text = @"0.00";
  }
  else if(indexPath.row == 2)
  {
    cell.textLabel.text = @"账户颜色";
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
    [self.navigationController pushViewController:vc animated:YES];
  }
  else if(indexPath.row == 1)
  {
    // 金额
    MPEditAccountMoneyViewController *vc = [[MPEditAccountMoneyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
  }
  else if(indexPath.row == 2)
  {
    // 账户颜色
    MPEditAccountColorViewController *vc = [[MPEditAccountColorViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
  }

}


@end
