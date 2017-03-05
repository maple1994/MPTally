//
//  MPCreateBillViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateBillViewController.h"
#import "MPCategoryCollectionViewCell.h"
#define kColumnCount 5

@interface MPCreateBillViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

/// 存放账单类型的collectionView
@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation MPCreateBillViewController

static NSString *CategoryCellID = @"CategoryCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
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
  return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MPCategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryCellID forIndexPath:indexPath];
  cell.backgroundColor = kRandomColor;
  return cell;
}

#pragma mark - getter
- (UICollectionView *)collectionView
{
  if(_collectionView == nil)
  {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemW = kScreenW / kColumnCount;
    CGFloat itemH = itemW;
    flowLayout.itemSize = CGSizeMake(itemW, itemH);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    view.delegate = self;
    view.dataSource = self;
    view.backgroundColor = [UIColor whiteColor];
    _collectionView = view;
    [self.view addSubview:view];
  }
  return _collectionView;
}

@end
