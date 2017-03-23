//
//  MPBillDetailHeaderView.m
//  MPTally
//
//  Created by Maple on 2017/3/23.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBillDetailHeaderView.h"

@interface MPBillDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *cateImageView;
@property (weak, nonatomic) IBOutlet UILabel *cateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation MPBillDetailHeaderView

- (void)setBill:(MPBillModel *)bill
{
  _bill = bill;
  self.cateImageView.image = [UIImage imageNamed:bill.category.categoryImageFileName];
  self.cateTitleLabel.text = bill.category.categoryName;
  self.moneyLabel.text = [MyUtils numToString:bill.money];
  self.moneyLabel.textColor = colorWithRGB(47, 178, 232);
}
@end
