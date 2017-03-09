//
//  MPEditRemarkViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPEditRemarkViewController.h"
#import "FQPlaceholderTextView.h"

@interface MPEditRemarkViewController ()

@property (nonatomic, strong) FQPlaceholderTextView *textView;

@end

@implementation MPEditRemarkViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self setupNav];
  [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view).offset(0);
    make.leading.trailing.bottom.equalTo(self.view);
  }];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  [self.textView resignFirstResponder];
}

/// 设置导航栏
- (void)setupNav
{
  self.navigationItem.title = @"备注";
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(complete)];
  self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
  self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
  self.navigationItem.rightBarButtonItem.enabled = NO;
}

/// 输入监听
- (void)textChange
{
  self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length > 0;
}

/// 取消
- (void)cancel
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

/// 完成
- (void)complete
{
  
}

#pragma mark - getter
- (FQPlaceholderTextView *)textView
{
  if(_textView == nil)
  {
    FQPlaceholderTextView *view = [[FQPlaceholderTextView alloc] init];
    _textView = view;
    _textView.placeholder = @"记录生活点点滴滴";
    _textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_textView];
  }
  return _textView;
}

@end
