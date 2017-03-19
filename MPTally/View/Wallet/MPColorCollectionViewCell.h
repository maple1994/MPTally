//
//  MPColorCollectionViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 账户的颜色选择Cell
@interface MPColorCollectionViewCell : UICollectionViewCell

/// 是否显示选中标示
@property (nonatomic, assign) BOOL showSelectedMark;
/// 16进制颜色字符
@property (nonatomic, copy) NSString *hexColorString;

@end
