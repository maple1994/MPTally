//
//  MPCreateBillViewController.h
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 创建账单
@interface MPCreateBillViewController : UIViewController

/// 选中的账单，如果传递了该模型，代表是更新账单操作
@property (nonatomic, weak) MPBillModel *selectedBill;

@end
