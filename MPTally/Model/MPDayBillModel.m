//
//  MPDayBillModel.m
//  MPTally
//
//  Created by Maple on 2017/3/13.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPDayBillModel.h"

@implementation MPDayBillModel

/**
 根据账单模型，日期创建对象
 
 @param billArray 账单模型数组
 @param dayStr 日期字符串
 @return MPDayBillModel
 */
+ (instancetype)dayBill:(NSArray *)billArray dateStr:(NSString *)dayStr
{
  MPDayBillModel *model = [[MPDayBillModel alloc] init];
  double income = 0.0;
  double outcome = 0.0;
  for (MPBillModel *bill in billArray)
  {
    if(bill.isIncome)
      income += bill.money;
    else
      outcome += bill.money;
  }
  model.dateStr = dayStr;
  model.income = income;
  model.outcome = outcome;
  return model;
}

- (void)calculatIncomeAndOutcome:(NSArray *)billArray
{
  double income = 0.0;
  double outcome = 0.0;

  for (MPBillModel *bill in billArray)
  {
    if(bill.isIncome)
      income += bill.money;
    else
      outcome += bill.money;
  }
  self.income = income;
  self.outcome = outcome;

}

@end
