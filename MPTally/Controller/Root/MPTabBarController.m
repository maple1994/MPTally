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
#import "MPAccountTableViewController.h"
#import "MPNavigationController.h"

@interface MPTabBarController ()

@end

@implementation MPTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
  MPTabBar *myTabBar = [[MPTabBar alloc] init];
    myTabBar.tintColor = kNavTintColor;
  [self setValue:myTabBar forKey:@"tabBar"];
  [self addChildController];
}

/// 添加子控制器
- (void)addChildController
{
  MPBillTableViewController *billVC = [[MPBillTableViewController alloc] init];
  MPAccountTableViewController *walletVC = [[MPAccountTableViewController alloc] init];
  MPReportFormViewController *formVC = [[MPReportFormViewController alloc] init];
  MPSettingTableViewController *settingVC = [[MPSettingTableViewController alloc] init];
  [self setupChildController:billVC title:@"明细" imageName:@"mingxi"];
  [self setupChildController:walletVC title:@"钱包" imageName:@"qianbao"];
  [self setupChildController:formVC title:@"报表" imageName:@"baobiao"];
  [self setupChildController:settingVC title:@"设置" imageName:@"wode"];
}


- (void)setupChildController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName
{
    NSString *openImageName = [NSString stringWithFormat:@"%@_open", imageName];
    NSString *closeImageName = [NSString stringWithFormat:@"%@_close", imageName];
  controller.tabBarItem.image = [[UIImage imageNamed:closeImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  controller.tabBarItem.selectedImage = [[UIImage imageNamed:openImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  controller.title = title;
  MPNavigationController *nav = [[MPNavigationController alloc] initWithRootViewController:controller];
  [self addChildViewController:nav];
}


@end
