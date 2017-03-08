//
//  MPAccountPickerTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountPickerTableViewCell.h"
#import "MPAccountModel.h"

@interface MPAccountPickerTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
/// 选中标志
@property (weak, nonatomic) IBOutlet UIButton *selectedMarkButton;

@end

@implementation MPAccountPickerTableViewCell

- (void)setShowSelectedMark:(BOOL)showSelectedMark
{
  _showSelectedMark = showSelectedMark;
  self.selectedMarkButton.hidden = !showSelectedMark;
}

- (void)setAccountModel:(MPAccountModel *)accountModel
{
  _accountModel = accountModel;
  self.accountNameLabel.text = accountModel.accountName;
  self.moneyLabel.text = [NSString stringWithFormat:@"余额:%.2lf", accountModel.money];
}


@end
