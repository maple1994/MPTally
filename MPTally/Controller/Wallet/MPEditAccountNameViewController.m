//
//  MPEditAccountNameViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPEditAccountNameViewController.h"
#import "FQPlaceholderTextView.h"

@interface MPEditAccountNameViewController ()

@property (nonatomic, weak) FQPlaceholderTextView *textView;

@end

@implementation MPEditAccountNameViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.equalTo(self.view).offset(10);
    make.trailing.equalTo(self.view).offset(-10);
    make.top.bottom.equalTo(self.view);
  }];
  [self setupNav];
  self.textView.text = _accountName;
}

- (void)setupNav
{
  self.title = @"编辑账户名称";
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(done)];
}

- (void)done
{
  self.accountName = self.textView.text;
  if(self.doneBlock)
    self.doneBlock(self.accountName);
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter
- (FQPlaceholderTextView *)textView
{
  if(_textView == nil)
  {
    FQPlaceholderTextView *view = [[FQPlaceholderTextView alloc] init];
    view.font = [UIFont systemFontOfSize:20];
    view.placeholder = @"请输入账户名称";
    _textView = view;
    [self.view addSubview:view];
  }
  return _textView;
}

@end
