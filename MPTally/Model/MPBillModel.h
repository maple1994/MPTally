//
//  MPBillModel.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 账单模型
@interface MPBillModel : RLMObject

/// 账单ID
@property (nonatomic, copy) NSString *billID;
/// 账单产生日期，要跟recordDate区分开
@property (nonatomic, copy) NSString *dateStr;
/// 账单记录日期，指的是生成账单的时间，用于排序
@property (nonatomic, strong) NSDate *recordDate;
/// 是否为收入
@property (nonatomic, assign) BOOL isIncome;
/// 备注
@property (nonatomic, copy) NSString *remark;
/// 金额
@property (nonatomic, assign) double money;
/// 账单类别
@property (nonatomic, strong) MPCategoryModel *category;
/// 账户
@property (nonatomic, strong) MPAccountModel *account;
/// 账本
@property (nonatomic, strong) MPBookModel *book;


@end

RLM_ARRAY_TYPE(MPBillModel)
