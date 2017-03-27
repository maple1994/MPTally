//
//  MPPieModel.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPPieModel.h"

@implementation MPPieModel

/**
 根据账单数组生成MPPieModel模型数组
 
 @param results 账单数组
 @return MPPieModel模型数组
 */
+ (NSArray *)modelArrayWithBills:(RLMResults *)results
{
  // 所有账单总额
  double total = 0;
  NSMutableArray *modelArray = [NSMutableArray array];
  // 用于记录已经筛选过的分类ID
  NSMutableSet *categorySet = [NSMutableSet set];
  // 将账单按照类别分组
  for (MPBillModel *bill in results)
  {
    NSString *ID = bill.category.cateID;
    // 没有筛选过
    if(![categorySet containsObject:ID])
    {
      RLMResults *billsInSameCate = [results objectsWhere:@"category.cateID=%@", ID];
      double sum = 0;
      for (MPBillModel *model in billsInSameCate)
      {
        sum += model.money;
      }
      total += sum;
      MPPieModel *pieModel = [[MPPieModel alloc] init];
      pieModel.category = bill.category;
      pieModel.sum = sum;
      pieModel.bills = billsInSameCate;
      // 将该类别ID记录在集合中
      [categorySet addObject:ID];
      [modelArray addObject:pieModel];
    }
  }
  // 设置百分比
  for (MPPieModel *pie in modelArray)
  {
    pie.precent = pie.sum / total;
  }
  return modelArray;
}


@end
