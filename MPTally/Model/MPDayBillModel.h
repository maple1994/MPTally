//
//  MPDayBillModel.h
//  MPTally
//
//  Created by Maple on 2017/3/13.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 一天的消费模型
@interface MPDayBillModel : NSObject
/// 日期字符串
@property (nonatomic, copy) NSString *dateStr;
/// 收入
@property (nonatomic, assign) double income;
///支出
@property (nonatomic, assign) double outcome;

/**
 根据账单模型，日期创建对象

 @param billArray 账单模型数组
 @param dayStr 日期字符串
 @return MPDayBillModel
 */
+ (instancetype)dayBill:(NSArray *)billArray dateStr:(NSString *)dayStr;

- (void)calculatIncomeAndOutcome:(NSArray *)billArray;

@end
