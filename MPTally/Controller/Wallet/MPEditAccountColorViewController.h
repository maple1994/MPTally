//
//  MPEditAccountColorViewController.h
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 编辑账户颜色的控制器
@interface MPEditAccountColorViewController : UIViewController

/// 选择颜色后的回调
@property (nonatomic, copy) void (^didSelectColor)(NSString *hexColor);
/// 当前选中的颜色
@property (nonatomic, copy) NSString *hexColor;

@end
