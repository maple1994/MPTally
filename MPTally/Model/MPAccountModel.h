//
//  MPAccountModel.h
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 账户模型
@interface MPAccountModel : NSObject
/// 账户名字
@property (nonatomic, copy) NSString *accountName;
/// 账户余额
@property (nonatomic, assign) CGFloat money;

@end
