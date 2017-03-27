//
//  MPReportFormViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPReportFormViewController.h"
#import "MPFormDatePicker.h"
#import "MPPieView.h"
#import "MPBillManager.h"
#import "MPPieModel.h"
#import "MPBillsInCateTableViewCell.h"

@interface MPReportFormViewController ()<MPFormDatePickerDelegate, UITableViewDelegate, UITableViewDataSource>

/// 日期选择器
@property (nonatomic, weak) MPFormDatePicker *datePicker;
/// 饼状图
@property (nonatomic, strong) MPPieView *pieView;
/// tableView
@property (nonatomic, weak) UITableView *tableView;
/// 模型数组
@property (nonatomic, strong) NSArray *modelArray;

@end

@implementation MPReportFormViewController

static NSString *ChartBillCellID = @"ChartBillCellID";

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupUI];

  [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(MPBillsInCateTableViewCell.class) bundle:nil] forCellReuseIdentifier:ChartBillCellID];
  self.tableView.rowHeight = 50;
}

- (void)setupUI
{
  self.view.backgroundColor = [UIColor whiteColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view).offset(64);
    make.leading.trailing.equalTo(self.view);
    make.height.mas_equalTo(40);
  }];
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.datePicker.mas_bottom);
    make.leading.trailing.bottom.equalTo(self.view);
  }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  MPBillsInCateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChartBillCellID];
  cell.pieModel = self.modelArray[indexPath.row];
  return cell;
}

#pragma mark - MPFormDatePickerDelegate
- (void)formDatePickerDidSelectDate:(NSDate *)date
{
  
}

#pragma mark - datePicker
- (UITableView *)tableView
{
  if(_tableView == nil)
  {
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    view.delegate = self;
    view.dataSource = self;
    _tableView = view;
    [self.view addSubview:view];
  }
  return _tableView;
}

- (MPPieView *)pieView
{
  if(_pieView == nil)
  {
    _pieView = [[MPPieView alloc] init];
  }
  return _pieView;
}

- (MPFormDatePicker *)datePicker
{
  if(_datePicker == nil)
  {
    MPFormDatePicker *picker = [[MPFormDatePicker alloc] init];
    picker.delegate = self;
    _datePicker = picker;
    [self.view addSubview:picker];
  }
  return _datePicker;
}

- (NSArray *)modelArray
{
  if(_modelArray == nil)
  {
    RLMResults *results = [[MPBillManager shareManager] getOutcomeBillsInSameYearMonth:[NSDate date]];
    _modelArray = [MPPieModel modelArrayWithBills:results];
  }
  return _modelArray;
}

@end
