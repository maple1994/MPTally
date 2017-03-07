//
//  MPOutcomeCategoryViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPOutcomeCategoryViewController.h"
#import "MPCategoryModel.h"

@interface MPOutcomeCategoryViewController ()

@end

@implementation MPOutcomeCategoryViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.categotyModelArray = [MPCategoryModel getOutcomeCategoryArray];
  [self.collectionView reloadData];
}


@end
