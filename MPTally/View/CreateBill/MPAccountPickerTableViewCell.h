//
//  MPAccountPickerTableViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/8.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPAccountModel;
/// 账户picker的Cell
@interface MPAccountPickerTableViewCell : UITableViewCell

/// 是否显示选中标志
@property (nonatomic, assign) BOOL showSelectedMark;
@property (nonatomic, strong) MPAccountModel *accountModel;

@end
