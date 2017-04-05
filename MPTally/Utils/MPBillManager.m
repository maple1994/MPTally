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

- (RLMResults *)getBillsInCurrentBook
{
  MPBookModel *book = [[MPBookManager shareManager] getCurrentBook];
  RLMResults *results = [MPBillModel objectsWhere:@"book=%@", book];
  // 返回排序后的结果集
  return [self sortTheResultsByDate:results];
}

/**
 获取该账本指定年月的账单列表
 
 @param account 要查询的账本
 @param date 指定年月
 @return MPBillModel账单列表
 */
- (RLMResults *)getBillsInAccount:(MPAccountModel *)account inAnMonth:(NSDate *)date
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

/**
 在当前账本下，获取指定年月的所有账单记录
 
 @param date 指定年月的NSDate对象
 @return MPBillModel账单列表
 */
- (RLMResults *)getOutcomeBillsInSameYearMonth:(NSDate *)date
{
  return [self getBillsInSameYearMonth:date isIncome:NO];
}

/**
 在当前账本下，获取指定年月的所有收入账单记录
 
 @param date 指定年月的NSDate对象
 @return MPBillModel账单列表
 */
- (RLMResults *)getIncomeBillsInSameYearMonth:(NSDate *)date
{
  return [self getBillsInSameYearMonth:date isIncome:YES];
}

/**
 在当前账本下，获取指定年的所有账单记录
 
 @param date 指定年的NSDate对象
 @return MPBillModel账单列表
 */
- (RLMResults *)getBillsInSameYear:(NSDate *)date
{
    // 获取当前的账本
    MPBookModel *book = [[MPBookManager shareManager] getCurrentBook];
    // 生成yyyy-MM格式的字符串
    NSString *dateStr = [date getYearDateString];
    // 生成对应的谓语查询语句
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateStr BEGINSWITH %@ and book.bookID=%@", dateStr, book.bookID];
    RLMResults *results = [MPBillModel objectsWithPredicate:predicate];
    return [results sortedResultsUsingKeyPath:@"dateStr" ascending:NO];
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
    if(bill.isIncome)
    {
      bill.account.money += bill.money;
    }
    else
    {
      bill.account.money -= bill.money;
    }
  }];
}

/**
 删除账单
 
 @param bill 要删除的账单
 */
- (void)deleteBill:(MPBillModel *)bill
{
  [kRealm transactionWithBlock:^{
    // 设置对应账单的金额
    if(bill.isIncome)
    {
      bill.account.money -= bill.money;
    }
    else
    {
      bill.account.money += bill.money;
    }
    [kRealm deleteObject:bill];
  }];
}

/**
 更新账单
 
 @param oldBill 旧账单
 @param newBill 更新后的账单
 */
- (void)updateOldBill:(MPBillModel *)oldBill withNewBill:(MPBillModel *)newBill
{
  [kRealm transactionWithBlock:^{
    // 还原之前对Account的操作，将之前的支出，收入对应的减去
    if(oldBill.isIncome)
    {
      oldBill.account.money -= oldBill.money;
    }
    else
    {
      oldBill.account.money += oldBill.money;
    }
    // 设置新的Account
    if(newBill.isIncome)
    {
      newBill.account.money += newBill.money;
    }
    else
    {
      newBill.account.money -= newBill.money;
    }
    oldBill.account = newBill.account;
    oldBill.dateStr = newBill.dateStr;
    oldBill.book = newBill.book;
    oldBill.category = newBill.category;
    oldBill.remark = newBill.remark;
    oldBill.isIncome = newBill.isIncome;
    oldBill.money = newBill.money;
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

/**
 当前账本下，指定年月的账单列表

 @param date 指定的年月
 @param isIncome 收入 or 支出类型的账单
 @return 筛选后的结果
 */
- (RLMResults *)getBillsInSameYearMonth:(NSDate *)date isIncome:(BOOL)isIncome
{
  // 获取当前的账本
  MPBookModel *book = [[MPBookManager shareManager] getCurrentBook];
  // 生成yyyy-MM格式的字符串
  NSString *dateStr = [date getYearMonthDateString];
  // 生成对应的谓语查询语句
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateStr BEGINSWITH %@ and book.bookID=%@ and isIncome=%li", dateStr, book.bookID, isIncome];
  RLMResults *results = [MPBillModel objectsWithPredicate:predicate];
  return [results sortedResultsUsingKeyPath:@"category.categoryName" ascending:YES];
}

@end
