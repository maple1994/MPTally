//
//  MPBaseCategoryCollectionViewController.h
//  MPTally
//
//  Created by Maple on 2017/3/7.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryCollectionViewControllerDelegate <NSObject>


@end

/// 账单类型列表基类
@interface MPBaseCategoryCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<CategoryCollectionViewControllerDelegate> cateDelegate;
/// category模型数组
@property (nonatomic, strong) NSArray *categotyModelArray;

@end
