//
//  NSDate+MPPrint.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "NSDate+MPPrint.h"

@implementation NSDate (MPPrint)

/**
 获得格式化后的字符串date
 
 @return yyyy-MM-dd 格式的字符串
 */
- (NSString *)dateFormattrString
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd";
  return [fmt stringFromDate:self];
}

/**
 获取yyyy-MM格式的字符串date
 
 @return yyyy-MM字符串
 */
- (NSString *)getYearMonthDateString
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM";
  return [fmt stringFromDate:self];
}

/**
 获取yyyy格式的字符串date
 
 @return yyyy字符串
 */
- (NSString *)getYearDateString
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy";
    return [fmt stringFromDate:self];
}

@end
