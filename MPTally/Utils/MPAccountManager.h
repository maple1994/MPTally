//
//  MPAccountManager.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 账户管理者
@interface MPAccountManager : NSObject

+ (instancetype)shareManager;

#pragma mark - Get
/**
 获得默认的Account，为上次用户所选择的账户

 @return MPAccountModel对象
 */
- (MPAccountModel *)getDefaultAccount;

/**
 获得Account列表

 @return MPAccountModel模型数组
 */
- (RLMResults *)getAccountList;

#pragma mark - Write
/**
 添加一个数Account
 
 @param account 要添加的Account
 */
- (void)insertAccount:(MPAccountModel *)account;

/**
 设置默认的Account

 @param account MPAccountModel模型
 */
- (void)setDefultAccount:(MPAccountModel *)account;

@end
