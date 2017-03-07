//
//  MPBaseCategoryCollectionViewController.h
//  MPTally
//
//  Created by Maple on 2017/3/7.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPCategoryCollectionViewCell;

@protocol CategoryCollectionViewControllerDelegate <NSObject>

@optional
/// 点击了Cell
- (void)categoryCollectionView:(UICollectionView *)collectionView didSelectCell:(MPCategoryCollectionViewCell *)cell;
/// 向上滚动
- (void)categoryCollectionViewDidScrollUp:(UICollectionView *)collectionView;
/// 向下滚动
- (void)categoryCollectionViewDidScrollDown:(UICollectionView *)collectionView;

@end

/// 账单类型列表基类
@interface MPBaseCategoryCollectionViewController : UICollectionViewController

@property (nonatomic, weak) id<CategoryCollectionViewControllerDelegate> cateDelegate;
/// category模型数组
@property (nonatomic, strong) NSArray *categotyModelArray;


@end
