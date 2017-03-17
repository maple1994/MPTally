//
//  MPTimeLineHeaderModel.m
//  MPTally
//
//  Created by Maple on 2017/3/17.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTimeLineHeaderModel.h"
#import "MPBookManager.h"

@implementation MPTimeLineHeaderModel

/**
 根据MPBill模型，查询其一个月的支出，与收入
 
 @param bill MPBillModel
 */
- (instancetype)initWithBill:(MPBillModel *)bill
{
  if(self = [super init])
  {
    NSString *dateStr = bill.dateStr;
    NSString *monthStr = [dateStr substringWithRange:NSMakeRange(0, 7)];
    MPBookModel *book = [MPBookManager shareManager].getCurrentBook;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateStr BEGINSWITH %@ and book.bookID=%@", monthStr, book.bookID];
    RLMResults *billInSameMonth = [MPBillModel objectsWithPredicate:predicate];
    double incomeSum = 0;
    double outcomeSum = 0;
    for (MPBillModel *bill in billInSameMonth)
    {
      if(bill.isIncome)
        incomeSum += bill.money;
      else
        outcomeSum += bill.money;
    }
    self.income = incomeSum;
    self.outcome = outcomeSum;
    // 取出字符串当前是几月份
    NSDate *date = [MyUtils dateStrToDate:dateStr];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"M月";
    self.monthStr = [fmt stringFromDate:date];
  }
  return self;
}

@end
