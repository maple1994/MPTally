//
//  MPTopBarView.m
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTopBarView.h"

@interface MPTopBarView ()

@property (nonatomic, weak) UIButton *titleButton;

@end

@implementation MPTopBarView

- (instancetype)init
{
  if(self = [super init])
  {
    [self setupUI];
  }
  return self;
}

- (void)setupUI
{
  [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self);
    make.centerX.equalTo(self);
  }];
  self.backgroundColor = [UIColor whiteColor];
}

- (void)buttonClick
{
  if([self.delegate respondsToSelector:@selector(topBarView:didClickTitleButton:)])
  {
    [self.delegate topBarView:self didClickTitleButton:self.titleButton];
  }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [_titleButton setTitle:title forState:UIControlStateNormal];
}

- (UIButton *)titleButton
{
  if(_titleButton == nil)
  {
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"默认账本" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = 1;
    
    button.layer.borderColor = kTimeLineColor.CGColor;
    button.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    [button sizeToFit];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    _titleButton = button;
    [self addSubview:button];
  }
  return _titleButton;
}

@end
