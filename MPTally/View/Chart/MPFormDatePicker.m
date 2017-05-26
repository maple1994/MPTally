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
/// 切换收入 or 支出
@property (nonatomic, strong) UIButton *switchStateButton;

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
      make.height.equalTo(self);
      make.width.mas_equalTo(25);
      make.top.equalTo(self);
  }];
  [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.dateButton.mas_leading).offset(-20);
      make.height.equalTo(self);
      make.width.mas_equalTo(25);
      make.top.equalTo(self);
  }];
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.bottom.equalTo(self);
    make.height.mas_equalTo(1);
  }];
  [self.switchStateButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self).offset(-10);
    make.centerY.equalTo(self);
    make.width.mas_equalTo(30);
  }];
}

#pragma mark - Action
/// 下一年 / 月
- (void)next
{
  NSDate *next = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:self.currentDate options:0];
    if(_pickerMode == MPDatePickerYear)
        next = [self.calendar dateByAddingUnit:NSCalendarUnitYear value:1 toDate:self.currentDate options:0];
  self.currentDate = next;
  [self.dateButton setTitle:[self stringFromDate:next] forState:UIControlStateNormal];
  if([self.delegate respondsToSelector:@selector(formDatePickerDidSelectDate:)])
  {
    [self.delegate formDatePickerDidSelectDate:self.currentDate];
  }
}

/// 上一年 / 月
- (void)previous
{
  NSDate *pre = [self.calendar dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self.currentDate options:0];
    if(_pickerMode == MPDatePickerYear)
        pre = [self.calendar dateByAddingUnit:NSCalendarUnitYear value:-1 toDate:self.currentDate options:0];
    self.currentDate = pre;
  [self.dateButton setTitle:[self stringFromDate:pre] forState:UIControlStateNormal];
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
    if(_pickerMode == MPDatePickerYear)
        fmt.dateFormat = @"yyyy年";
  return [fmt stringFromDate:date];
}

/// 切换状态
- (void)switchStates
{
  if([self.delegate respondsToSelector:@selector(formDataPickerDidChangeStatus)])
  {
    [self.delegate formDataPickerDidChangeStatus];
  }
}

- (void)setPickerMode:(MPDatePickerMode)pickerMode
{
    _pickerMode = pickerMode;
    if(_pickerMode == MPDatePickerYear)
        self.switchStateButton.hidden = YES;
    [self.dateButton setTitle:[self stringFromDate:self.currentDate] forState:UIControlStateNormal];
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

- (UIButton *)switchStateButton
{
  if(_switchStateButton == nil)
  {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"exchange"] forState:UIControlStateNormal];
    _switchStateButton = button;
    [button addTarget:self action:@selector(switchStates) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
  }
  return _switchStateButton;
}

@end
