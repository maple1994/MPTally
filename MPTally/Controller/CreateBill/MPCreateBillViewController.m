//
//  MPCreateBillViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateBillViewController.h"

@interface MPCreateBillViewController ()

@end

@implementation MPCreateBillViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  [self setupNavigationBar];
  self.view.backgroundColor = [UIColor whiteColor];
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


@end
