//
//  MPCreateBillViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateBillViewController.h"
#import "MPCategoryCollectionViewCell.h"
#import "MPCreateBillHeaderView.h"
#import "MPCategoryModel.h"
#define kColumnCount 5

@interface MPCreateBillViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/// 存放账单类型的collectionView
@property (nonatomic, weak) UICollectionView *collectionView;
/// 头部显示编辑结果的View
@property (nonatomic, weak) MPCreateBillHeaderView *resultView;
/// 收入类型模型数组
@property (nonatomic, strong) NSArray *incomeCategoryArray;
/// 支出类型模型数组
@property (nonatomic, strong) NSArray *outComeCategoryArray;

@end

@implementation MPCreateBillViewController

static NSString *CategoryCellID = @"CategoryCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self setupNavigationBar];
  [self setupUI];
  [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(MPCategoryCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:CategoryCellID];
}

/// 设置导航栏
- (void)setupNavigationBar
{
  UISegmentedControl *segCtr = [[UISegmentedControl alloc] initWithItems:@[@"收入", @"支出"]];
  [segCtr addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
  self.navigationItem.titleView = segCtr;
  segCtr.selectedSegmentIndex = 1;
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
  self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
}

- (void)setupUI
{
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
  [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.height.mas_equalTo(60);
    make.leading.trailing.equalTo(self.view);
    make.top.equalTo(self.view).offset(64);
  }];
}

#pragma mark - Action
/// 切换收入 / 支出
- (void)segChange:(UISegmentedControl *)segCrt
{
  NSLog(@"%zd", segCrt.selectedSegmentIndex);
}

/// 退出
- (void)cancel
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.outComeCategoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MPCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryCellID forIndexPath:indexPath];
  cell.categoryModel = self.outComeCategoryArray[indexPath.row];
  return cell;
}


#pragma mark - getter
- (UICollectionView *)collectionView
{
  if(_collectionView == nil)
  {
    // 创建布局layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = kScreenW / kColumnCount;
    CGFloat itemH = itemW;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    view.delegate = self;
    view.dataSource = self;
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    // 设置偏移量
    view.contentInset = UIEdgeInsetsMake(134, 0, 0, 0);
    view.bounces = YES;
    view.alwaysBounceVertical = YES;
    _collectionView = view;
    [self.view addSubview:view];
  }
  return _collectionView;
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

- (NSArray *)incomeCategoryArray
{
  if(_incomeCategoryArray == nil)
  {
    _incomeCategoryArray = [MPCategoryModel getIncomeCategoryArray];
  }
  return _incomeCategoryArray;
}

- (NSArray *)outComeCategoryArray
{
  if(_outComeCategoryArray == nil)
  {
    _outComeCategoryArray = [MPCategoryModel getOutcomeCategoryArray];
  }
  return _outComeCategoryArray;
}

@end
