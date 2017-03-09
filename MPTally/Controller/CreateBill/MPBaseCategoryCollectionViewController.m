//
//  MPBaseCategoryCollectionViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/7.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBaseCategoryCollectionViewController.h"
#import "MPCategoryCollectionViewCell.h"

#define kColumnCount 5
#define kItemWH kScreenW / kColumnCount

@interface MPBaseCategoryCollectionViewController ()

@property (nonatomic, assign) CGFloat lastPosition;

@end

@implementation MPBaseCategoryCollectionViewController

static NSString *CategoryCellID = @"CategoryCellID";

- (instancetype)init
{
  // 创建布局layout
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  CGFloat itemW = kItemWH;
  CGFloat itemH = itemW;
  flowLayout.itemSize = CGSizeMake(itemW, itemH);
  flowLayout.minimumLineSpacing = 10;
  flowLayout.minimumInteritemSpacing = 0;
  return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MPCategoryCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:CategoryCellID];
  self.automaticallyAdjustsScrollViewInsets = NO;
}

/// 选中第一项
- (void)selectFirstItem
{
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)setCategotyModelArray:(RLMResults *)categotyModelArray
{
  _categotyModelArray = categotyModelArray;
  self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
  // 计算一共有几行
  NSInteger row = (self.categotyModelArray.count + kColumnCount - 1) / kColumnCount;
  CGFloat contentH = row * kItemWH + (row - 1) * 10;
  // 设置偏移量
  self.collectionView.contentInset = UIEdgeInsetsMake(134, 0, kScreenH - contentH, 0);
  self.collectionView.bounces = YES;
  self.collectionView.alwaysBounceVertical = YES;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.categotyModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MPCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryCellID forIndexPath:indexPath];
  cell.categoryModel = self.categotyModelArray[indexPath.row];
  return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  MPCategoryCollectionViewCell *cell = (MPCategoryCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
  if([self.cateDelegate respondsToSelector:@selector(categoryCollectionView:didSelectCell:)])
  {
    [self.cateDelegate categoryCollectionView:collectionView didSelectCell:cell];
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  int currentPostion = scrollView.contentOffset.y;
  // 去除下拉bounce效果的影响
  if(scrollView.contentOffset.y <= -134)
  {
    _lastPosition = currentPostion;
    return;
  }
  // 判断offset > y是去除上拉bounce的效果
  if (currentPostion - _lastPosition > 25 || scrollView.contentOffset.y >= 0) {
    _lastPosition = currentPostion;
    // 上滚
    if([self.cateDelegate respondsToSelector:@selector(categoryCollectionViewDidScrollUp:)])
    {
      [self.cateDelegate categoryCollectionViewDidScrollUp:self.collectionView];
    }
  }
  else if (_lastPosition - currentPostion > 25)
  {
    // 下滚
    if([self.cateDelegate respondsToSelector:@selector(categoryCollectionViewDidScrollDown:)])
    {
      [self.cateDelegate categoryCollectionViewDidScrollDown:self.collectionView];
    }
    _lastPosition = currentPostion;
  }
}


@end
