//
//  SVProgressHUD+MPTips.m
//  MPTally
//
//  Created by Maple on 2017/3/15.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "SVProgressHUD+MPTips.h"

@implementation SVProgressHUD (MPTips)

+ (void)showTips:(NSString *)tips
{
  [SVProgressHUD setMinimumDismissTimeInterval:0.5];
  [SVProgressHUD showImage:nil status:tips];
  [SVProgressHUD setFont:[UIFont systemFontOfSize:15]];
  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
  [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

@end
