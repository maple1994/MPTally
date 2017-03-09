//
//  MPBillManager.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBillManager.h"

@implementation MPBillManager

static MPBillManager *instance;

+ (instancetype)sharedManager
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

@end
