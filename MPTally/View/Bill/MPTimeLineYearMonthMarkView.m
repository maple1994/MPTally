//
//  MPTimeLineYearMonthMarkView.m
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTimeLineYearMonthMarkView.h"

@interface MPTimeLineYearMonthMarkView ()

/// 结点View
@property (nonatomic, weak) UIView *dotView;
/// 标明时间Label
@property (nonatomic, weak) UILabel *timeLabel;

@end

@implementation MPTimeLineYearMonthMarkView


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
  self.backgroundColor = kTimeLineColor;
  [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self);
    make.height.width.mas_offset(6);
  }];
  [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.dotView.mas_leading);
    make.centerY.equalTo(self.dotView);
  }];
}

- (UIView *)dotView
{
  if(_dotView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.hidden = YES;
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor lightGrayColor];
    _dotView = view;
    [self addSubview:view];
  }
  return _dotView;
}

- (UILabel *)timeLabel
{
  if(_timeLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.hidden = YES;
    _timeLabel = label;
    label.text = @"2月";
    [self addSubview:label];
  }
  return _timeLabel;
}

@end
