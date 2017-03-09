//
//  MPAccountModel.m
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountModel.h"

@implementation MPAccountModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
  if (self = [super init])
  {
    [self setValuesForKeysWithDictionary:dic];
  }
  return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}

/// 返回默认的账户列表
+ (NSArray *)defaultAccountList
{
  NSString *path = [[NSBundle mainBundle]pathForResource:@"account" ofType:@"plist"];
  NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
  NSMutableArray *tempArray = [NSMutableArray array];
  
  for (NSDictionary *dic in dicArray)
  {
    MPAccountModel *category = [[MPAccountModel alloc] initWithDic:dic];
    [tempArray addObject:category];
  }
  return tempArray;

}

+ (NSString *)primaryKey
{
  return @"accountID";
}

- (NSString *)description
{
  NSString *desc = [NSString stringWithFormat:@"name:%@, money:%lf", _accountName, _money];
  return desc;
}

@end
