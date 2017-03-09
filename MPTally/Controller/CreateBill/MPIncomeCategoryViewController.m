//
//  MPIncomeCategoryViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPIncomeCategoryViewController.h"

@interface MPIncomeCategoryViewController ()

@end

@implementation MPIncomeCategoryViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.categotyModelArray = [MPCategoryModel getIncomeCategoryArray];
  [self.collectionView reloadData];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//  [super viewDidAppear:animated];
//  [self selectFirstItem];
//}


@end
