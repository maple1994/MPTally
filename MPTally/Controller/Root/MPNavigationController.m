//
//  MPNavigationController.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPNavigationController.h"

@interface MPNavigationController ()

@end

@implementation MPNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
    // 隐藏tabbar
    viewController.hidesBottomBarWhenPushed = YES;
  }
  // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
  [super pushViewController:viewController animated:animated];
  
}


@end
