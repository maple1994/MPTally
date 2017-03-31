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

@interface MPLineChartViewController ()<UITableViewDelegate, UITableViewDataSource, MPFormDatePickerDelegate>

@property (nonatomic, weak) UITableView *tableView;
/// 日期选择器
@property (nonatomic, weak) MPFormDatePicker *datePicker;
/// 标题栏
@property (nonatomic, strong) MPTrendTitleView *titleView;

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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPTrendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TrendCellID];
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

@end
