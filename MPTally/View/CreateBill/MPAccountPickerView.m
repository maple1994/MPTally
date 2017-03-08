//
//  MPAccountPickerView.m
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountPickerView.h"
#define kRowHeight 50 // 行高
#define kMaxRowCount 5 // 最多显示5个账户
#define kTableViewH kMaxRowCount * kRowHeight + kRowHeight // 5个Cell高+title的高度

@interface MPAccountPickerView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UIView *backgroundView;
/// accountModel模型数组
@property (nonatomic, strong) NSArray *accountModelArray;
/// 标题栏
@property (nonatomic, strong) UIView *titleView;

@end

@implementation MPAccountPickerView

static NSString *CellID = @"CellID";

- (instancetype)initWithAccountModelArray:(NSArray *)accountModelArray
{
  if(self = [super init])
  {
    self.accountModelArray = accountModelArray;
    [self setup];
  }
  return self;
}

- (void)setup
{
  [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self);
  }];
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.leading.trailing.equalTo(self);
    make.bottom.equalTo(self).offset(kTableViewH);
    // 显示5个账户 + 一个title的高度
    make.height.mas_equalTo(kTableViewH);
  }];
  
  // 注册Cell
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
}

/// 底部弹出动画
- (void)willMoveToSuperview:(UIView *)newSuperview
{
  [super willMoveToSuperview:newSuperview];
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self).offset(0);
    }];
    [UIView animateWithDuration:0.25 animations:^{
      [self layoutIfNeeded];
    }];
  });
}


- (void)dismiss
{
  [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(self).offset(kTableViewH);
  }];
  [UIView animateWithDuration:0.25 animations:^{
    [self layoutIfNeeded];
  } completion:^(BOOL finished) {
    [self removeFromSuperview];
  }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.accountModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
  cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  return self.titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return kRowHeight;
}

#pragma mark - getter
- (UITableView *)tableView
{
  if(_tableView == nil)
  {
    UITableView *view = [[UITableView alloc] init];
    view.delegate = self;
    view.dataSource = self;
    view.rowHeight = kRowHeight;
    _tableView = view;
    [self addSubview:view];
  }
  return _tableView;
}

- (UIView *)backgroundView
{
  if(_backgroundView == nil)
  {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.3;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [view addGestureRecognizer:tap];
    _backgroundView = view;
    [self addSubview:view];
  }
  return _backgroundView;
}

- (UIView *)titleView
{
  if(_titleView == nil)
  {
    _titleView = [[UIView alloc] init];
    
    // 设置label
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"选择账户";
    titleLabel.textColor = [UIColor blackColor];
    [_titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(_titleView);
    }];
    
    // 设置底部线条
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = self.tableView.separatorColor;
    [_titleView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.leading.trailing.bottom.equalTo(_titleView);
      make.height.mas_equalTo(1);
    }];
    
    _titleView.backgroundColor = [UIColor whiteColor];
  }
  return _titleView;
}

@end
