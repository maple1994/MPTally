//
//  MPPieChartViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPPieChartViewController.h"
#import "MPFormDatePicker.h"
#import "MPPieView.h"
#import "MPBillManager.h"
#import "MPPieModel.h"
#import "MPBillsInCateTableViewCell.h"

@interface MPPieChartViewController ()<MPFormDatePickerDelegate, UITableViewDelegate, UITableViewDataSource>

/// 日期选择器
@property (nonatomic, weak) MPFormDatePicker *datePicker;
/// 饼状图
@property (nonatomic, strong) MPPieView *pieView;
/// tableView
@property (nonatomic, weak) UITableView *tableView;
/// 模型数组
@property (nonatomic, strong) NSArray *modelArray;
/// 选中的日期
@property (nonatomic, strong) NSDate *selectedDate;
/// 是否显示收入报表，默认为NO
@property (nonatomic, assign, getter=isShowIncomeChart) BOOL showIncomeChart;
/// 显示无内容的View
@property (nonatomic, weak) UIView *noContentView;

@end

@implementation MPPieChartViewController

static NSString *ChartBillCellID = @"ChartBillCellID";

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupUI];
  
  [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(MPBillsInCateTableViewCell.class) bundle:nil] forCellReuseIdentifier:ChartBillCellID];
  self.tableView.rowHeight = 50;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetDataByDate:) name:kBillsDataChangeNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

/// 根据选择的日期进行更新数据
- (void)resetDataByDate:(NSDate *)date
{
    if([date isKindOfClass:[NSDate class]])
      self.selectedDate = date;
  self.modelArray = nil;
  self.pieView.data = self.modelArray;
  [self.tableView reloadData];
    
    if(self.modelArray.count == 0)
    {
        [self showNotDataView];
    }
    else
    {
        [self removeNotDataView];
    }
}

/// 显示没有数据时的界面
- (void)showNotDataView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = colorWithRGB(220, 220, 220);
    UILabel *label = [[UILabel alloc] init];
    label.text = @"报表没有数据哦~";
    label.textColor = [UIColor grayColor];
    [view addSubview:label];
    [self.view addSubview:view];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.centerY.equalTo(view).offset(-50);
    }];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.datePicker.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    self.noContentView = view;
}

/// 移除无数据View
- (void)removeNotDataView
{
    [self.noContentView removeFromSuperview];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  return self.pieView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 250;
}

#pragma mark - MPFormDatePickerDelegate
- (void)formDatePickerDidSelectDate:(NSDate *)date
{
  [self resetDataByDate:date];
}

- (void)formDataPickerDidChangeStatus
{
  self.showIncomeChart = !self.isShowIncomeChart;
  // 切换报表类型
  self.modelArray = nil;
  self.pieView.showIncomeChart = self.isShowIncomeChart;
  self.pieView.data = self.modelArray;
  [self.tableView reloadData];
    
    if(self.modelArray.count == 0)
    {
        [self showNotDataView];
    }
    else
    {
        [self removeNotDataView];
    }
}


#pragma mark - datePicker
- (NSDate *)selectedDate
{
  if(_selectedDate == nil)
  {
    _selectedDate = [NSDate date];
  }
  return _selectedDate;
}

- (UITableView *)tableView
{
  if(_tableView == nil)
  {
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    view.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
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
    _pieView.showIncomeChart = self.isShowIncomeChart;
    _pieView.data = self.modelArray;
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
    RLMResults *results = nil;
    if(self.isShowIncomeChart)
      results = [[MPBillManager shareManager] getIncomeBillsInSameYearMonth:self.selectedDate];
    else
      results = [[MPBillManager shareManager] getOutcomeBillsInSameYearMonth:self.selectedDate];
    _modelArray = [MPPieModel modelArrayWithBills:results];
  }
  return _modelArray;
}

@end
