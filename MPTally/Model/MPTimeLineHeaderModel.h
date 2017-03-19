//
//  MPTimeLineHeaderModel.h
//  MPTally
//
//  Created by Maple on 2017/3/17.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 时间线头部的模型
@interface MPTimeLineHeaderModel : NSObject

/// 月份
@property (nonatomic, copy) NSString *monthStr;
/// 支出
@property (nonatomic, assign) double outcome;
/// 收入
@property (nonatomic, assign) double income;

/**
 根据日期字符串dateStr，查询其一个月的支出，与收入

 @param dateStr 日期字符串 yyyy-MM-dd
 */
- (instancetype)initWithDateStr:(NSString *)dateStr;

@end
