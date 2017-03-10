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

@interface MPBillTableViewController ()

@property (nonatomic, strong) RLMResults *billModelArray;
@property (nonatomic, strong) MPTimeLineHeaderView *headerView;
@property (nonatomic, strong) RLMNotificationToken *token;

@end

@implementation MPBillTableViewController

static NSString *ItemCellID = @"ItemCellID";
- (void)viewDidLoad
{
    [super viewDidLoad];
  self.tableView.rowHeight = 75;
  [self setupnNotificationToken];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.showsVerticalScrollIndicator = NO;
  [self.tableView registerClass:MPTimeLineItemTableViewCell.class forCellReuseIdentifier:ItemCellID];
}

- (void)setupnNotificationToken
{
  __weak typeof(self)weakSelf = self;
  self.token = [self.billModelArray addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
    if(error) {
      NSLog(@"打开realm数据库失败, %@", error);
    }
    /* 如果数据库的变化为空, 则仅仅刷新 tableView */
    if (!change) {
      [weakSelf.tableView reloadData];
    }
    
    // 如果变化不为空，则更新tableView的数据源，并刷新tableView
    [weakSelf.tableView beginUpdates];
    // 删除数据
    [weakSelf.tableView deleteRowsAtIndexPaths:[change deletionsInSection:0] withRowAnimation:UITableViewRowAnimationTop];
    // 添加数据
    [weakSelf.tableView insertRowsAtIndexPaths:[change insertionsInSection:0] withRowAnimation:UITableViewRowAnimationTop];
    // 刷新数据
    [weakSelf.tableView reloadRowsAtIndexPaths:[change modificationsInSection:0] withRowAnimation:UITableViewRowAnimationTop];
    // 结束更新
    [weakSelf.tableView endUpdates];
  }];
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
    
    
    RLMSortDescriptor *desc1 = [RLMSortDescriptor sortDescriptorWithKeyPath:@"dateStr" ascending:NO];
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
