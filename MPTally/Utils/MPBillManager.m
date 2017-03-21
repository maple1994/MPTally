//
//  MPBillManager.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBillManager.h"
#import "MPBookManager.h"

@implementation MPBillManager

static id instance;

#pragma mark - Public
#pragma mark Get
+ (instancetype)shareManager
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

/**
 获取该账本指定年月的账单列表
 
 @param account 要查询的账本
 @param date 指定年月
 @return MPBillModel账单列表
 */
- (RLMResults *)getBillInAccount:(MPAccountModel *)account inAnMonth:(NSDate *)date
{
  // 获取当前的账本
  MPBookModel *book = [[MPBookManager shareManager] getCurrentBook];
  // 生成yyyy-MM格式的字符串
  NSString *dateStr = [date getYearMonthDateString];
  // 查询指定账本，月份，账户的结果集
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateStr BEGINSWITH %@ and book.bookID=%@ and account.accountID=%@", dateStr, book.bookID, account.accountID];
  RLMResults *result = [MPBillModel objectsWithPredicate:predicate];
  // 返回排序后的结果
  return [self sortTheResultsByDate:result];
}

#pragma mark Write
/**
 插入一条账单
 
 @param bill MPBillModel
 */
- (void)insertBill:(MPBillModel *)bill
{
  bill.billID = [MyUtils createKey];
  bill.recordDate = [NSDate date];
  [kRealm transactionWithBlock:^{
    [MPBillModel createInDefaultRealmWithValue:bill];
    // 设置对应账单的金额
    
  }];
}

/**
 删除账单
 
 @param bill 要删除的账单
 */
- (void)deleteBill:(MPBillModel *)bill
{
  [kRealm transactionWithBlock:^{
    [kRealm deleteObject:bill];
  }];
}

#pragma mark - Private
/**
 根据时间，对结果集进行排序

 @param results 结果集
 @return 排序后的结果集
 */
- (RLMResults *)sortTheResultsByDate:(RLMResults *)results
{
  // 首先根据dateStr（账单时间）进行排序
  RLMSortDescriptor *desc1 = [RLMSortDescriptor sortDescriptorWithKeyPath:@"dateStr" ascending:NO];
  // 再根据recordDate（记录时间）进行排序
  RLMSortDescriptor *desc2 = [RLMSortDescriptor sortDescriptorWithKeyPath:@"recordDate" ascending:NO];
  return [results sortedResultsUsingDescriptors:@[desc1, desc2]];
}

@end
