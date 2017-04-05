//
//  MPTableViewCell.m
//  MPTally
//
//  Created by Maple on 2017/3/31.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTrendTableViewCell.h"
#import "MPTrendModel.h"

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

- (void)setTrendModel:(MPTrendModel *)trendModel
{
    _trendModel = trendModel;
    self.incomeLabel.text = [MyUtils numToString:trendModel.income];
    self.outcomeLabel.text = [MyUtils numToString:trendModel.outcome];
    self.balanceLabel.text = [MyUtils numToString:trendModel.balance];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM";
    NSDate *date = [df dateFromString:trendModel.month];
    df.dateFormat = @"M月";
    self.monthLabel.text = [df stringFromDate:date];
}

@end
