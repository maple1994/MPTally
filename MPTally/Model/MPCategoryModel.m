//
//  MPCategoryModel.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCategoryModel.h"

@implementation MPCategoryModel

+ (NSString *)primaryKey
{
  return @"cateID";
}

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

/// 获得账单类型模型数组
+ (NSArray *)getCategoryArray
{
  NSString *path = [[NSBundle mainBundle]pathForResource:@"category" ofType:@"plist"];
  NSArray *dicArray = [NSArray arrayWithContentsOfFile:path];
  NSMutableArray *tempArray = [NSMutableArray array];
  
  for (NSDictionary *dic in dicArray)
  {
    MPCategoryModel *category = [[MPCategoryModel alloc] initWithDic:dic];
    [tempArray addObject:category];
  }
  return tempArray;
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

- (NSString *)description
{
  NSString *desc = [NSString stringWithFormat:@"name:%@, imageName:%@, isIncome:%zd", _categoryName, _categoryImageFileName, _isIncome];
  return desc;
}

@end
