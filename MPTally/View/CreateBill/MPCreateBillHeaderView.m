//
//  MPCreateBillHeaderView.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateBillHeaderView.h"
#import "MPCategoryModel.h"

@interface MPCreateBillHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumLabel;

@end

@implementation MPCreateBillHeaderView

- (void)setCategoryModel:(MPCategoryModel *)categoryModel
{
  _categoryModel = categoryModel;
  self.iconImageView.image = [UIImage imageNamed:categoryModel.categoryImageFileName];
  self.categoryNameLabel.text = categoryModel.categoryName;
}

- (void)setResults:(NSString *)results
{
  _results = results;
  self.NumLabel.text = results;
}

@end
