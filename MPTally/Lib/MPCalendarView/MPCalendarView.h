//
//  MyCalendarView.h
//  CalendarDemo
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface MPCalendarView : UIView

/// 日历View
@property (nonatomic, weak) FSCalendar *calendarView;

/// 界面退去
- (void)dismiss;

@end
