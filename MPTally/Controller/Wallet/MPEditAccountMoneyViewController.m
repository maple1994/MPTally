//
//  MPEditAccountMoneyViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPEditAccountMoneyViewController.h"
#import "FQPlaceholderTextView.h"
#import "MPCalculatorView.h"

@interface MPEditAccountMoneyViewController ()<MPCalculatorViewDelegate>

/// 余额Label
@property (nonatomic, weak) UILabel *balanceLabel;
/// 数字输入键盘
@property (nonatomic, weak) MPCalculatorView *calculatorView;

@end

@implementation MPEditAccountMoneyViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.view).offset(-10);
    make.top.equalTo(self.view).offset(74);
  }];
  [self.calculatorView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.bottom.equalTo(self.view);
    make.height.mas_equalTo(kScreenH * 0.4);
  }];
  [self setupNav];
  self.balanceLabel.text = [MyUtils numToString:self.banlance];
 
}

- (void)setupNav
{
  self.title = @"输入账户余额";
}

#pragma mark - MPCalculatorViewDelegate
- (void)calculatorView:(MPCalculatorView *)view passTheResult:(NSString *)result
{
  self.balanceLabel.text = result;
}

/// 点击了确定
- (void)calculatorViewDidClickConfirm:(MPCalculatorView *)view
{
  if(self.banlanceBlock)
    self.banlanceBlock([_balanceLabel.text doubleValue]);
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (MPCalculatorView *)calculatorView
{
  if(_calculatorView == nil)
  {
    MPCalculatorView *view = [MPCalculatorView viewFromNib];
    view.delegate = self;
    _calculatorView = view;
    _calculatorView.hideToolbar = YES;
    [self.view addSubview:view];
  }
  return _calculatorView;
}
- (UILabel *)balanceLabel
{
  if(_balanceLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"0.00";
    _balanceLabel = label;
    [self.view addSubview:label];
  }
  return _balanceLabel;
}

@end
