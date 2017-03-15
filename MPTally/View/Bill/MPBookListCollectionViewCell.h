//
//  MPBookListCollectionViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/15.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 账本列表Cell
@interface MPBookListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MPBookModel *bookModel;
/// 显示选中标记
@property (nonatomic, assign, getter=isShowSelectedMark) BOOL showSelectedMark;
/// 处理长按手势Block
@property (nonatomic, copy) void (^longPressBlock)();

@end
