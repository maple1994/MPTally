//
//  MPBookListCollectionViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/15.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBookListCollectionViewCell.h"

@interface MPBookListCollectionViewCell ()

@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *bgImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *markImageView;

@end

@implementation MPBookListCollectionViewCell

//- (instancetype)init
//{
//  if(self = [super init])
//  {
//    [self setup];
//  }
//  return self;
//}

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
  [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView);
  }];
  [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.bgView);
  }];
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.bgView);
    make.top.equalTo(self.bgView).offset(20);
  }];
  [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.trailing.equalTo(self.bgView).offset(-5);
    make.bottom.equalTo(self.bgView).offset(-5);
  }];
}

#pragma mark - getter
- (UIView *)bgView
{
  if(_bgView == nil)
  {
    UIView *view = [[UIView alloc] init];
    [self.contentView addSubview:view];
    _bgView = view;
  }
  return _bgView;
}

- (UIImageView *)bgImageView
{
  if(_bgImageView == nil)
  {
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"book_bg"]];
    _bgImageView = iv;
    [self.bgView addSubview:iv];
  }
  return _bgImageView;
}

- (UILabel *)titleLabel
{
  if(_titleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"默认账本";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    _titleLabel = label;
    [self.bgView addSubview:label];
  }
  return _titleLabel;
}

- (UIImageView *)markImageView
{
  if(_markImageView == nil)
  {
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gou_white"]];
    _markImageView = iv;
    [self.bgView addSubview:iv];
  }
  return _markImageView;
}

@end
