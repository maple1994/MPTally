//
//  MPCalculatorView.m
//  MPTally
//
//  Created by Maple on 2017/3/7.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCalculatorView.h"

@implementation MPCalculatorView

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


@end
