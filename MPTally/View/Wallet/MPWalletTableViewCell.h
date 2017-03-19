//
//  MPWalletTableViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 钱包Cell
@interface MPWalletTableViewCell : UITableViewCell

@property (nonatomic, strong) MPAccountModel *account;
/// 16进制颜色字符
@property (nonatomic, copy) NSString *hexColorString;

@end
