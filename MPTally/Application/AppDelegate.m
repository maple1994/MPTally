//
//  AppDelegate.m
//  MPTally
//
//  Created by Maple on 2017/3/4.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "AppDelegate.h"
#import "MPTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  MPTabBarController *tabVC = [[MPTabBarController alloc] init];
  self.window.rootViewController = tabVC;
  [self.window makeKeyAndVisible];
  [self dbVersionCheck];
  return YES;
}

/// 数据库版本检测
- (void)dbVersionCheck
{
  RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
  // 设置新的架构版本。这个版本号必须高于之前所用的版本号（如果您之前从未设置过架构版本，那么这个版本号设置为 0）
  config.schemaVersion = 1;
  
  // 设置闭包，这个闭包将会在打开低于上面所设置版本号的 Realm 数据库的时候被自动调用
  config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
    // 目前我们还未进行数据迁移，因此 oldSchemaVersion == 0
    if (oldSchemaVersion < 1) {
      // 什么都不要做！Realm 会自行检测新增和需要移除的属性，然后自动更新硬盘上的数据库架构
    }
  };
  
  // 告诉 Realm 为默认的 Realm 数据库使用这个新的配置对象
  [RLMRealmConfiguration setDefaultConfiguration:config];
  
  // 现在我们已经告诉了 Realm 如何处理架构的变化，打开文件之后将会自动执行迁移
  [RLMRealm defaultRealm];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
