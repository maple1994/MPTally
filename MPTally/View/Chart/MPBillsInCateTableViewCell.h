//
//  MPBillsInCateTableViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPPieModel;
/// 在指定类别下的账单汇总
@interface MPBillsInCateTableViewCell : UITableViewCell

@property (nonatomic, strong) MPPieModel *pieModel;

@end
