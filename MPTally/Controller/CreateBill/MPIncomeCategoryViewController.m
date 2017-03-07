//
//  MPIncomeCategoryViewController.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPIncomeCategoryViewController.h"
#import "MPCategoryModel.h"

@interface MPIncomeCategoryViewController ()

@end

@implementation MPIncomeCategoryViewController

static NSString *CategoryCellID = @"CategoryCellID";

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.categotyModelArray = [MPCategoryModel getIncomeCategoryArray];
}


@end
