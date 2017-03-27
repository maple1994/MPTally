//
//  MPPieModel.h
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 饼状图报表模型
@interface MPPieModel : NSObject

/// 类别
@property (nonatomic, strong) MPCategoryModel *category;
/// 类别账单总额
@property (nonatomic, assign) double sum;
/// 该类别下的账单数组
@property (nonatomic, strong) RLMResults *bills;
/// 百分比
@property (nonatomic, assign) double precent;

/**
 根据账单数组生成MPPieModel模型数组

 @param results 账单数组
 @return MPPieModel模型数组
 */
+ (NSArray *)modelArrayWithBills:(RLMResults *)results;

@end
