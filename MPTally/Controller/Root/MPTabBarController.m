//
//  MPTabBarViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTabBarController.h"
#import "MPTabBar.h"
#import "MPBillTableViewController.h"
#import "MPReportFormViewController.h"
#import "MPSettingTableViewController.h"
#import "MPWalletTableViewController.h"
#import "MPNavigationController.h"

@interface MPTabBarController ()

@end

@implementation MPTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
  MPTabBar *myTabBar = [[MPTabBar alloc] init];
  [self setValue:myTabBar forKey:@"tabBar"];
  [self addChildController];
}

/// 添加子控制器
- (void)addChildController
{
  MPBillTableViewController *billVC = [[MPBillTableViewController alloc] init];
  MPWalletTableViewController *walletVC = [[MPWalletTableViewController alloc] init];
  MPReportFormViewController *formVC = [[MPReportFormViewController alloc] init];
  MPSettingTableViewController *settingVC = [[MPSettingTableViewController alloc] init];
  [self setupChildController:billVC title:@"明细" imageName:@""];
  [self setupChildController:walletVC title:@"钱包" imageName:@""];
  [self setupChildController:formVC title:@"报表" imageName:@""];
  [self setupChildController:settingVC title:@"设置" imageName:@""];
}


- (void)setupChildController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName
{
//  controller.view.backgroundColor = kRandomColor;
  NSString *selectedImageName = [imageName stringByAppendingString:@"_selected"];
  controller.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  controller.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  controller.title = title;
  MPNavigationController *nav = [[MPNavigationController alloc] initWithRootViewController:controller];
  [self addChildViewController:nav];
}


@end
