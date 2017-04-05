//
//  MPLineChartViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPLineChartViewController.h"
#import "MPLineView.h"
#import "MPTrendTitleView.h"
#import "MPTrendTableViewCell.h"
#import "MPFormDatePicker.h"
#import "MPTrendModel.h"

@interface MPLineChartViewController ()<UITableViewDelegate, UITableViewDataSource, MPFormDatePickerDelegate>

@property (nonatomic, weak) UITableView *tableView;
/// 日期选择器
@property (nonatomic, weak) MPFormDatePicker *datePicker;
/// 标题栏
@property (nonatomic, strong) MPTrendTitleView *titleView;
/// 模型数组
@property (nonatomic, strong) NSArray *modelArray;
/// 当前选中的日期
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation MPLineChartViewController

static NSString *TrendCellID = @"TrendCellID";

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
    
}

- (void)setupUI
{
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.datePicker.mas_bottom);
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(MPTrendTableViewCell.class) bundle:nil] forCellReuseIdentifier:TrendCellID];
}

/// 显示没有数据时的界面
- (void)showNotDataView
{
    UIView *view = [[UIView alloc] init];
//    UILabel *la
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPTrendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TrendCellID];
    cell.trendModel = self.modelArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.titleView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

#pragma mark - MPFormDatePickerDelegate
/// 选择的日期
- (void)formDatePickerDidSelectDate:(NSDate *)date
{
    [self resetData:date];
}

/// 重置数据
- (void)resetData:(NSDate *)date
{
    self.selectedDate = date;
    self.modelArray = nil;
    [self.tableView reloadData];
}

#pragma mark - getter
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        UITableView *view = [[UITableView alloc] init];
        _tableView = view;
        view.delegate = self;
        view.dataSource = self;
        [self.view addSubview:view];
    }
    return _tableView;
}

- (MPTrendTitleView *)titleView
{
    if(_titleView == nil)
    {
        _titleView = [MPTrendTitleView viewFromNib];
    }
    return _titleView;
}

- (MPFormDatePicker *)datePicker
{
    if(_datePicker == nil)
    {
        MPFormDatePicker *picker = [[MPFormDatePicker alloc] init];
        picker.pickerMode = MPDatePickerYear;
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
        _modelArray = [MPTrendModel modelArrayWithDate:self.selectedDate];
    }
    return _modelArray;
}

- (NSDate *)selectedDate
{
    if(_selectedDate == nil)
    {
        _selectedDate = [NSDate date];
    }
    return _selectedDate;
}

@end
