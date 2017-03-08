//
//  MPAccountPickerView.h
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 账户选择Picker
@interface MPAccountPickerView : UIView

/// 根据账户模型创建界面
- (instancetype)initWithAccountModelArray:(NSArray *)accountModelArray;

@end
