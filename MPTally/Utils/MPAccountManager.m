//
//  MPAccountManager.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountManager.h"
#import "MPBookManager.h"

@implementation MPAccountManager

/// 默认账户的Key，用于偏好设置的key
NSString static * DefaultAccountKey = @"DefaultAccountKey";
static MPAccountManager *instance;

#pragma mark - Public
#pragma mark Get
+ (instancetype)shareManager
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    [instance setup];
  });
  return instance;
}

/**
 获得默认的Account，为上次用户所选择的账户
 
 @return MPAccountModel对象
 */
- (MPAccountModel *)getDefaultAccount
{
  NSString *accountID = [[NSUserDefaults standardUserDefaults] objectForKey:DefaultAccountKey];
  MPAccountModel *defaultModel = nil;
  if(accountID)
  {
    // accountID不为空时，根据accountID去获得对应的account
    defaultModel = [MPAccountModel objectForPrimaryKey:accountID];
  }
  else
  {
    // 没有设置默认值时，去account列表的第一个账户的默认账户
    defaultModel = [self getAccountList].firstObject;
    [self setDefultAccount:defaultModel];
  }
  return defaultModel;
}

/**
 获得Account列表
 
 @return MPAccountModel模型数组
 */
- (RLMResults *)getAccountList
{
  return [MPAccountModel allObjects];
}


#pragma mark Write
/**
 添加一个数Account

 @param account 要添加的Account
 */
- (void)insertAccount:(MPAccountModel *)account
{
  [kRealm transactionWithBlock:^{
    account.accountID = [MyUtils createKey];
    [MPAccountModel createInDefaultRealmWithValue:account];
  }];
}

/**
 设置默认的Account
 
 @param account MPAccountModel模型
 */
- (void)setDefultAccount:(MPAccountModel *)account
{
  [[NSUserDefaults standardUserDefaults] setObject:account.accountID forKey:DefaultAccountKey];
}

#pragma mark - Private
/**
 账户是否为空

 @return 返回查询结果
 */
- (BOOL)isEmpty
{
  return [MPAccountModel allObjects].count == 0;
}

/**
 从plist文件加载数据到数据库
 */
- (void)loadAccountListFromPlist
{
  NSArray *modelArray = [MPAccountModel defaultAccountList];
  for (MPAccountModel *model in modelArray)
  {
    [self insertAccount:model];
  }
}

/**
 初始化
 */
- (void)setup
{
  if([self isEmpty])
  {
    [self loadAccountListFromPlist];
  }
}


@end
