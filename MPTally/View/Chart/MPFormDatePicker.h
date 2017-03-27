//
//  MPFormDatePicker.h
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MPFormDatePickerDelegate <NSObject>
/// 选择的日期
- (void)formDatePickerDidSelectDate:(NSDate *)date;

@end

/// 报表时间选择器
@interface MPFormDatePicker : UIView

@property (nonatomic, weak) id<MPFormDatePickerDelegate> delegate;

@end
