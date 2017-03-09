//
//  MPEditRemarkViewController.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 编辑备注的界面
@interface MPEditRemarkViewController : UIViewController

/// 备注字符串
@property (nonatomic, copy) NSString *remark;
/// 点击完成后，执行的block
@property (nonatomic, copy) void (^completeBlock)(NSString *remark);

@end
