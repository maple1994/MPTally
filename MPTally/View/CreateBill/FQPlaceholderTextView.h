//
//  XMGPlaceholderTextView.h
//  01-百思不得姐
//
//  Created by xiaomage on 15/8/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//  拥有占位文字功能的TextView

#import <UIKit/UIKit.h>

@interface FQPlaceholderTextView : UITextView
/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic, strong) UIColor *placeholderColor;
/** 设置当前placeholder文本中，个别文字的颜色*/
- (void)setSomePlaceholderColor:(UIColor *)color withText:(NSString *)text;

@end
