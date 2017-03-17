 //
//  MPBillTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTimeLineItemTableViewCell.h"
#import "MPTimeLineYearMonthMarkView.h"

@interface MPTimeLineItemTableViewCell ()

/// 类型按钮
@property (nonatomic, weak) UIButton *categoryButton;
/// 支出类型TitleLabel
@property (nonatomic, weak) UILabel *outComeCateTitleLabel;
/// 收入类型TitleLabel
@property (nonatomic, weak) UILabel *inComeCateTitleLabel;
/// 支出类型备注
@property (nonatomic, weak) UILabel *outComeRemarkLabel;
/// 收入类型备注
@property (nonatomic, weak) UILabel *inComeRemarkLabel;
/// 收入
@property (nonatomic, weak) UILabel *inComeNumLabel;
/// 支出
@property (nonatomic, weak) UILabel *outComeNumLabel;
/// 时间线
@property (nonatomic, weak) MPTimeLineYearMonthMarkView *lineView;
/// 删除按钮
@property (nonatomic, weak)  UIButton *deleteButton;
/// 编辑按钮
@property (nonatomic, weak) UIButton *editButton;
/// 记录是否正在显示编辑视图
@property (nonatomic, assign, getter=isShowEditView) BOOL showEditView;
/// 测试时间Label
@property (nonatomic, weak) UILabel *testLabel;

@end

@implementation MPTimeLineItemTableViewCell

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
  // 编辑视图
  [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.categoryButton);
    make.width.height.equalTo(self.categoryButton);
  }];
  [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.categoryButton);
    make.width.height.equalTo(self.categoryButton);
  }];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self.categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.contentView);
    make.top.equalTo(self.contentView);
    make.width.height.mas_equalTo(25);
  }];
  // 支出
  [self.outComeCateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.categoryButton);
    make.leading.equalTo(self.categoryButton.mas_trailing).offset(10);
  }];
  [self.outComeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.outComeCateTitleLabel);
    make.leading.equalTo(self.outComeCateTitleLabel.mas_trailing).offset(5);
  }];
  [self.outComeRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.outComeCateTitleLabel.mas_bottom).offset(0);
    make.leading.equalTo(self.outComeCateTitleLabel);
    make.trailing.equalTo(self.contentView).offset(-10);
  }];
  
  // 收入
  [self.inComeCateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.categoryButton);
    make.trailing.equalTo(self.categoryButton.mas_leading).offset(-10);
  }];
  [self.inComeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.inComeCateTitleLabel);
    make.trailing.equalTo(self.inComeCateTitleLabel.mas_leading).offset(-5);
  }];
  [self.inComeRemarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.inComeCateTitleLabel.mas_bottom).offset(0);
    make.trailing.equalTo(self.inComeCateTitleLabel);
    make.leading.equalTo(self.contentView).offset(10);
  }];
  [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.categoryButton.mas_bottom);
    make.bottom.equalTo(self.contentView);
    make.centerX.equalTo(self.contentView);
    make.width.mas_equalTo(1);
  }];
  [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX.equalTo(self.contentView);
    make.top.equalTo(self.categoryButton.mas_bottom);
  }];
  [self.contentView bringSubviewToFront:self.categoryButton];
}

- (void)setBill:(MPBillModel *)bill
{
  _bill = bill;
  self.testLabel.text = bill.dateStr;
  [self.categoryButton setImage:[UIImage imageNamed:bill.category.categoryImageFileName] forState:UIControlStateNormal];
  if(bill.isIncome)
    [self showIncome:bill];
  else
    [self showOutCome:bill];
}

/// 显示支出视图
- (void)showOutCome:(MPBillModel *)bill
{
  self.outComeCateTitleLabel.text = bill.category.categoryName;
  self.outComeNumLabel.text = [NSString stringWithFormat:@"%.02lf", bill.money];
  self.outComeRemarkLabel.text = bill.remark;
  
  self.outComeCateTitleLabel.hidden = NO;
  self.outComeNumLabel.hidden = NO;
  self.outComeRemarkLabel.hidden = NO;
  self.inComeCateTitleLabel.hidden = YES;
  self.inComeNumLabel.hidden = YES;
  self.inComeRemarkLabel.hidden = YES;
}

/// 显示收入视图
- (void)showIncome:(MPBillModel *)bill
{
  self.inComeCateTitleLabel.text = bill.category.categoryName;
  self.inComeNumLabel.text = [NSString stringWithFormat:@"%.02lf", bill.money];
  self.inComeRemarkLabel.text = bill.remark;
  
  self.outComeCateTitleLabel.hidden = YES;
  self.outComeNumLabel.hidden = YES;
  self.outComeRemarkLabel.hidden = YES;
  self.inComeCateTitleLabel.hidden = NO;
  self.inComeNumLabel.hidden = NO;
  self.inComeRemarkLabel.hidden = NO;
}

