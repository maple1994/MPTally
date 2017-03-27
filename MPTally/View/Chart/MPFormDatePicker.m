//
//  MPFormDatePicker.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPFormDatePicker.h"

@interface MPFormDatePicker ()

/// 显示当前选中的时间button
@property (nonatomic, weak) UIButton *dateButton;
/// 上一个月,按钮
@property (nonatomic, weak) UIButton *nextButton;
/// 下一个月，年按钮
@property (nonatomic, weak) UIButton *previousButton;
/// 底部线
@property (nonatomic, weak) UIView *lineView;
/// 当前显示的时间
@property (nonatomic, strong) NSDate *currentDate;
/// 日历对象
@property (strong, nonatomic) NSCalendar *calendar;

@end

@implementation MPFormDatePicker

- (instancetype)init
{
  if(self = [super init])
  {
    [self setup];
  }
  return self;
}

- (void)setup
{
  self.backgroundColor = colorWithRGB(240, 240, 240);
  [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self);
  }];
  [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.dateButton.mas_trailing).offset(20);
    make.centerY.equalTo(self.dateButton);
  }];
  [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.dateButton.mas_leading).offset(-20);
    make.centerY.equalTo(self.dateButton);
  }];
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.bottom.equalTo(self);
    make.height.mas_equalTo(1);
  }];
}

#pragma mark - Action
/// 下一年 / 月
- (void)next
{
  NSDate *nextMonth = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:self.currentDate options:0];
  self.currentDate = nextMonth;
  [self.dateButton setTitle:[self stringFromDate:nextMonth] forState:UIControlStateNormal];
  if([self.delegate respondsToSelector:@selector(formDatePickerDidSelectDate:)])
  {
    [self.delegate formDatePickerDidSelectDate:self.currentDate];
  }
}

/// 上一年 / 月
- (void)previous
{
  NSDate *preMonth = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self.currentDate options:0];
  self.currentDate = preMonth;
  [self.dateButton setTitle:[self stringFromDate:preMonth] forState:UIControlStateNormal];
  if([self.delegate respondsToSelector:@selector(formDatePickerDidSelectDate:)])
  {
    [self.delegate formDatePickerDidSelectDate:self.currentDate];
  }
}

/// 转化为对应的格式
- (NSString *)stringFromDate:(NSDate *)date
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy年MM月";
  return [fmt stringFromDate:date];
}

#pragma mark - getter
- (UIButton *)dateButton
{
  if(_dateButton == nil)
  {
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor colorWithHexString:@"2FB2E8"] forState:UIControlStateNormal];
    
    [button setTitle:[self stringFromDate:self.currentDate] forState:UIControlStateNormal];
    _dateButton = button;
    [self addSubview:button];
  }
  return _dateButton;
}

- (UIButton *)nextButton
{
  if(_nextButton == nil)
  {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    _nextButton = button;
    [self addSubview:button];
  }
  return _nextButton;
}

- (UIButton *)previousButton
{
  if(_previousButton == nil)
  {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(previous) forControlEvents:UIControlEventTouchUpInside];
    _previousButton = button;
    [self addSubview:button];
  }
  return _previousButton;
}

- (UIView *)lineView
{
  if(_lineView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = colorWithRGB(200, 200, 200);
    _lineView = view;
    [self addSubview:view];
  }
  return _lineView;
}

- (NSDate *)currentDate
{
  if(_currentDate == nil)
  {
    _currentDate = [NSDate date];
  }
  return _currentDate;
}

- (NSCalendar *)calendar
{
  if(_calendar == nil)
  {
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  }
  return _calendar;
}

@end
