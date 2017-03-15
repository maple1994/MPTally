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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self).offset(150);
    }];
    [UIView animateWithDuration:0.5 animations:^{
      [self layoutIfNeeded];
    }completion:^(BOOL finished) {
      [self.textField becomeFirstResponder];
    }];
  });
}

- (void)setup
{
  [self.bgHUD mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self).offset(-300);
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

#pragma mark - Action
/// 确定
- (void)confirm
{
  if(self.textField.text.length == 0)
  {
    [SVProgressHUD showTips:@"请填写账本名称"];
  }
  else if(self.textField.text.length > 4)
  {
    [SVProgressHUD showTips:@"账本名字最多只能四个字"];
  }
  else
  {
    if(_book)
    {
      // 更新账本
      [[MPBookManager shareManager] updateBookName:self.textField.text book:self.book];
    }
    else
    {
      // 添加新的账本
      MPBookModel *book = [[MPBookModel alloc] init];
      book.bookName = self.textField.text;
      [[MPBookManager shareManager] insertBook:book];
    }
    [self cancel];
  }
}

/// 取消
- (void)cancel
{
  [self removeFromSuperview];
}

/// 删除账本
- (void)deleteBook
{
  [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self).offset(kScreenH);
  }];
  [UIView animateWithDuration:0.5 animations:^{
    [self layoutIfNeeded];
  }completion:^(BOOL finished) {
    [[MPBookManager shareManager] deleteBook:_book];
    [self cancel];
  }];
}

/// 弹窗提示是否删除
- (void)showAlertView
{
  [self.textField resignFirstResponder];
  UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要删除这个账本吗？" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    [self deleteBook];
  }];
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
  [alertVC addAction:confirmAction];
  [alertVC addAction:cancelAction];
  [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - getter or setter
- (void)setBook:(MPBookModel *)book
{
  _book = book;
  self.textField.text = book.bookName;
  self.deleteButton.hidden = !book;
  self.titleLabel.text = (book) ? @"编辑账本" : @"创建账本";
}

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
    [button addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor whiteColor];
    button.hidden = YES;
    [button setTitle:@"删除账本" forState:UIControlStateNormal];
    _deleteButton = button;
    [self.inputAear addSubview:button];
  }
  return _deleteButton;
}


@end
