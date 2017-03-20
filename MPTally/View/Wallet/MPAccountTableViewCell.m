//
//  MPWalletTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountTableViewCell.h"
@interface MPAccountTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bgVIew;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation MPAccountTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  self.bgVIew.layer.cornerRadius = 3;
  self.bgVIew.layer.masksToBounds = YES;
}

- (void)setHexColorString:(NSString *)hexColorString
{
  _hexColorString = hexColorString;
  self.bgVIew.backgroundColor = [UIColor colorWithHexString:hexColorString];
}

- (void)setAccount:(MPAccountModel *)account
{
  _account = account;
  self.titleLabel.text = account.accountName;
  self.numLabel.text = [MyUtils numToString:account.money];
  self.bgVIew.backgroundColor = [UIColor colorWithHexString:account.colorStr];
}
@end
