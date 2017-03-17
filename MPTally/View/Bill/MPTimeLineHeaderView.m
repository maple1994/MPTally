//
//  MPTimeLineHeader.m
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTimeLineHeaderView.h"
#import "MPTimeLineHeaderModel.h"

@interface MPTimeLineHeaderView ()

@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) UIView *monthButtonBgView;
@property (nonatomic, weak) UILabel *monthLabel;
/// 左侧收入View
@property (nonatomic, weak) UIView *incomeView;
/// 收入Label
@property (nonatomic, weak) UILabel *incomeTitleLabel;
/// 收入金额Label
@property (nonatomic, weak) UILabel *incomeNumLabel;
/// 右侧支出View
@property (nonatomic, weak) UIView *outcomeView;
/// 支出Label
@property (nonatomic, weak) UILabel *outcomeTitleLabel;
/// 支出金额Label
@property (nonatomic, weak) UILabel *outcomeNumLabel;

@end

@implementation MPTimeLineHeaderView

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
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self);
    make.bottom.equalTo(self);
    make.width.mas_equalTo(1);
    make.height.mas_equalTo(1000);
  }];
  [self.monthButtonBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.bottom.equalTo(self);
    make.center.equalTo(self);
    make.height.width.mas_equalTo(60);
  }];
  [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.monthButtonBgView);
  }];
  [self.incomeView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self);
    make.trailing.equalTo(self.monthButtonBgView.mas_leading);
    make.centerY.equalTo(self.monthButtonBgView);
  }];
  [self.outcomeView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self);
    make.leading.equalTo(self.monthButtonBgView.mas_trailing);
    make.centerY.equalTo(self.monthButtonBgView);
  }];
}

- (void)setModel:(MPTimeLineHeaderModel *)model
{
  _model = model;
  self.incomeNumLabel.text = [MyUtils numToString:model.income];
  self.outcomeNumLabel.text = [MyUtils numToString:model.outcome];
  self.monthLabel.text = model.monthStr;
}

#pragma mark - getter
- (UIView *)outcomeView
{
  if(_outcomeView == nil)
  {
    UIView *view = [[UIView alloc] init];
    _outcomeView = view;
    
    // 添加子控件
    UILabel *label1 = [[UILabel alloc] init];
    UILabel *label2 = [[UILabel alloc] init];
    [view addSubview:label1];
    [view addSubview:label2];
    
    // 布局子空间
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.leading.trailing.equalTo(view);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(label1.mas_bottom);
      make.leading.trailing.bottom.equalTo(view);
    }];
    
    // 赋值
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = label1.textAlignment;
    label1.font = [UIFont systemFontOfSize:12];
    label2.font = label1.font;
    label1.text = @"支出";
    label2.text = @"00.00";
    self.outcomeTitleLabel = label1;
    self.outcomeNumLabel = label2;
    [self addSubview:view];
  }
  return _outcomeView;
}

- (UIView *)incomeView
{
  if(_incomeView == nil)
  {
    UIView *view = [[UIView alloc] init];
    _incomeView = view;
    
    // 添加子控件
    UILabel *label1 = [[UILabel alloc] init];
    UILabel *label2 = [[UILabel alloc] init];
    [view addSubview:label1];
    [view addSubview:label2];
    
    // 布局子空间
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.leading.trailing.equalTo(view);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(label1.mas_bottom);
      make.leading.trailing.bottom.equalTo(view);
    }];
    
    // 赋值
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = label1.textAlignment;
    label1.font = [UIFont systemFontOfSize:12];
    label2.font = label1.font;
    label1.text = @"收入";
    label2.text = @"00.00";
    self.incomeTitleLabel = label1;
    self.incomeNumLabel = label2;
    [self addSubview:view];
  }
  return _incomeView;
}

- (UIView *)monthButtonBgView
{
  if(_monthButtonBgView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 30;
    view.layer.masksToBounds = YES;
    view.backgroundColor = colorWithRGB(47, 178, 232);
    _monthButtonBgView = view;
    [self addSubview:view];
  }
  return _monthButtonBgView;
}

- (UIView *)lineView
{
  if(_lineView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kTimeLineColor;
    _lineView = view;
    [self addSubview:view];
  }
  return _lineView;
}

- (UILabel *)monthLabel
{
  if(_monthLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"";
    _monthLabel = label;
    [self.monthButtonBgView addSubview:label];
  }
  return _monthLabel;
}

@end
