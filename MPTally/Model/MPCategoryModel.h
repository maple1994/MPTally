//
//  MPCategoryModel.h
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 账单类型模型
@interface MPCategoryModel : NSObject

/// 类型名称
@property (nonatomic, copy) NSString *categoryName;
/// 类型图片名
@property (nonatomic, copy) NSString *categoryImageFileName;
/// 是否为收入类型
@property (nonatomic, assign) BOOL isIncome;

/// 获得“收入”类型模型数组
+ (NSArray *)getIncomeCategoryArray;
/// 获得“支出”类型模型数组
+ (NSArray *)getOutcomeCategoryArray;

@end
