//
//  MPCreateBookView.m
//  MPTally
//
//  Created by Maple on 2017/3/15.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateBookView.h"
#import "MPBookManager.h"

@interface MPCreateBookView ()

/// 输入框
@property (nonatomic, weak) UITextField *textField;
/// 输入框标题
@property (nonatomic, weak) UILabel *textFieldLabel;
/// 内容区域
@property (nonatomic, weak) UIView *contentView;
/// 确认按钮
@property (nonatomic, weak) UIButton *confirmButton;
/// 取消按钮
@property (nonatomic, weak) UIButton *cancelButton;
/// 标题
@property (nonatomic, weak) UILabel *titleLabel;
/// 标题栏区域
@property (nonatomic, weak) UIView *titleAear;
/// 输入框区域
@property (nonatomic, weak) UIView *inputAear;
/// 背景蒙版
@property (nonatomic, weak) UIView *bgHUD;
/// 删除按钮
@property (nonatomic, weak) UIButton *deleteButton;

@end

@implementation MPCreateBookView

- (instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
    [self setup];
  }
  return self;
}

- (void)didMoveToSuperview
{
  [self.textField becomeFirstResponder];
}

- (void)setup
{
  [self.bgHUD mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self).offset(150);
    make.centerX.equalTo(self);
    make.width.mas_equalTo(kScreenW * 0.6);
  }];
  [self.titleAear mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.top.equalTo(self.contentView);
    make.height.mas_equalTo(50);
  }];
  [self.inputAear mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.titleAear.mas_bottom);
    make.leading.trailing.bottom.equalTo(self.contentView);
  }];
  [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.titleAear);
  }];
  [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.titleAear);
    make.leading.equalTo(self.titleAear).offset(10);
  }];
  [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(self.titleAear);
    make.trailing.equalTo(self.titleAear).offset(-10);
  }];
  [self.textFieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.inputAear).offset(10);
    make.leading.equalTo(self.inputAear).offset(10);
  }];
  [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.textFieldLabel.mas_bottom);
    make.leading.trailing.equalTo(self.inputAear);
    make.height.mas_equalTo(30);
  }];
  [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.textField.mas_bottom).offset(1);
    make.leading.trailing.bottom.equalTo(self.inputAear);
    make.height.mas_equalTo(30);
  }];
  self.titleAear.backgroundColor = [UIColor whiteColor];
  self.inputAear.backgroundColor = colorWithRGB(240, 240, 240);
}

- (void)confirm
{
  if(self.textField.text.length > 4)
  {
    [SVProgressHUD showTips:@"账本名字最多只能四个字"];
  }
  else
  {
    MPBookModel *book = [[MPBookModel alloc] init];
    book.bookName = self.textField.text;
    [[MPBookManager shareManager] insertBook:book];
    [self cancel];
  }
}

- (void)cancel
{
  [self removeFromSuperview];
}

- (void)deleteBook
{
  kFuncNameLog;
}

- (void)setBook:(MPBookModel *)book
{
  _book = book;
  self.textField.text = book.bookName;
  self.deleteButton.hidden = !book;
  self.titleLabel.text = (book) ? @"编辑账本" : @"创建账本";
}

#pragma mark - getter
- (UIButton *)cancelButton
{
  if(_cancelButton == nil)
  {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelButton = btn;
    [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [self.titleAear addSubview:btn];
  }
  return _cancelButton;
}

- (UIButton *)confirmButton
{
  if(_confirmButton == nil)
  {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    _confirmButton = btn;
    [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [self.titleAear addSubview:btn];
  }
  return _confirmButton;
}

- (UITextField *)textField
{
  if(_textField == nil)
  {
    UITextField *field = [[UITextField alloc] init];
    field.font = [UIFont systemFontOfSize:15];
    field.leftViewMode = UITextFieldViewModeAlways;
    field.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    field.backgroundColor = [UIColor whiteColor];
    _textField = field;
    [self.inputAear addSubview:field];
  }
  return _textField;
}

- (UILabel *)titleLabel
{
  if(_titleLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"新建账单";
    _titleLabel = label;
    [self.titleAear addSubview:label];
  }
  return _titleLabel;
}

- (UIView *)titleAear
{
  if(_titleAear == nil)
  {
    UIView *view = [[UIView alloc] init];
    _titleAear = view;
    [self.contentView addSubview:view];
  }
  return _titleAear;
}

- (UIView *)inputAear
{
  if(_inputAear == nil)
  {
    UIView *view = [[UIView alloc] init];
    _inputAear = view;
    [self.contentView addSubview:view];
  }
  return _inputAear;
}

- (UIView *)contentView
{
  if(_contentView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 5;
    view.layer.masksToBounds = YES;
    _contentView = view;
    [self addSubview:view];
  }
  return _contentView;
}

- (UILabel *)textFieldLabel
{
  if(_textFieldLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"账本名称";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor lightGrayColor];
    _textFieldLabel = label;
    [self.inputAear addSubview:label];
  }
  return _textFieldLabel;
}

- (UIView *)bgHUD
{
  if(_bgHUD == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.3;
    _bgHUD = view;
    [self addSubview:view];
  }
  return _bgHUD;
}

- (UIButton *)deleteButton
{
  if(_deleteButton == nil)
  {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button addTarget:self action:@selector(deleteBook) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.hidden = YES;
    [button setTitle:@"删除账本" forState:UIControlStateNormal];
    _deleteButton = button;
    [self.inputAear addSubview:button];
  }
  return _deleteButton;
}


@end
