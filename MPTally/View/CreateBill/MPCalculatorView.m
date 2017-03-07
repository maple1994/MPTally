//
//  MPCalculatorView.m
//  MPTally
//
//  Created by Maple on 2017/3/7.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCalculatorView.h"
#import "SZCalendarPicker.h"

@implementation MPCalculatorView

- (IBAction)selectAccount:(UIButton *)sender
{
  kFuncNameLog;
}

- (IBAction)selectDate:(UIButton *)sender
{
  kFuncNameLog;
  SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self];
  calendarPicker.today = [NSDate date];
  calendarPicker.date = calendarPicker.today;
  calendarPicker.frame = CGRectMake(0, 0, self.mp_width, self.mp_height);
  calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
    
    NSLog(@"%zd-%zd-%zd", year,month,day);
  };
}

- (IBAction)mark:(UIButton *)sender
{
  kFuncNameLog;
}


@end
