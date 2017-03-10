//
//  MPTimeLineModel.m
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTimeLineModel.h"

@implementation MPTimeLineModel

/**
 根据bill的查询结果生成模型数组
 
 @param results bill的查询结果集
 @return MPTimeLineModel模型数组
 */
+ (NSMutableArray *)timeLineArrayWithResults:(RLMResults *)results
{
  NSMutableArray *modelArray = [NSMutableArray array];
  // 比较日期，以此产生日期Cell模型
  NSString *currentDateStr = nil;
  for (MPBillModel *bill in results)
  {
    // 不相同时，添加日期Cell模型
    if(![currentDateStr isEqualToString:bill.dateStr])
    {
      [modelArray addObject:[self getDayItem]];
      currentDateStr = bill.dateStr;
    }
    // 添加普通Cell
    [modelArray addObject:[self getNormalItem:bill]];
  }
  return modelArray;
}

/// 产生一个日期的Item
+ (instancetype)getDayItem
{
  MPTimeLineModel *model = [[MPTimeLineModel alloc] init];
  model.type = TimeLineDayItem;
  return model;
}

/// 产生一个普通的Item
+ (instancetype)getNormalItem:(MPBillModel *)bill
{
  MPTimeLineModel *timeLineModel = [[MPTimeLineModel alloc] init];
  timeLineModel.bill = bill;
  timeLineModel.type = TimeLineNormalItem;
  return timeLineModel;
}

@end
