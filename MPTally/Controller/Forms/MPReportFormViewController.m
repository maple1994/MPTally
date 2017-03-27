//
//  MPReportFormViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPReportFormViewController.h"
#import "MPFormDatePicker.h"

@interface MPReportFormViewController ()<MPFormDatePickerDelegate>

@property (nonatomic, strong) MPFormDatePicker *datePicker;

@end

@implementation MPReportFormViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self setupUI];
}

- (void)setupUI
{
  self.view.backgroundColor = [UIColor whiteColor];
  [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view).offset(64);
    make.leading.trailing.equalTo(self.view);
    make.height.mas_equalTo(40);
  }];
}

#pragma mark - MPFormDatePickerDelegate
- (void)formDatePickerDidSelectDate:(NSDate *)date
{
  
}

#pragma mark - datePicker
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

@end
