//
//  MPBillDetailViewController.h
//  MPTally
//
//  Created by Maple on 2017/3/23.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 账单详情
@interface MPBillDetailViewController : UIViewController

@property (nonatomic, strong) MPBillModel *bill;
@property (nonatomic, copy) NSString *topbarColor;
/// 删除账单的回调
@property (nonatomic, copy) void (^delteBlock)(MPBillModel *bill);

@end
