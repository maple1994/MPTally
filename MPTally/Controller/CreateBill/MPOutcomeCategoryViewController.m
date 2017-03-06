//
//  MPOutcomeCategoryViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPOutcomeCategoryViewController.h"
#import "MPCategoryModel.h"
#import "MPCategoryCollectionViewCell.h"
#define kColumnCount 5

@interface MPOutcomeCategoryViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/// 存放账单类型的collectionView
@property (nonatomic, weak) UICollectionView *collectionView;
/// 支出类型模型数组
@property (nonatomic, strong) NSArray *outcomeCategoryArray;

@end

@implementation MPOutcomeCategoryViewController

static NSString *CategoryCellID = @"CategoryCellID";

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self setupUI];
  [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(MPCategoryCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:CategoryCellID];
}

- (void)setupUI
{
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.view);
  }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.outcomeCategoryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MPCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryCellID forIndexPath:indexPath];
  cell.categoryModel = self.outcomeCategoryArray[indexPath.row];
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
    // 计算一共有几行
    NSInteger row = (self.outcomeCategoryArray.count + kColumnCount - 1) / kColumnCount;
    CGFloat contentH = row * itemH + (row - 1) * 10;
    // 设置偏移量
    view.contentInset = UIEdgeInsetsMake(134, 0, kScreenH - contentH, 0);
    view.bounces = YES;
    view.alwaysBounceVertical = YES;
    _collectionView = view;
    [self.view addSubview:view];
  }
  return _collectionView;
}


- (NSArray *)outcomeCategoryArray
{
  if(_outcomeCategoryArray == nil)
  {
    _outcomeCategoryArray = [MPCategoryModel getOutcomeCategoryArray];
  }
  return _outcomeCategoryArray;
}
@end
