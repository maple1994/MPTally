//
//  MPBookListView.m
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBookListView.h"
#import "MPBookListCollectionViewCell.h"
#import "MPCreateBookCollectionViewCell.h"
#import "MPBookManager.h"
#import "MPCreateBookView.h"

@interface MPBookListView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIView *bottomLine;
/// 记录选中的indexPath
@property (nonatomic, weak) NSIndexPath *selectedIndexPath;
/// 账本模型数组
@property (nonatomic, strong) NSMutableArray *bookArray;
/// 通知Token
@property (nonatomic, strong) RLMNotificationToken *token;
/// 数据库数据数组
@property (nonatomic, strong) RLMResults *dbResults;

@end

@implementation MPBookListView

static NSString *BookListCellID = @"BookListCellID";
static NSString *BookListNewCellID = @"BookListNewCellID";

- (instancetype)initWithItemSize:(CGSize)size
{
  if(self = [super init])
  {
    [self setupWithSize:size];
  }
  return self;
}

/// 设置选中标志
- (void)setupSelectedMark
{
  for(int i = 0; i < self.bookArray.count; i++)
  {
    MPBookModel *book = self.bookArray[i];
    // 判断是否是当前默认选中的账本
    if([[[MPBookManager shareManager] getCurrentBook].bookID isEqualToString:book.bookID])
    {
      book.selected = YES;
      self.selectedIndexPath = [NSIndexPath indexPathForItem:i inSection:0];
      [self.collectionView reloadData];
      break;
    }
  }
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
  [self.collectionView registerClass:[MPCreateBookCollectionViewCell class] forCellWithReuseIdentifier:BookListNewCellID];
  
  // 设置token事件
  __weak typeof(self) weakSelf = self;
  self.token = [self.dbResults addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
    weakSelf.bookArray = nil;
    [weakSelf setupSelectedMark];
    [weakSelf.collectionView reloadData];
  }];
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

/// 弹出编辑账本窗口
- (void)showEditBookView:(MPBookModel *)book
{
  MPCreateBookView *view = [[MPCreateBookView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
  view.book = book;
  [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
//  [[UIApplication sharedApplication].keyWindow addSubview:view];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.bookArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  if(indexPath.row == self.bookArray.count)
  {
    MPCreateBookCollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:BookListNewCellID forIndexPath:indexPath];
    return cell1;
  }
  MPBookListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BookListCellID forIndexPath:indexPath];
  MPBookModel *book = self.bookArray[indexPath.row];
  cell.bookModel = book;
  // 设置长按手势Block
  [cell setLongPressBlock:^{
    [self showEditBookView:book];
  }];
  return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  // 点击最后一个Cell，即添加账本
  if(indexPath.row == self.bookArray.count)
  {
    [self showEditBookView:nil];
    return;
  }
  // 切换账本，交给代理处理
  if([self.delegate respondsToSelector:@selector(bookListView:didChangeBook:)])
  {
    [self.delegate bookListView:self didChangeBook:self.bookArray[indexPath.row]];
  }
  self.selectedIndexPath = indexPath;
}

- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath
{
  // 去除之前的选中标志
  MPBookModel *book = self.bookArray[_selectedIndexPath.row];
  book.selected = NO;
  // 显示选中标志
  book = self.bookArray[selectedIndexPath.row];
  book.selected = YES;
  _selectedIndexPath = selectedIndexPath;
  [self.collectionView reloadData];
}

#pragma mark - getter
- (NSMutableArray *)bookArray
{
  if(_bookArray == nil)
  {
    _bookArray = [NSMutableArray array];
    for (MPBookModel *model in self.dbResults)
    {
      [_bookArray addObject:model];
    }
  }
  return _bookArray;
}

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
    view.showsHorizontalScrollIndicator = NO;
    view.backgroundColor = [UIColor whiteColor];
    view.delegate = self;
    view.dataSource = self;
    view.alwaysBounceHorizontal = YES;
    _collectionView = view;
    [self addSubview:view];
  }
  return _collectionView;
}

- (RLMResults *)dbResults
{
  return [MPBookModel allObjects];
}

@end
