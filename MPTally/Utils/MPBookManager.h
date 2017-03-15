//
//  MPBookManager.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 账本管理者
@interface MPBookManager : NSObject

#pragma makr - Get
+ (instancetype)shareManager;
/**
 获得当前的账本

 @return MPBookModel对象
 */
- (MPBookModel *)getCurrentBook;

/**
 获得所有账本

 @return MPBookModel数据
 */
- (RLMResults *)getAllBook;

#pragma mark - Write
/**
 设置当前的账本

 @param book 选中的账本模型
 */
- (void)setCurrentBook:(MPBookModel *)book;


@end
