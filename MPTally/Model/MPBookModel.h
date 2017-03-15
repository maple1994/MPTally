//
//  MPBookModel.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 账本模型
@interface MPBookModel : RLMObject

/// 账本ID
@property (nonatomic, strong) NSString *bookID;
/// 账本名
@property (nonatomic, copy) NSString *bookName;
/// 是否为选中状态
@property (nonatomic, assign) BOOL selected;

@end

RLM_ARRAY_TYPE(MPBookModel)
