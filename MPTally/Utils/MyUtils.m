//
//  MPUtils.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MyUtils.h"

@implementation MyUtils

/**
 创建主键

 @return 主键
 */
+ (NSString *)createKey
{
  NSUUID *uid = [NSUUID UUID];
  return uid.UUIDString;
}

/**
 将数字转为字符串
 
 @param num 数字
 @return 数字字符串
 */
+ (NSString *)numToString:(double)num
{
  return [NSString stringWithFormat:@"%.2lf", num];
}

/**
 将yyyy-mm-dd格式的字符串转NSDate类型
 
 @param dateStr yyyy-mm-dd格式的字符串
 @return NSDate对象
 */
+ (NSDate *)dateStrToDate:(NSString *)dateStr
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd";
  return [fmt dateFromString:dateStr];
}

/**
 比较两个yyyy-mm-dd格式的日期字符串是否同年同月
 */
+ (BOOL)firstDateStr:(NSString *)dateStr1 isSameYearMonthNextDateStr:(NSString *)dateStr2
{
  // 比较月份是否相同
  NSString *month1 = [dateStr1 substringWithRange:NSMakeRange(0, 7)];
  NSString *month2 = [dateStr2 substringWithRange:NSMakeRange(0, 7)];

  return [month1 isEqualToString:month2];
}

@end
