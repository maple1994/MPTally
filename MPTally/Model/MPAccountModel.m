//
//  MPAccountModel.m
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountModel.h"

@implementation MPAccountModel

- (NSString *)description
{
  NSString *desc = [NSString stringWithFormat:@"name:%@, money:%lf", _accountName, _money];
  return desc;
}

@end
