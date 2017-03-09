//
//  MPCategoryManager.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCategoryManager.h"

@implementation MPCategoryManager

static MPCategoryManager *instance;

+ (instancetype)shareManager
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    [instance setup];
    NSLog(@"%@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject);
  });
  return instance;
}

#pragma mark - Public
/**
 获得收入类型列表
 
 @return MPCategory模型数组
 */
- (RLMResults *)getIncomeCategoryList
{
  return nil;
}

/**
 获得支出类型列表
 
 @return MPCategory模型数组
 */
- (RLMResults *)getOutcomeCategoryList
{
  return nil;
}

/**
 插入一条类型
 
 @param category 要插入的类型模型
 */
- (void)insertCategory:(MPCategoryModel *)category
{
  [kRealm transactionWithBlock:^{
    category.cateID = [MPUtils createKey];
    [MPCategoryModel createInDefaultRealmWithValue:category];
  }];
}

#pragma mark - Private
/**
 类型列表是否为空

 @return 查询结果
 */
- (BOOL)isEmpty
{
  return ([MPCategoryModel allObjects].count == 0);
}

/**
 从plist文件加载数据到数据库
 */
- (void)loadCategoryDataFromPlist
{
  NSArray *modelArray = [MPCategoryModel getCategoryArray];
  for (MPCategoryModel *model in modelArray)
  {
      [self insertCategory:model];
  }
}


/**
 初始化
 */
- (void)setup
{
  if([self isEmpty])
  {
    [self loadCategoryDataFromPlist];
  }
}

@end
