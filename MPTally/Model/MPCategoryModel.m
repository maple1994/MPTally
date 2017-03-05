//
//  MPCategoryModel.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCategoryModel.h"

@implementation MPCategoryModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
  if (self = [super init])
  {
    [self setValuesForKeysWithDictionary:dic];
  }
  return self;
}

/// 获得“收入”类型模型数组
+ (NSArray *)getIncomeCategoryArray
{
  NSString *path = [[NSBundle mainBundle]pathForResource:@"category" ofType:@"plist"];
  NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
  NSMutableArray *tempArray = [NSMutableArray array];
  
  for (NSDictionary *dic in dicArray)
  {
    MPCategoryModel *category = [[MPCategoryModel alloc] initWithDic:dic];
    if(category.isIncome)
      [tempArray addObject:category];
  }
  return tempArray;
}

/// 获得“支出”类型模型数组
+ (NSArray *)getOutcomeCategoryArray
{
  NSString *path = [[NSBundle mainBundle]pathForResource:@"category" ofType:@"plist"];
  NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
  NSMutableArray *tempArray = [NSMutableArray array];
  
  for (NSDictionary *dic in dicArray)
  {
    MPCategoryModel *category = [[MPCategoryModel alloc] initWithDic:dic];
    if(!category.isIncome)
      [tempArray addObject:category];
  }
  return tempArray;
}

@end
