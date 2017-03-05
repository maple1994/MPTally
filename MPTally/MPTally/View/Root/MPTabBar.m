//
//  MPTabBar.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTabBar.h"

@interface MPTabBar ()
/// 中间创建账单按钮
@property (nonatomic, weak) UIButton *createButton;
@end

@implementation MPTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
  
  if (self = [super initWithFrame:frame])
  {
    //添加中间的按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(create) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setImage:[UIImage imageNamed:@"tabbar_create"] forState:UIControlStateNormal];
    
    [btn sizeToFit];
    self.createButton = btn;
    [self addSubview:btn];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  //设置中间按钮的位置
  CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
  
  self.createButton.center = center;
  CGFloat wid = self.frame.size.width / 5;
  CGFloat hei = self.frame.size.height;
  NSInteger index = 0;
  //设置子控件的位置
  for (UIView *view in self.subviews)
  {
    if (view == self.createButton || ![view isKindOfClass:[UIControl class]])
      continue;
    NSInteger temp = index;
    if (index > 1)
      temp++;
    view.frame = CGRectMake(temp * wid, 0, wid, hei);
    index++;
    
  }
  
}

- (void)create
{
  kFuncNameLog
}

@end
