//
//  MPTimeLineModel.h
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TimeLineType)
{
  TimeLineNormalItem = 0, // 普通类型Cell
  TimeLineDayItem = 1     // 显示日期类型的Cell
};
/// 时间线模型
@interface MPTimeLineModel : NSObject

/// 模型的类型
@property (nonatomic, assign) TimeLineType type;
/// 账单模型
@property (nonatomic, strong) MPBillModel *bill;
/// 时间字符串
@property (nonatomic, copy) NSString *dateStr;

/**
 根据bill的查询结果生成模型数组

 @param results bill的查询结果集
 @return MPTimeLineModel模型数组
 */
+ (NSMutableArray *)timeLineArrayWithResults:(RLMResults *)results;

@end
