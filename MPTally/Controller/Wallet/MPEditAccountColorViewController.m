//
//  MPEditAccountColorViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPEditAccountColorViewController.h"
#import "MPWalletTableViewCell.h"
#import "MPColorCollectionViewCell.h"

#define kNumOfRow 8 // 指定一行有8个Item

@interface MPEditAccountColorViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/// 选择颜色后的账本View
@property (nonatomic, weak) MPWalletTableViewCell *walletCell;
/// 放置颜色的collectionView
@property (nonatomic, weak) UICollectionView *collectionView;
/// 选中的index
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
/// 颜色数组
@property (nonatomic, strong) NSArray *colorArr;

@end

@implementation MPEditAccountColorViewController

static NSString *ColorID = @"ColorID";

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  [self.walletCell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view).offset(74);
    make.leading.trailing.equalTo(self.view);
    make.height.mas_equalTo(60);
  }];
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.walletCell.contentView.mas_bottom).offset(10);
    make.leading.equalTo(self.view).offset(10);
    make.trailing.equalTo(self.view).offset(-10);
    make.bottom.equalTo(self.view);
  }];
  [self.collectionView registerClass:[MPColorCollectionViewCell class] forCellWithReuseIdentifier:ColorID];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.colorArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MPColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ColorID forIndexPath:indexPath];
  cell.hexColorString = self.colorArr[indexPath.row];
  return cell;
}
#pragma mark - UICollectionDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  self.selectedIndexPath = indexPath;
}

#pragma mark - getter And setter
- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath
{
  MPColorCollectionViewCell *cell = (MPColorCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:_selectedIndexPath];
  cell.showSelectedMark = NO;
  cell = (MPColorCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectedIndexPath];
  cell.showSelectedMark = YES;
  _selectedIndexPath = selectedIndexPath;
}

- (MPWalletTableViewCell *)walletCell
{
  if(_walletCell == nil)
  {
    MPAccountModel *account = [[MPAccountModel alloc] init];
    account.accountName = @"账户名称";
    account.money = 0.00;
    account.colorStr = @"F3BD5D";
    MPWalletTableViewCell *cell = [MPWalletTableViewCell viewFromNib];
    cell.account = account;
    _walletCell = cell;
    [self.view addSubview:_walletCell.contentView];
  }
  return _walletCell;
}

- (UICollectionView *)collectionView
{
  if(_collectionView == nil)
  {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    CGFloat itemWH = (kScreenW - 20 - (kNumOfRow - 1) * 10) / kNumOfRow;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    view.delegate = self;
    view.dataSource = self;
    _collectionView = view;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
  }
  return _collectionView;
}

- (NSArray *)colorArr
{
  if(_colorArr == nil)
  {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"color.plist" ofType:nil];
    _colorArr = [NSArray arrayWithContentsOfFile:path];
  }
  return _colorArr;
}


@end
