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

@end
