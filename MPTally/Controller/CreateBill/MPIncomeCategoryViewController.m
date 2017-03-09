//
//  MPIncomeCategoryViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPIncomeCategoryViewController.h"
#import "MPCategoryManager.h"

@interface MPIncomeCategoryViewController ()

@end

@implementation MPIncomeCategoryViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.categotyModelArray = [[MPCategoryManager shareManager] getIncomeCategoryList];
  [self.collectionView reloadData];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//  [super viewDidAppear:animated];
//  [self selectFirstItem];
//}


@end
