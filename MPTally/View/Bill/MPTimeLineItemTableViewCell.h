//
//  MPBillTableViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPTimeLineItemTableViewCell;
@protocol MPTimeLineItemTableViewCellDelegate <NSObject>

/// cell显示了编辑视图
- (void)timeLineItemCellDidShowEditView:(MPTimeLineItemTableViewCell *)cell;
/// 点击了编辑
- (void)timeLineItemCellDidClickEdit:(MPTimeLineItemTableViewCell *)cell;
/// 点击了删除
- (void)timeLineItemCellDidClickDelete:(MPTimeLineItemTableViewCell *)cell;

@end

/// 时间线Cell
@interface MPTimeLineItemTableViewCell : UITableViewCell

@property (nonatomic, strong) MPBillModel *bill;
@property (nonatomic, weak) id<MPTimeLineItemTableViewCellDelegate> delegate;

/// 隐藏编辑视图
- (void)hideEditView;

@end
