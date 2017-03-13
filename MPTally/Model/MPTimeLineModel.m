//
//  MPTimeLineModel.m
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTimeLineModel.h"
#import "MPDayBillModel.h"

@interface MPTimeLineModel ()

/// 记录上一个dayBill
@property (nonatomic, weak) MPTimeLineModel *preDayBill;

@end

@implementation MPTimeLineModel

/**
 根据bill的查询结果生成模型数组
 
 @param results bill的查询结果集
 @return MPTimeLineModel模型数组
 */
+ (NSMutableArray *)timeLineArrayWithResults:(RLMResults *)results
{
  NSMutableArray *modelArray = [NSMutableArray array];
  NSMutableArray *billInSameDay = [NSMutableArray array];
  for(int i = 0; i < results.count; i++)
  {
    MPBillModel *bill = results[i];
    // 当数组为空时，直接添加元素
    if(billInSameDay.count == 0)
    {
      [billInSameDay addObject:bill];
    }
    else
    {
      // 将日期相同的账单，放在同一个数组中
      MPBillModel *lastOj = billInSameDay.lastObject;
      if([bill.dateStr isEqualToString:lastOj.dateStr])
      {
        [billInSameDay addObject:bill];
      }
      else
      {
        // 创建Day类型的模型
        [modelArray addObject:[self getDayItemWithBillArray:billInSameDay dateStr:lastOj.dateStr]];
        // 生成Normal类型的模型
        for (MPBillModel *bill in billInSameDay)
        {
          MPTimeLineModel *model = [[MPTimeLineModel alloc] init];
          model.bill = bill;
          model.type = TimeLineNormalItem;
          [modelArray addObject:model];
        }
        // 重新开始分类
        [billInSameDay removeAllObjects];
        [billInSameDay addObject:bill];
      }
    }
  }
  if(billInSameDay.count != 0)
  {
    MPBillModel *bill = billInSameDay.firstObject;
    [modelArray addObject:[self getDayItemWithBillArray:billInSameDay dateStr:bill.dateStr]];
    // 生成Normal类型的模型
    for (MPBillModel *bill in billInSameDay)
    {
      MPTimeLineModel *model = [[MPTimeLineModel alloc] init];
      model.bill = bill;
      model.type = TimeLineNormalItem;
      [modelArray addObject:model];
    }
  }
  return modelArray;
}

/// 创建normal类型的模型
+ (instancetype)getNormalItemWithBill:(MPBillModel *)bill
{
  MPTimeLineModel *model = [[MPTimeLineModel alloc] init];
  model.bill = bill;
  model.type = TimeLineNormalItem;
  return model;
}

/// 创建Day类型的模型
+ (instancetype)getDayItemWithBillArray:(NSArray *)billInSameDay dateStr:(NSString *)dateStr
{
  MPTimeLineModel *model = [[MPTimeLineModel alloc] init];
  model.dayBill = [MPDayBillModel dayBill:billInSameDay dateStr:dateStr];
  model.dateStr = dateStr;
  model.type = TimeLineDayItem;
  return model;
}

@end
