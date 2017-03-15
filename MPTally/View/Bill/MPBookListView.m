//
//  MPBookListView.m
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBookListView.h"
#import "MPBookListCollectionViewCell.h"

@interface MPBookListView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIView *bottomLine;

@end

@implementation MPBookListView

static NSString *BookListCellID = @"BookListCellID";

- (instancetype)initWithItemSize:(CGSize)size
{
  if(self = [super init])
  {
    [self setupWithSize:size];
  }
  return self;
}

- (void)setupWithSize:(CGSize)size
{
  self.collectionView = [self createCollectionView:size];
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self).offset(20);
    make.leading.equalTo(self).offset(10);
    make.trailing.bottom.equalTo(self).offset(-10);
  }];
  [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.bottom.equalTo(self);
    make.height.mas_equalTo(1);
  }];
  [self.collectionView registerClass:[MPBookListCollectionViewCell class] forCellWithReuseIdentifier:BookListCellID];
}

/// 根据ItemSize创建collectionView
- (UICollectionView *)createCollectionView:(CGSize)size
{
  UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
  flowLayout.itemSize = size;
  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
  UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
  view.showsHorizontalScrollIndicator = NO;
  view.backgroundColor = [UIColor whiteColor];
  view.delegate = self;
  view.dataSource = self;
  [self addSubview:view];
  return view;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MPBookListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BookListCellID forIndexPath:indexPath];
//  cell.backgroundColor = kRandomColor;
  return cell;
}

#pragma mark - UICollectionViewDelegate

#pragma mark - getter
- (UIView *)bottomLine
{
  if(_bottomLine == nil)
  {
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = colorWithRGB(240, 240, 240);
    _bottomLine = line;
    [self addSubview:line];
  }
  return _bottomLine;
}

- (UICollectionView *)collectionView
{
  if(_collectionView == nil)
  {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (kScreenW - 5 * 10) / 4.0;
    flowLayout.itemSize = CGSizeMake(width, width * 1.35);
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//    view.contentInset = UIEdgeInsetsMake(20, 10, 10, 10);
    view.showsHorizontalScrollIndicator = NO;
    view.backgroundColor = [UIColor whiteColor];
    view.delegate = self;
    view.dataSource = self;
    _collectionView = view;
    [self addSubview:view];
  }
  return _collectionView;
}

@end
