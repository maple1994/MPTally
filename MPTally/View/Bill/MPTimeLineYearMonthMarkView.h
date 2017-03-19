//
//  MPTimeLineYearMonthMarkView.h
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 时间线，有标注年月的结点
@interface MPTimeLineYearMonthMarkView : UIView

/// yyyy-MM格式的字符串
@property (nonatomic, copy)  NSString *timeLineTime;
/// 结点View
@property (nonatomic, weak) UIView *dotView;

@end
