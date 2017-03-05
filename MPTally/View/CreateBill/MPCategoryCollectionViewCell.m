//
//  MPCategoryCollectionViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCategoryCollectionViewCell.h"
#import "MPCategoryModel.h"

@interface MPCategoryCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end
@implementation MPCategoryCollectionViewCell


- (void)setCategoryModel:(MPCategoryModel *)categoryModel
{
  _categoryModel = categoryModel;
  _iconImageView.image = [UIImage imageNamed:categoryModel.categoryImageFileName];
  _categoryLabel.text = categoryModel.categoryName;
}

@end
