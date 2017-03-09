//
//  MPAccountPickerView.h
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPAccountPickerView;
@class MPAccountModel;
@protocol AccountPickerViewDelegate <NSObject>

@optional
/// 选中的账户
- (void)accountPickerView:(MPAccountPickerView *)pickerView didSelectAccount:(MPAccountModel *)accountModel;

@end

/// 账户选择Picker
@interface MPAccountPickerView : UIView

@property (nonatomic, weak) id<AccountPickerViewDelegate> delegate;
/// 根据账户模型创建界面
- (instancetype)initWithAccountModelArray:(RLMResults *)accountModelArray;
/// 退出
- (void)dismiss;

@end
