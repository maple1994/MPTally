//
//  MPAccountDetailView.m
//  MPTally
//
//  Created by Maple on 2017/3/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountDetailHeaderView.h"
#import "MPDatePickerView.h"
#import "HooDatePicker.h"
#import "MPBillManager.h"

@interface MPAccountDetailHeaderView ()<HooDatePickerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *balanceButton;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *outcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
/// 日期选择器
@property (nonatomic, strong) HooDatePicker *datePicker;
/// 用户查看的日期
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation MPAccountDetailHeaderView

- (void)setAccount:(MPAccountModel *)account
{
  _account = account;
  [_balanceButton setTitle:[MyUtils numToString:account.money] forState:UIControlStateNormal];
  self.backgroundColor = [UIColor colorWithHexString:account.colorStr];
  [self calculateTotalSum:[NSDate date]];
}

/// 计算指定日期的收支
- (void)calculateTotalSum:(NSDate *)date
{
  RLMResults *result = [[MPBillManager shareManager] getBillsInAccount:_account inAnMonth:date];
  double income = 0;
  double outcome = 0;
  for (MPBillModel *bill in result)
  {
    if(bill.isIncome)
    {
      income += bill.money;
    }
    else
    {
      outcome += bill.money;
    }
  }
  self.outcomeLabel.text = [MyUtils numToString:outcome];
  self.incomeLabel.text = [MyUtils numToString:income];

}

- (IBAction)monthClick:(UIButton *)sender
{
  [self.datePicker show];
}
- (IBAction)editBalance:(UIButton *)sender
{
  if([self.delegate respondsToSelector:@selector(accountDetailHeaderView:didEditBalance:)])
  {
    [self.delegate accountDetailHeaderView:self didEditBalance:sender ];
  }
}

#pragma mark - HooDatePickerDelegate
- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setLocale:[NSLocale currentLocale]];
  [dateFormatter setDateFormat:@"M"];
  NSString *value = [dateFormatter stringFromDate:date];
  self.monthLabel.text = value;
  [self calculateTotalSum:date];
  if([self.delegate respondsToSelector:@selector(accountDetailHeaderView:didChangeDate:)])
  {
    [self.delegate accountDetailHeaderView:self didChangeDate:date];
  }
}

- (NSDate *)selectedDate
{
  if(_selectedDate == nil)
  {
    _selectedDate = [NSDate date];
  }
  return _selectedDate;
}

- (HooDatePicker *)datePicker
{
  if(_datePicker == nil)
  {
    _datePicker = [[HooDatePicker alloc] initWithSuperView:[UIApplication sharedApplication].keyWindow];
    _datePicker.delegate = self;
    _datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
    [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
    NSDate *maxDate = [dateFormatter dateFromString:@"2050-01-01"];
    NSDate *minDate = [dateFormatter dateFromString:@"1970-01-01"];
    
    [_datePicker setDate:[NSDate date] animated:YES];
    _datePicker.minimumDate = minDate;
    _datePicker.maximumDate = maxDate;

  }
  return _datePicker;
}

@end
