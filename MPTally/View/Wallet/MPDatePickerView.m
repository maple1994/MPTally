//
//  MPDatePickerView.m
//  MPTally
//
//  Created by Maple on 2017/3/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPDatePickerView.h"
//#import "LTHMonthYearPickerView.h"
#define WINDOW_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4] //蒙版背景颜色
#define kPickerH 250

@interface MPDatePickerView ()

/// 背景蒙版
@property (nonatomic, weak) UIView *backgroundView;
/// picker
//@property (nonatomic, weak) LTHMonthYearPickerView *datePicker;

@end

@implementation MPDatePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
    [self setup];
  }
  return self;
}

- (void)didMoveToWindow
{
  [super didMoveToWindow];
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////    [self.datePicker mas_updateConstraints:^(MASConstraintMaker *make) {
////      make.bottom.equalTo(self).offset(0);
////    }];
//    [UIView animateWithDuration:0.25 animations:^{
//      [self layoutIfNeeded];
//    }];
//  });
}

- (void)setup
{
  [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
//  [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.leading.trailing.equalTo(self);
//    make.bottom.equalTo(self).offset(kPickerH);
//    make.height.mas_equalTo(kPickerH);
//  }];
}

- (void)tap
{
//  [self.datePicker mas_updateConstraints:^(MASConstraintMaker *make) {
//    make.bottom.equalTo(self).offset(kPickerH);
//  }];
  [UIView animateWithDuration:0.25 animations:^{
    self.alpha = 0;
    [self layoutIfNeeded];
  } completion:^(BOOL finished) {
    if (finished) {
      [self removeFromSuperview];
    }
  }];
}

#pragma mark - getter
//- (LTHMonthYearPickerView *)datePicker
//{
//  if(_datePicker == nil)
//  {
//    LTHMonthYearPickerView *view = [[LTHMonthYearPickerView alloc] initWithDate:[NSDate date] shortMonths:NO numberedMonths:YES andToolbar:YES];
//    view.datePicker.backgroundColor = [UIColor whiteColor];
//    _datePicker = view;
//    [self addSubview:view];
//  }
//  return _datePicker;
//}

- (UIView *)backgroundView
{
  if(_backgroundView == nil)
  {
    UIView *view = [[UIView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    view.backgroundColor = WINDOW_COLOR;
    
    [view addGestureRecognizer:tap];
    _backgroundView = view;
    [self addSubview:view];
  }
  return _backgroundView;
}

@end
