//
//  MPTrendModel.h
//  MPTally
//
//  Created by Maple on 2017/3/31.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 报表趋势模型
@interface MPTrendModel : NSObject

/// 月份
@property (nonatomic, copy) NSString *month;
/// 收入
@property (nonatomic, assign) double income;
/// 支出
@property (nonatomic, assign) double outcome;
/// 结余
@property (nonatomic, assign) double balance;

/**
 返回指定年份的趋势模型数组（一年）

 @param date 日期对象，指定年份
 @return 一年内的模型数组
 */
+ (NSArray *)modelArrayWithDate:(NSDate *)date;

@end
