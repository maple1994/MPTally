//
//  MPBillsInCateTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBillsInCateTableViewCell.h"
#import "MPPieModel.h"

@interface MPBillsInCateTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *cateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet UILabel *precentLabel;
@end

@implementation MPBillsInCateTableViewCell


- (void)setPieModel:(MPPieModel *)pieModel
{
  _pieModel = pieModel;
  self.categoryImageView.image = [UIImage imageNamed:pieModel.category.categoryImageFileName];
  self.cateTitleLabel.text = pieModel.category.categoryName;
  self.sumLabel.text = [MyUtils numToString:pieModel.sum];
  self.precentLabel.text = [NSString stringWithFormat:@"%.1lf%%", pieModel.precent * 100];
}

@end
