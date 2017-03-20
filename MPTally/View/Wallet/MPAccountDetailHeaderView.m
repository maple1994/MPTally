//
//  MPAccountDetailView.m
//  MPTally
//
//  Created by Maple on 2017/3/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountDetailHeaderView.h"

@interface MPAccountDetailHeaderView ()


@property (weak, nonatomic) IBOutlet UIButton *balanceButton;
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *outcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;

@end

@implementation MPAccountDetailHeaderView

- (void)setAccount:(MPAccountModel *)account
{
  _account = account;
  [_balanceButton setTitle:[MyUtils numToString:account.money] forState:UIControlStateNormal];
  self.backgroundColor = [UIColor colorWithHexString:account.colorStr];
}

- (IBAction)monthClick:(UIButton *)sender {
}

@end
