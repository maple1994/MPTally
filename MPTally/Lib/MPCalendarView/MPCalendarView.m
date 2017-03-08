//
//  MyCalendarView.m
//  CalendarDemo
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCalendarView.h"
#import "FSCalendar.h"

@interface MPCalendarView()<FSCalendarDataSource, FSCalendarDelegate>

/// 日历View
@property (nonatomic, weak) FSCalendar *calendarView;
/// 下个月button
@property (nonatomic, weak) UIButton *nextButton;
/// 上个月button
@property (nonatomic, weak) UIButton *previousButton;
/// 日历对象
@property (strong, nonatomic) NSCalendar *gregorian;
/// 日历容器
@property (nonatomic, weak) UIView *contentView;
/// 蒙版
@property (nonatomic, weak) UIView *backgroundView;

@end;

@implementation MPCalendarView

static CGFloat ToolViewH = 50;

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
  [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.equalTo(self);
    make.bottom.equalTo(self).offset(kScreenH * 0.4);
    make.height.mas_equalTo(kScreenH * 0.4);
  }];
  [self.calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self.contentView);
  }];
  [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.contentView).offset(-20);
    make.top.equalTo(self.contentView).offset(5);
    make.width.mas_equalTo(ToolViewH);
    make.height.mas_equalTo(30);
  }];
  [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.contentView).offset(20);
    make.top.equalTo(self.contentView).offset(5);
    make.width.mas_equalTo(ToolViewH);
    make.height.mas_equalTo(30);
  }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
  [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self).offset(kScreenH * 0.4);
  }];
  [self layoutIfNeeded];
  [super willMoveToSuperview:newSuperview];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self).offset(0);
    }];
    [UIView animateWithDuration:0.25 animations:^{
      [self layoutIfNeeded];
    }];
  });
}

- (void)dismiss
{
  [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self).offset(kScreenH * 0.4);
  }];
  [UIView animateWithDuration:0.25 animations:^{
    [self layoutIfNeeded];
  }completion:^(BOOL finished) {
    [self removeFromSuperview];
  }];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd";
  NSLog(@"%@", [fmt stringFromDate:date]);
}

- (void)previousClicked:(id)sender
{
  NSDate *currentMonth = self.calendarView.currentPage;
  NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
  [self.calendarView setCurrentPage:previousMonth animated:YES];
}

- (void)nextClicked:(id)sender
{
  NSDate *currentMonth = self.calendarView.currentPage;
  NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
  [self.calendarView setCurrentPage:nextMonth animated:YES];
}

#pragma mark - getter
- (NSCalendar *)gregorian
{
  if(_gregorian == nil)
  {
    _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
  }
  return _gregorian;
}

- (UIView *)contentView
{
  if(_contentView == nil)
  {
    UIView *view = [[UIView alloc] init];
    [self addSubview:view];
    _contentView = view;
  }
  return _contentView;
}

- (UIButton *)nextButton
{
  if(_nextButton == nil)
  {
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:nextButton];
    _nextButton = nextButton;
  }
  return _nextButton;
}

- (UIButton *)previousButton
{
  if(_previousButton == nil)
  {
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, 64+5, 95, 34);
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:previousButton];
    _previousButton = previousButton;
  }
  return _previousButton;
}

- (FSCalendar *)calendarView
{
  if(_calendarView == nil)
  {
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectZero];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    [self.contentView addSubview:calendar];
    _calendarView = calendar;
  }
  return _calendarView;
}

- (UIView *)backgroundView
{
  if(_backgroundView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [view addGestureRecognizer:tap];
    _backgroundView = view;
    [self addSubview:view];
  }
  return _backgroundView;
}

@end
