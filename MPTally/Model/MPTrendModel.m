//
//  MPTrendModel.m
//  MPTally
//
//  Created by Maple on 2017/3/31.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTrendModel.h"
#import "MPBillManager.h"

@implementation MPTrendModel

/**
 返回指定年份的趋势模型数组（一年）
 
 @param date 日期对象，指定年份
 @return 一年内的模型数组
 */
+ (NSArray *)modelArrayWithDate:(NSDate *)date
{
    RLMResults *results = [[MPBillManager shareManager] getBillsInSameYear:date];
    // 判断月份是否已存在
    NSMutableSet *set = [NSMutableSet set];
    // 记录月份的数组
    NSMutableArray *monthArray = [NSMutableArray array];
    for (MPBillModel *bill in results)
    {
        // 取出yyyy-MM的字符串
        NSString *month = [bill.dateStr substringWithRange:NSMakeRange(0, 7)];
        if(![set containsObject:month])
        {
            [set addObject:month];
            [monthArray addObject:month];
        }
    }
    NSMutableArray *modelArray = [NSMutableArray array];
    // 根据已有的月份，创建模型数组
    for (NSString *monthStr in monthArray)
    {
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateStr BEGINSWITH %@", monthStr];
        RLMResults *billsInMonth = [results objectsWithPredicate:predicate];
        MPTrendModel *model = [[MPTrendModel alloc] init];
        double income = 0;
        double outcome = 0;
        for (MPBillModel *bill in billsInMonth) {
            if(bill.isIncome)
            {
                income += bill.money;
            }
            else
            {
                outcome += bill.money;
            }
        }
        model.income = income;
        model.outcome = outcome;
        model.balance = income - outcome;
        model.month = monthStr;
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
