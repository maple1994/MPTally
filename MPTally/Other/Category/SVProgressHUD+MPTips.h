//
//  SVProgressHUD+MPTips.h
//  MPTally
//
//  Created by Maple on 2017/3/15.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

/// 自定义提示格式
@interface SVProgressHUD (MPTips)

/// 显示自定义提示语句
+ (void)showTips:(NSString *)tips;

@end
