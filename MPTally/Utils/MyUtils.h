//
//  MPUtils.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 存放一些常用的方法
@interface MyUtils : NSObject

/**
 创建主键
 
 @return 主键
 */
+ (NSString *)createKey;

/**
 将数字转为字符串

 @param num 数字
 @return 数字字符串
 */
+ (NSString *)numToString:(double)num;

/**
 将yyyy-mm-dd格式的字符串转NSDate类型

 @param dateStr yyyy-mm-dd格式的字符串
 @return NSDate对象
 */
+ (NSDate *)dateStrToDate:(NSString *)dateStr;

@end
