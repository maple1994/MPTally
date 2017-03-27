//
//  MPReportFormViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPReportFormViewController.h"
#import "MPLineChartViewController.h"
#import "MPPieChartViewController.h"

@interface MPReportFormViewController ()<UIScrollViewDelegate>

/// 水平滚动容器
@property (nonatomic, weak) UIScrollView *contentView;
/// 导航栏分栏
@property (nonatomic, weak) UISegmentedControl *segCrt;

@end

@implementation MPReportFormViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self setupNavigationBar];
  [self setupUI];
  self.segCrt.selectedSegmentIndex = 0;
}

/// 设置导航栏
- (void)setupNavigationBar
{
  UISegmentedControl *segCtr = [[UISegmentedControl alloc] initWithItems:@[@"分类", @"趋势"]];
  [segCtr addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
  self.navigationItem.titleView = segCtr;
  self.segCrt = segCtr;
}

- (void)segChange:(UISegmentedControl *)segCrtl
{
  [self.contentView setContentOffset:CGPointMake(kScreenW * segCrtl.selectedSegmentIndex, 0) animated:YES];
}

- (void)setupUI
{
  self.contentView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
  MPPieChartViewController *pieVC = [[MPPieChartViewController alloc] init];
  MPLineChartViewController *lineVC = [[MPLineChartViewController alloc] init];
  [self addChildViewController:pieVC];
  [self addChildViewController:lineVC];
  
  pieVC.view.frame = CGRectMake(0, 0, kScreenW, kScreenH);
  lineVC.view.frame = CGRectMake(kScreenW, 0, kScreenW, kScreenH);
  [self.contentView addSubview:pieVC.view];
  [self.contentView addSubview:lineVC.view];
  self.contentView.contentSize = CGSizeMake(kScreenW * 2, kScreenH);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  //设置标题栏的位置
  NSInteger index = scrollView.contentOffset.x / self.view.mp_width;
  self.segCrt.selectedSegmentIndex = index;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
  [self scrollViewDidEndDecelerating:scrollView];
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
    view.alwaysBounceHorizontal = NO;
    _contentView = view;
    view.pagingEnabled = YES;
    [self.view addSubview:view];
  }
  return _contentView;
}



@end
