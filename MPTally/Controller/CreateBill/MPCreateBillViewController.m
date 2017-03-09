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
#import "MPCalculatorView.h"
#import "MPCalendarView.h"
#import "MPAccountPickerView.h"
#import "MPEditRemarkViewController.h"
#import "MPCategoryManager.h"

@interface MPCreateBillViewController ()<UIScrollViewDelegate, CategoryCollectionViewControllerDelegate, MPCalculatorViewDelegate, FSCalendarDelegate, AccountPickerViewDelegate>

/// 水平滚动容器
@property (nonatomic, weak) UIScrollView *contentView;
/// 导航栏分栏
@property (nonatomic, weak) UISegmentedControl *segCrt;
/// 头部显示编辑结果的View
@property (nonatomic, weak) MPCreateBillHeaderView *resultView;
/// 计算器
@property (nonatomic, weak) MPCalculatorView *calculatorView;
/// 是否已经显示计算器
@property (nonatomic, assign, getter=isShowCalculator) BOOL showCalculator;
/// 日历View
@property (nonatomic, strong) MPCalendarView *calendarView;
/// 账户模型数组
@property (nonatomic, strong) NSArray *accoutModelArray;
/// 备注
@property (nonatomic, copy) NSString *remark;

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
  
  [self showCalcultor];
}

#pragma mark - Private
/// 显示计算器
- (void)showCalcultor
{
  if(!self.isShowCalculator)
  {
    self.showCalculator = YES;
    [UIView animateWithDuration:0.25 animations:^{
      self.calculatorView.frame = CGRectMake(0, kScreenH * 0.6, kScreenW, kScreenH * 0.4);
    }];
  }
}

/// 隐藏计算器
- (void)hideCalcultor
{
  if(self.isShowCalculator)
  {
    self.showCalculator = NO;
    [UIView animateWithDuration:0.25 animations:^{
      self.calculatorView.frame = CGRectMake(0, kScreenH, kScreenW, kScreenH * 0.4);
    }];
  }
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

/// 显示日期选择器
- (void)showCalendarPicker
{
  [self.view addSubview:self.calendarView];
}

/// 显示账户选择器
- (void)showAccountPicker
{
  MPAccountPickerView *picker = [[MPAccountPickerView alloc] initWithAccountModelArray:self.accoutModelArray];
  picker.delegate = self;
  picker.frame = self.view.bounds;
  [self.view addSubview:picker];
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
  [self showCalcultor];
}

- (void)categoryCollectionViewDidScrollUp:(UICollectionView *)collectionView
{
    [self hideCalcultor];
}

- (void)categoryCollectionViewDidScrollDown:(UICollectionView *)collectionView
{
    [self showCalcultor];
}

#pragma mark - MPCalculatorViewDelegate
- (void)calculatorViewDidClickCalendar:(MPCalculatorView *)view
{
  [self showCalendarPicker];
}

- (void)calculatorView:(MPCalculatorView *)view passTheResult:(NSString *)result
{
  self.resultView.results = result;
}

- (void)calculatorViewDidClickAccount:(MPCalculatorView *)view
{
  [self showAccountPicker];
}

- (void)calculatorViewDidClickRemark:(MPCalculatorView *)view
{
  MPEditRemarkViewController *vc = [[MPEditRemarkViewController alloc] init];
  vc.remark = self.remark;
  UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
  [self presentViewController:nav animated:YES completion:nil];
  
  // 设置回调
  [vc setCompleteBlock:^(NSString *remark) {
    self.remark = remark;
  }];
}

#pragma mark - FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
  self.calculatorView.selectedDate = date;
  [self.calendarView dismiss];
}

#pragma mark - AccountPickerViewDelegate
- (void)accountPickerView:(MPAccountPickerView *)pickerView didSelectAccount:(MPAccountModel *)accountModel
{
  self.calculatorView.selectedAccount = accountModel;
  [pickerView dismiss];
}

#pragma mark - getter
- (NSArray *)accoutModelArray
{
  if(_accoutModelArray == nil)
  {
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 1; i <= 6; i++)
    {
      MPAccountModel *model = [[MPAccountModel alloc] init];
      model.accountName = [NSString stringWithFormat:@"钱包%zd", i];
      model.money = 666.54;
      [temp addObject:model];
    }
    _accoutModelArray = temp;
  }
  return _accoutModelArray;
}

- (MPCalendarView *)calendarView
{
  if(_calendarView == nil)
  {
    _calendarView = [[MPCalendarView alloc] init];
    _calendarView.calendarView.delegate = self;
    _calendarView.frame = self.view.bounds;
  }
  return _calendarView;
}

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

- (MPCalculatorView *)calculatorView
{
  if(_calculatorView == nil)
  {
    MPCalculatorView *view = [MPCalculatorView viewFromNib];
    _calculatorView = view;
    _calculatorView.delegate = self;
    _calculatorView.backgroundColor = kRandomColor;
    [self.view addSubview:_calculatorView];
  }
  return _calculatorView;
}

@end
