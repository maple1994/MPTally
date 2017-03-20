//
//  MPWalletBalanceHeaderView.m
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountBalanceHeaderView.h"

@interface MPAccountBalanceHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation MPAccountBalanceHeaderView

- (void)awakeFromNib {
  [super awakeFromNib];
  self.bgView.layer.cornerRadius = 3;
  self.bgView.layer.masksToBounds = YES;
  self.bgView.layer.borderWidth = 1;
  self.bgView.layer.borderColor = colorWithRGB(220, 220, 220).CGColor;
}


@end
