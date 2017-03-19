//
//  MPEditAccountNameViewController.h
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 编辑
@interface MPEditAccountNameViewController : UIViewController

@property (nonatomic, copy) NSString *accountName;
@property (nonatomic, copy) void (^doneBlock)(NSString *accountName);

@end
