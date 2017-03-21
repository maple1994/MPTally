//
//  MPBillManager.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 账单管理者
@interface MPBillManager : NSObject

#pragma mark - Get
+ (instancetype)shareManager;

/**
 获取当前账本，指定账户，指定年月的账单列表
 
 @param account 要查询的账本
 @param date 指定年月
 @return MPBillModel账单列表
 */
- (RLMResults *)getBillInAccount:(MPAccountModel *)account inAnMonth:(NSDate *)date;

/**
 获取当前账本下的所有账单

 @return MPBillModel账单列表
 */
- (RLMResults *)getBillsInCurrentBook;

#pragma mark - Write
/**
 插入一条账单
 
 @param bill MPBillModel
 */
- (void)insertBill:(MPBillModel *)bill;

/**
 删除账单

 @param bill 要删除的账单
 */
- (void)deleteBill:(MPBillModel *)bill;

@end
