//
//  MPAccountBillTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/21.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountBillTableViewCell.h"

@interface MPAccountBillTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cateImageView;
@property (weak, nonatomic) IBOutlet UILabel *cateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@end

@implementation MPAccountBillTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setBill:(MPBillModel *)bill
{
  _bill = bill;
  self.cateImageView.image = [UIImage imageNamed:bill.category.categoryImageFileName];
  self.cateTitleLabel.text = bill.category.categoryName;
  NSString *moneyStr = nil;
  if(bill.isIncome)
  {
    moneyStr = [NSString stringWithFormat:@"+%@", [MyUtils numToString:bill.money]];
    self.moneyLabel.textColor = colorWithRGB(47, 178, 232);
  }
  else
  {
    moneyStr = [NSString stringWithFormat:@"-%@", [MyUtils numToString:bill.money]];
    self.moneyLabel.textColor = [UIColor blackColor];
  }
  self.moneyLabel.text = moneyStr;
}

@end
