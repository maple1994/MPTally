//
//  MPWalletBalanceHeaderView.m
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountBalanceHeaderView.h"
#import "MPAccountManager.h"

@interface MPAccountBalanceHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (nonatomic, strong) RLMNotificationToken *token;
@property (nonatomic, strong) RLMResults *results;
    
@end

@implementation MPAccountBalanceHeaderView

- (void)awakeFromNib {
  [super awakeFromNib];
  self.bgView.layer.cornerRadius = 3;
  self.bgView.layer.masksToBounds = YES;
  self.bgView.layer.borderWidth = 1;
  self.bgView.layer.borderColor = colorWithRGB(220, 220, 220).CGColor;
    RLMResults *results = [[MPAccountManager shareManager] getAccountList];
    self.results = results;
    [self calculateBalance];
    self.token = [results addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        [self calculateBalance];
    }];
    
}
    
/// 计算余额
- (void)calculateBalance
{
    double total = 0;
    for (MPAccountModel *account in self.results) {
        total += account.money;
    }
    _balanceLabel.text = [MyUtils numToString:total];
}
    
- (void)dealloc
{
    self.token = nil;
}


@end
