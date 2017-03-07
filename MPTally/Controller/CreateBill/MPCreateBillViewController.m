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
#import "MPCreateBillHeaderView.h"
#import "MPCategoryCollectionViewCell.h"
#import "MPCategoryModel.h"

@interface MPCreateBillViewController ()<UIScrollViewDelegate, CategoryCollectionViewControllerDelegate>

/// 水平滚动容器
@property (nonatomic, weak) UIScrollView *contentView;
/// 导航栏分栏
@property (nonatomic, weak) UISegmentedControl *segCrt;
/// 头部显示编辑结果的View
@property (nonatomic, weak) MPCreateBillHeaderView *resultView;

@end

@implementation MPCreateBillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self setupNavigationBar];
  [self setupUI];
  self.segCrt.selectedSegmentIndex = 1;
  [self segChange:self.segCrt];
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
  self.resultView.frame = CGRectMake(0, 64, kScreenW, 60);
  MPIncomeCategoryViewController *incomeVC = [[MPIncomeCategoryViewController alloc] init];
  MPOutcomeCategoryViewController *outcomeVC = [[MPOutcomeCategoryViewController alloc] init];
  incomeVC.cateDelegate = self;
  outcomeVC.cateDelegate = self;
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
  MPBaseCategoryCollectionViewController *vc = self.childViewControllers[index];
  self.resultView.categoryModel = vc.categotyModelArray.firstObject;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
  [self scrollViewDidEndDecelerating:scrollView];
}

#pragma mark - CategoryCollectionViewControllerDelegate
- (void)categoryCollectionView:(UICollectionView *)collectionView didSelectCell:(MPCategoryCollectionViewCell *)cell
{
  self.resultView.categoryModel = cell.categoryModel;
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

- (MPCreateBillHeaderView *)resultView
{
  if(_resultView == nil)
  {
    MPCreateBillHeaderView *view = [MPCreateBillHeaderView viewFromNib];
    _resultView = view;
    [self.view addSubview:view];
  }
  return _resultView;
}

@end
