//
//  MPCategoryCollectionViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MPCategoryModel;

/// 账单类型Cell / 用在创建账单页面
@interface MPCategoryCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) MPCategoryModel *categoryModel;

@end
