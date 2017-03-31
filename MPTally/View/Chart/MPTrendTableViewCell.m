//
//  MPTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/31.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTrendTableViewCell.h"

@interface MPTrendTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *monthLabel;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *outcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;

@end

@implementation MPTrendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
