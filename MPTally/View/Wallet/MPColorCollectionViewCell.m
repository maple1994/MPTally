//
//  MPColorCollectionViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPColorCollectionViewCell.h"

@interface MPColorCollectionViewCell ()

@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIImageView *gouImageView;

@end

@implementation MPColorCollectionViewCell

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
  [self.gouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.contentView);
  }];
}

- (void)setHexColorString:(NSString *)hexColorString
{
  _hexColorString = hexColorString;
  self.bgView.backgroundColor = [UIColor colorWithHexString:hexColorString];
}

- (void)setShowSelectedMark:(BOOL)showSelectedMark
{
  _showSelectedMark = showSelectedMark;
  self.gouImageView.hidden = !showSelectedMark;
}

#pragma mark - getter
- (UIView *)bgView
{
  if(_bgView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    _bgView = view;
    [self.contentView addSubview:view];
  }
  return _bgView;
}

- (UIImageView *)gouImageView
{
  if(_gouImageView == nil)
  {
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gou_white"]];
    iv.hidden = YES;
    _gouImageView = iv;
    [self.contentView addSubview:iv];
  }
  return _gouImageView;
}

@end
