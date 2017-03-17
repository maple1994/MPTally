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
