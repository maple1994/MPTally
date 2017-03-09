//
//  MPCategoryManager.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 类别管理者
@interface MPCategoryManager : NSObject

+ (instancetype)shareManager;

/**
 获得收入类型列表

 @return MPCategory模型数组
 */
- (RLMResults *)getIncomeCategoryList;

/**
 获得支出类型列表

 @return MPCategory模型数组
 */
- (RLMResults *)getOutcomeCategoryList;

/**
 插入一条类型

 @param category 要插入的类型模型
 */
- (void)insertCategory:(MPCategoryModel *)category;

@end
