//
//  MPTimeLineDayTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTimeLineDayTableViewCell.h"
#import "MPDayBillModel.h"

@interface MPTimeLineDayTableViewCell ()

/// 显示日期的label
@property (nonatomic, weak) UILabel *dateLabel;
/// 日期label的背景
@property (nonatomic, weak) UIView *dateBgView;
/// 支出的Title
@property (nonatomic, weak) UILabel *outcomeTitleLabel;
/// 支出金额
@property (nonatomic, weak) UILabel *outcomeNumLabel;
/// 收入的Title
@property (nonatomic, weak) UILabel *incomeTitleLabel;
/// 收入金额
@property (nonatomic, weak) UILabel *incomeNumLabel;
/// 时间线
@property (nonatomic, weak) UIView *timeLineView;

@end

@implementation MPTimeLineDayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
  {
    [self setup];
  }
  return self;
}

- (void)setup
{
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self.dateBgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.contentView);
    make.centerX.equalTo(self.contentView);
    make.height.width.mas_equalTo(25);
  }];
  [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.dateBgView);
  }];
  // 支出
  [self.outcomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.dateBgView.mas_trailing).offset(10);
    make.centerY.equalTo(self.dateBgView);
  }];
  [self.outcomeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.outcomeTitleLabel.mas_trailing).offset(5);
    make.centerY.equalTo(self.outcomeTitleLabel);
  }];
  // 收入
  [self.incomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.dateBgView.mas_leading).offset(-10);
    make.centerY.equalTo(self.dateBgView);
  }];
  [self.incomeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.incomeTitleLabel.mas_leading).offset(-5);
    make.centerY.equalTo(self.incomeTitleLabel);
  }];
  
  // 时间线
  [self.timeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.dateBgView.mas_bottom);
    make.bottom.equalTo(self.contentView);
    make.centerX.equalTo(self.contentView);
    make.width.mas_equalTo(1);
  }];
}

- (void)setDateStr:(NSString *)dateStr
{
  _dateStr = dateStr;
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd";
  NSDate *date = [fmt dateFromString:dateStr];
  fmt.dateFormat = @"d日";
  
  self.dateLabel.text = [fmt stringFromDate:date];
}

- (void)setDayBill:(MPDayBillModel *)dayBill
{
  _dayBill = dayBill;
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"yyyy-MM-dd";
  NSDate *date = [fmt dateFromString:dayBill.dateStr];
  fmt.dateFormat = @"d日";
  self.dateLabel.text = [fmt stringFromDate:date];
  self.outcomeNumLabel.text = [MyUtils numToString:dayBill.outcome];
  self.incomeNumLabel.text = [MyUtils numToString:dayBill.income];
  
  self.outcomeNumLabel.hidden = (dayBill.outcome == 0);
  self.outcomeTitleLabel.hidden = self.outcomeNumLabel.isHidden;
  self.incomeNumLabel.hidden = (dayBill.income == 0);
  self.incomeTitleLabel.hidden = self.incomeNumLabel.isHidden;
}

#pragma mark - getter
- (UIView *)timeLineView
{
  if(_timeLineView == nil)
  {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kTimeLineColor;
    _timeLineView = line;
    [self.contentView addSubview:line];
  }
  return _timeLineView;
}

- (UIView *)dateBgView
{
  if(_dateBgView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    view.layer.cornerRadius = 12.5;
    view.layer.masksToBounds = YES;
    _dateBgView = view;
    [self.contentView addSubview:view];
  }
  return _dateBgView;
}

- (UILabel *)dateLabel
{
  if(_dateLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.text = @"3日";
    _dateLabel = label;
    [self.contentView addSubview:label];
  }
  return _dateLabel;
}

- (UILabel *)outcomeTitleLabel
{
  if(_outcomeTitleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"支出";
    _outcomeTitleLabel = label;
    [self.contentView addSubview:label];
  }
  return _outcomeTitleLabel;
}

- (UILabel *)outcomeNumLabel
{
  if(_outcomeNumLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"55.00";
    _outcomeNumLabel = label;
    [self.contentView addSubview:label];
  }
  return _outcomeNumLabel;
}

- (UILabel *)incomeTitleLabel
{
  if(_incomeTitleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"收入";
    label.font = [UIFont systemFontOfSize:14];
    _incomeTitleLabel = label;
    [self.contentView addSubview:label];
  }
  return _incomeTitleLabel;
}

- (UILabel *)incomeNumLabel
{
  if(_incomeNumLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"666.0";
    _incomeNumLabel = label;
    [self.contentView addSubview:label];
  }
  return _incomeNumLabel;
}

@end