#pragma mark - Action
/// 显示编辑视图
- (void)showEditView
{
  if(self.isShowEditView)
  {
    [self hideEditView];
  }
  else
  {
    // 调用代理
    if([self.delegate respondsToSelector:@selector(timeLineItemCellDidShowEditView:)])
    {
      [self.delegate timeLineItemCellDidShowEditView:self];
    }
    // 设置状态量
    self.showEditView = YES;
    [self.editButton mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(self.categoryButton);
      make.trailing.equalTo(self.contentView).offset(-15);
      make.width.height.equalTo(self.categoryButton);
    }];
    [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.centerY.equalTo(self.categoryButton);
      make.leading.equalTo(self.contentView).offset(15);
      make.width.height.equalTo(self.categoryButton);
    }];
    [UIView animateWithDuration:0.25 animations:^{
      [self layoutIfNeeded];
    }];
  }
}

/// 隐藏编辑视图
- (void)hideEditView
{
  if(self.isShowEditView)
  {
    [self.editButton mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self.categoryButton);
      make.width.height.equalTo(self.categoryButton);
    }];
    [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self.categoryButton);
      make.width.height.equalTo(self.categoryButton);
    }];
    [UIView animateWithDuration:0.25 animations:^{
      [self layoutIfNeeded];
    }];
    self.showEditView = NO;
  }
}

/// 编辑
- (void)edit:(UIButton *)button
{
  kFuncNameLog;
  if([self.delegate respondsToSelector:@selector(timeLineItemCellDidClickEdit:)])
  {
    [self.delegate timeLineItemCellDidClickEdit:self];
  }
}

/// 删除
- (void)delete:(UIButton *)button
{
  kFuncNameLog;
  if([self.delegate respondsToSelector:@selector(timeLineItemCellDidClickDelete:)])
  {
    [self.delegate timeLineItemCellDidClickDelete:self];
  }
}

#pragma mark - getter
- (UIButton *)editButton
{
  if(_editButton == nil)
  {
    UIButton *btn = [[UIButton alloc] init];
    _editButton = btn;
    [btn setImage:[UIImage imageNamed:@"item_edit"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
  }
  return _editButton;
}

- (UIButton *)deleteButton
{
  if(_deleteButton == nil)
  {
    UIButton *btn = [[UIButton alloc] init];
    _deleteButton = btn;
    [btn setImage:[UIImage imageNamed:@"item_delete"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
  }
  return _deleteButton;
}

- (UILabel *)testLabel
{
  if(_testLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    _testLabel = label;
    [self.contentView addSubview:label];
  }
  return _testLabel;
}

- (MPTimeLineYearMonthMarkView *)lineView
{
  if(_lineView == nil)
  {
    MPTimeLineYearMonthMarkView *view = [[MPTimeLineYearMonthMarkView alloc] init];
    _lineView = view;
    [self.contentView addSubview:view];
  }
  return _lineView;
}

- (UIButton *)categoryButton
{
  if(_categoryButton == nil)
  {
    UIButton *button = [[UIButton alloc] init];
    _categoryButton = button;
    [button addTarget:self action:@selector(showEditView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
  }
  return _categoryButton;
}

- (UILabel *)outComeNumLabel
{
  if(_outComeNumLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    _outComeNumLabel = label;
    [self.contentView addSubview:label];
  }
  return _outComeNumLabel;
}

- (UILabel *)outComeCateTitleLabel
{
  if(_outComeCateTitleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    _outComeCateTitleLabel = label;
    [self.contentView addSubview:label];
  }
  return _outComeCateTitleLabel;
}

- (UILabel *)outComeRemarkLabel
{
  if(_outComeRemarkLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor lightGrayColor];
    _outComeRemarkLabel = label;
    [self.contentView addSubview:label];
  }
  return _outComeRemarkLabel;
}

- (UILabel *)inComeNumLabel
{
  if(_inComeNumLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    _inComeNumLabel = label;
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
  }
  return _inComeNumLabel;
}

- (UILabel *)inComeCateTitleLabel
{
  if(_inComeCateTitleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    _inComeCateTitleLabel = label;
    [self.contentView addSubview:label];
  }
  return _inComeCateTitleLabel;
}

- (UILabel *)inComeRemarkLabel
{
  if(_inComeRemarkLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentRight;
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor lightGrayColor];
    _inComeRemarkLabel = label;
    [self.contentView addSubview:label];
  }
  return _inComeRemarkLabel;
}


@end
