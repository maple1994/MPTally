//
//  MPBookManager.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBookManager.h"

@implementation MPBookManager

NSString static *CurrentBookKey = @"CurrentBookKey";
static MPBookManager *instance;

+ (instancetype)shareManager
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[self alloc] init];
    [instance setup];
  });
  return instance;
}

#pragma mark - Public 
#pragma mark - Get
/**
 获得当前的账本
 
 @return MPBookModel对象
 */
- (MPBookModel *)getCurrentBook
{
  NSString *bookID = [[NSUserDefaults standardUserDefaults] objectForKey:CurrentBookKey];
  MPBookModel *book = nil;
  if(bookID)
  {
    book = [MPBookModel objectForPrimaryKey:bookID];
  }
  else
  {
    // 取列表的第一个book作为当前的账本
    book = [self getBookList].firstObject;
    [self setCurrentBook:book];
  }
  return book;
}

/**
 获得所有账本

 @return MPBookModel模型数组
 */
- (RLMResults *)getBookList
{
  return [MPBookModel allObjects];
}

/**
 获得所有账本
 
 @return MPBookModel数据
 */
- (RLMResults *)getAllBook
{
  return [MPBookModel allObjects];
}

#pragma mark - Write
/**
 设置当前的账本
 
 @param book 选中的账本模型
 */
- (void)setCurrentBook:(MPBookModel *)book
{
  [[NSUserDefaults standardUserDefaults] setObject:book.bookID forKey:CurrentBookKey];
}

#pragma mark - Private
/**
 账本列表是否为空
 
 @return 返回查询结果
 */
- (BOOL)isEmpty
{
  return [MPBookModel allObjects].count == 0;
}

/**
 加载默认账本
 */
- (void)loadDefultBook
{
  MPBookModel *book = [[MPBookModel alloc] init];
  book.bookID = [MyUtils createKey];
  book.bookName = @"默认账本";
  [kRealm transactionWithBlock:^{
    [MPBookModel createInDefaultRealmWithValue:book];
  }];
}

/**
 初始化
 */
- (void)setup
{
  if([self isEmpty])
  {
    [self loadDefultBook];
  }
}

@end
