//
//  MPAccountModel.h
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 账户模型
@interface MPAccountModel : RLMObject
/// 账户ID
@property (nonatomic, copy) NSString *accountID;
/// 账户名字
@property (nonatomic, copy) NSString *accountName;
/// 账户余额
@property (nonatomic, assign) double money;

/// 返回默认的账户列表
+ (NSArray *)defaultAccountList;

@end

RLM_ARRAY_TYPE(MPAccountModel)
