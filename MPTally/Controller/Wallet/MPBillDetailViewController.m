//
//  MPBillDetailViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/23.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBillDetailViewController.h"
#import "MPBillDetailHeaderView.h"
#import "MPBillDetailBodyView.h"
#import "MPCreateBillViewController.h"
#import "CCColorCube.h"

@interface MPBillDetailViewController ()

@property (nonatomic, weak) UIView *topbarView;
/// 头部
@property (nonatomic, weak) MPBillDetailHeaderView *billDetailHeaderView;
/// 驱赶
@property (nonatomic, weak) MPBillDetailBodyView *bodyDetailView;
/// 尾部备注
@property (nonatomic, weak) UILabel *remarkLabel;
/// 底部编辑栏
@property (nonatomic, weak) UIView *bottomEditView;
/// 提取的颜色
@property (nonatomic, strong) UIColor *extractColor;
@end

@implementation MPBillDetailViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupUI];
  [self setupNav];
}

- (void)setupUI
{
  self.automaticallyAdjustsScrollViewInsets = NO;
  self.view.backgroundColor = [UIColor whiteColor];
  [self.topbarView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.leading.trailing.equalTo(self.view);
    make.height.mas_equalTo(64);
  }];
  [self.billDetailHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.topbarView.mas_bottom);
    make.leading.trailing.equalTo(self.view);
    make.height.mas_equalTo(80);
  }];
  [self.bodyDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.billDetailHeaderView.mas_bottom);
    make.leading.trailing.equalTo(self.view);
  }];
  [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.bodyDetailView.mas_bottom).offset(20);
    make.leading.equalTo(self.view).offset(10);
    make.trailing.equalTo(self.view).offset(-10);
  }];
  [self.bottomEditView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.bottom.equalTo(self.view);
    make.height.mas_equalTo(50);
  }];
}

/// 给界面元素重新赋值
- (void)resetBillDetail
{
  self.billDetailHeaderView.bill = self.bill;
  self.bodyDetailView.bill = self.bill;
  self.remarkLabel.text = self.bill.remark;

}

- (void)setupNav
{
  UILabel *label = [[UILabel alloc] init];
  label.text = @"详情";
  label.textColor = [UIColor whiteColor];
  [label sizeToFit];
  self.navigationItem.titleView = label;

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delete)];
}

/// 删除
- (void)delete
{
  UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"你确定要删除所选的账目吗？" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    if(self.delteBlock)
      self.delteBlock(self.bill);
    [self.navigationController popViewControllerAnimated:YES];
  }];
  UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
  [alertVC addAction:confirmAction];
  [alertVC addAction:cancelAction];
  [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

/// 编辑
- (void)edit
{
  MPCreateBillViewController *vc = [[MPCreateBillViewController alloc] init];
  vc.selectedBill = self.bill;
  [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
  // 设置导航栏背景为透明
  [self.navigationController.navigationBar setBackgroundImage:[UIImage new]forBarMetrics:UIBarMetricsDefault];
  // 隐藏导航栏底部黑线
  self.navigationController.navigationBar.shadowImage = [UIImage new];
  [self resetBillDetail];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
  // 还原导航栏样式
  [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
  self.navigationController.navigationBar.shadowImage = nil;
}

#pragma mark - getter
- (UIColor *)extractColor
{
  if(_extractColor == nil)
  {
    CCColorCube *imageColor = [[CCColorCube alloc] init];
    NSArray *colors = [imageColor extractColorsFromImage:[UIImage imageNamed:_bill.category.categoryImageFileName] flags:CCAvoidBlack count:1];
    _extractColor = colors.firstObject;
  }
  return _extractColor;
}

- (UIView *)topbarView
{
  if(_topbarView == nil)
  {
    UIView *view = [[UIView alloc] init];
    _topbarView = view;
    _topbarView.backgroundColor = self.extractColor;
    [self.view addSubview:view];
  }
  return _topbarView;
}

- (MPBillDetailHeaderView *)billDetailHeaderView
{
  if(_billDetailHeaderView == nil)
  {
    MPBillDetailHeaderView *view = [MPBillDetailHeaderView viewFromNib];
    [self.view addSubview:view];
    _billDetailHeaderView = view;
  }
  return _billDetailHeaderView;
}

- (MPBillDetailBodyView *)bodyDetailView
{
  if(_bodyDetailView == nil)
  {
    MPBillDetailBodyView *view = [MPBillDetailBodyView viewFromNib];
    [self.view addSubview:view];
    _bodyDetailView = view;
  }
  return _bodyDetailView;
}

- (UILabel *)remarkLabel
{
  if(_remarkLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    _remarkLabel = label;
    [self.view addSubview:label];
  }
  return _remarkLabel;
}

- (UIView *)bottomEditView
{
  if(_bottomEditView == nil)
  {
    UIView *view = [[UIView alloc] init];
    _bottomEditView = view;
    [self.view addSubview:view];
    
    // 设置分割线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = colorWithRGB(240, 240, 240);
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.trailing.top.equalTo(view);
      make.height.mas_equalTo(1);
    }];
    // 设置按钮
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"2FB2E8"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(edit) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(view);
    }];
  }
  return _bottomEditView;
}


@end
