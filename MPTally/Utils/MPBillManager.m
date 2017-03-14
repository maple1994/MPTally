//
//  MPBillManager.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBillManager.h"

@implementation MPBillManager

static id instance;

#pragma mark - Public
#pragma mark Get
+ (instancetype)shareManager
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
  });
  return instance;
}

#pragma mark Write
/**
 插入一条账单
 
 @param bill MPBillModel
 */
- (void)insertBill:(MPBillModel *)bill
{
  bill.billID = [MyUtils createKey];
  bill.recordDate = [NSDate date];
  [kRealm transactionWithBlock:^{
    [MPBillModel createInDefaultRealmWithValue:bill];
    // 设置对应账单的金额
    
  }];
}

#pragma mark - Private

@end
