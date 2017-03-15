//
//  MPCreateBookCollectionViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/15.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateBookCollectionViewCell.h"

@interface MPCreateBookCollectionViewCell ()

/// 新建账本视图
@property (nonatomic, weak) UIView *creativeView;
/// 标题
@property (nonatomic, weak) UILabel *creativeLabel;
/// 添加按钮
@property (nonatomic, weak) UIButton *addButton;
/// 新建视图的背景图
@property (nonatomic, weak) UIImageView *creativeBgImageView;

@end

@implementation MPCreateBookCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
    [self setup];
  }
  return self;
}

- (void)setup
{
  [self.creativeBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView);
  }];
  [self.creativeBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.creativeBgImageView);
  }];
  [self.creativeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.creativeBgImageView);
    make.top.equalTo(self.creativeBgImageView).offset(20);
  }];
  [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.creativeBgImageView);
    make.height.width.mas_equalTo(30);
  }];
}

#pragma mark - getter
- (UIView *)creativeView
{
  if(_creativeView == nil)
  {
    UIView *view = [[UIView alloc] init];
    _creativeView = view;
    [self.contentView addSubview:view];
  }
  return _creativeView;
}

- (UILabel *)creativeLabel
{
  if(_creativeLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"新建账本";
    _creativeLabel = label;
    [self.creativeView addSubview:label];
  }
  return _creativeLabel;
}

- (UIImageView *)creativeBgImageView
{
  if(_creativeBgImageView == nil)
  {
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_book_bg"]];
    _creativeBgImageView = iv;
    [self.creativeView addSubview:iv];
  }
  return _creativeBgImageView;
}

- (UIButton *)addButton
{
  if(_addButton == nil)
  {
    UIButton *btn = [[UIButton alloc] init];
    _addButton = btn;
    [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.creativeView addSubview:btn];
  }
  return _addButton;
}


@end
