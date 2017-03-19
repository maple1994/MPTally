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
 根据日期字符串dateStr，查询其一个月的支出，与收入
 
 @param dateStr 日期字符串 yyyy-MM-dd
 */
- (instancetype)initWithDateStr:(NSString *)dateStr
{
  if(self = [super init])
  {
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
