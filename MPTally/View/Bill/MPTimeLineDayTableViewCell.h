//
//  MPTimeLineDayTableViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPDayBillModel;
/// 显示日期的时间线
@interface MPTimeLineDayTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, strong) MPDayBillModel *dayBill;

@end
