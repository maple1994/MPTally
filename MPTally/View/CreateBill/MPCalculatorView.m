//
//  MPCalculatorView.m
//  MPTally
//
//  Created by Maple on 2017/3/7.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCalculatorView.h"

@interface MPCalculatorView ()

@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIButton *remarkButton;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@end

@implementation MPCalculatorView

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.selectedDate = [NSDate date];
}

#pragma mark - Action
- (IBAction)selectAccount:(UIButton *)sender
{
  if([self.delegate respondsToSelector:@selector(calculatorViewDidClickAccount:)])
  {
    [self.delegate calculatorViewDidClickAccount:self];
  }
  kFuncNameLog;
}

- (IBAction)selectDate:(UIButton *)sender
{
  if([self.delegate respondsToSelector:@selector(calculatorViewDidClickCalendar:)])
  {
    [self.delegate calculatorViewDidClickCalendar:self];
  }
}

- (IBAction)mark:(UIButton *)sender
{
  if([self.delegate respondsToSelector:@selector(calculatorViewDidClickRemark:)])
  {
    [self.delegate calculatorViewDidClickRemark:self];
  }
  kFuncNameLog;
}

#pragma mark - setter
- (void)setSelectedDate:(NSDate *)selectedDate
{
  _selectedDate = selectedDate;
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"M月d日";
  [self.dateButton setTitle:[fmt stringFromDate:selectedDate] forState:UIControlStateNormal];
}


@end
