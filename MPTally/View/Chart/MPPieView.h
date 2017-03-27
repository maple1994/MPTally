//
//  MPPieView.h
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 饼状图
@interface MPPieView : UIView

/// 饼状图模型数组
@property (nonatomic, strong) NSArray *data;
/// 是否显示收入状态的报表，默认为NO
@property (nonatomic, assign, getter=isShowIncomeChart) BOOL showIncomeChart;

@end
