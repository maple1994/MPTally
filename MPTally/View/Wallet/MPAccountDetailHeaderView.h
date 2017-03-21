//
//  MPAccountDetailView.h
//  MPTally
//
//  Created by Maple on 2017/3/20.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPAccountDetailHeaderView;
@protocol MPAccountDetailHeaderViewDelegate <NSObject>

@optional
/// 切换了日期
- (void)accountDetailHeaderView:(MPAccountDetailHeaderView *)header didChangeDate:(NSDate *)date;

@end

@interface MPAccountDetailHeaderView : UIView

@property (nonatomic, strong) MPAccountModel *account;
@property (nonatomic, weak) id<MPAccountDetailHeaderViewDelegate> delegate;

@end
