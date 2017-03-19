//
//  MPBillTableViewCell.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPTimeLineItemTableViewCell;
@class MPTimeLineYearMonthMarkView;
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
/// yyyy-MM-dd格式的字符串，时间线的时间string
@property (nonatomic, copy)  NSString *timeLineTime;
/// 时间线
@property (nonatomic, weak) MPTimeLineYearMonthMarkView *lineView;

/// 隐藏编辑视图
- (void)hideEditView;

@end
