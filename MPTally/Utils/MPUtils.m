//
//  MPUtils.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPUtils.h"

@implementation MPUtils

/**
 创建主键

 @return 主键
 */
+ (NSString *)createKey
{
  NSUUID *uid = [NSUUID UUID];
  return uid.UUIDString;
}

@end
