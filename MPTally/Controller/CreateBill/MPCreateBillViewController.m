//
//  MPCreateBillViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateBillViewController.h"
#import "MPIncomeCategoryViewController.h"
#import "MPOutcomeCategoryViewController.h"

@interface MPCreateBillViewController ()<UIScrollViewDelegate>

/// 水平滚动容器
@property (nonatomic, weak) UIScrollView *contentView;
/// 导航栏分栏
@property (nonatomic, weak) UISegmentedControl *segCrt;

@end

@implementation MPCreateBillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self setupNavigationBar];
  [self setupUI];
  self.segCrt.selectedSegmentIndex = 1;
}

/// 设置导航栏
- (void)setupNavigationBar
{
  UISegmentedControl *segCtr = [[UISegmentedControl alloc] initWithItems:@[@"收入", @"支出"]];
  [segCtr addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
  self.navigationItem.titleView = segCtr;
  self.segCrt = segCtr;
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
  self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}

- (void)setupUI
{
  self.contentView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
  MPIncomeCategoryViewController *incomeVC = [[MPIncomeCategoryViewController alloc] init];
  MPOutcomeCategoryViewController *outcomeVC = [[MPOutcomeCategoryViewController alloc] init];
  [self addChildViewController:incomeVC];
  [self addChildViewController:outcomeVC];
  
  incomeVC.view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
  outcomeVC.view.frame = CGRectMake(kScreenW, 0, kScreenW, kScreenH);
  [self.contentView addSubview:incomeVC.view];
  [self.contentView addSubview:outcomeVC.view];
  
  self.contentView.contentSize = CGSizeMake(kScreenW * 2, kScreenH);
}

#pragma mark - Action
/// 切换收入 / 支出
- (void)segChange:(UISegmentedControl *)segCrt
{
  [self.contentView setContentOffset:CGPointMake(kScreenW * segCrt.selectedSegmentIndex, 0) animated:YES];
}

/// 退出
- (void)cancel
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  //设置标题栏的位置
  NSInteger index = scrollView.contentOffset.x / self.view.mp_width;
  self.segCrt.selectedSegmentIndex = index;
}

#pragma mark - getter
- (UIScrollView *)contentView
{
  if(_contentView == nil)
  {
    UIScrollView *view = [[UIScrollView alloc] init];
    view.showsHorizontalScrollIndicator = NO;
    view.delegate = self;
    view.backgroundColor = [UIColor whiteColor];
    view.bounces = YES;
    view.alwaysBounceHorizontal = YES;
    _contentView = view;
    view.pagingEnabled = YES;
    [self.view addSubview:view];
  }
  return _contentView;
}

@end
