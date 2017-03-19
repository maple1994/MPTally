//
//  MPEditColorTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPEditAccountTableViewCell.h"

@interface MPEditAccountTableViewCell ()

@property (nonatomic, weak) UIImageView *indicator;
@property (nonatomic, weak) UILabel *myTitleLabel;
@property (nonatomic, weak) UILabel *myDetailLabel;
@property (nonatomic, weak) UIView *selectColorView;

@end

@implementation MPEditAccountTableViewCell

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
  [self.myTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.contentView).offset(10);
    make.centerY.equalTo(self.contentView);
  }];
  [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.contentView);
    make.trailing.equalTo(self.contentView).offset(-10);
  }];
  [self.myDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.contentView);
    make.trailing.equalTo(self.indicator.mas_leading).offset(-5);
  }];
  [self.selectColorView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.contentView);
    make.trailing.equalTo(self.indicator.mas_leading).offset(-5);
    make.height.width.mas_equalTo(20);
  }];
}

#pragma mark - getter and setter
- (void)setMyDetailTitle:(NSString *)myDetailTitle
{
  _myDetailTitle = myDetailTitle;
  self.myDetailLabel.text = myDetailTitle;
  self.myDetailLabel.hidden = NO;
  self.selectColorView.hidden = YES;
}

- (void)setMyTitle:(NSString *)myTitle
{
  _myTitle = myTitle;
  self.myTitleLabel.text = myTitle;
}

- (void)setSelectedColor:(NSString *)selectedColor
{
  _selectedColor = selectedColor;
  self.selectColorView.backgroundColor = [UIColor colorWithHexString:selectedColor];
  self.myDetailLabel.hidden = YES;
  self.selectColorView.hidden = NO;
}

- (UIImageView *)indicator
{
  if(_indicator == nil)
  {
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"disclosureIn_dicator"]];
    _indicator = iv;
    [self.contentView addSubview:iv];
  }
  return _indicator;
}

- (UILabel *)myTitleLabel
{
  if(_myTitleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    _myTitleLabel = label;
    [self.contentView addSubview:label];
  }
  return _myTitleLabel;
}

- (UILabel *)myDetailLabel
{
  if(_myDetailLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:13];
    _myDetailLabel = label;
    [self.contentView addSubview:label];
  }
  return _myDetailLabel;
}

- (UIView *)selectColorView
{
  if(_selectColorView == nil)
  {
    UIView *view = [[UIView alloc] init];
    _selectColorView = view;
    view.layer.cornerRadius = 3;
    view.layer.masksToBounds = YES;
    [self.contentView addSubview:view];
  }
  return _selectColorView;
}


@end
