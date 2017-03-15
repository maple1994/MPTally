//
//  MPTopBarView.h
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPTopBarView;
@protocol TopBarViewDelegate <NSObject>

@optional
/// 点击了标题按钮
- (void)topBarView:(MPTopBarView *)topBar didClickTitleButton:(UIButton *)button;

@end

/// 代替导航栏的View
@interface MPTopBarView : UIView

@property (nonatomic, weak) id<TopBarViewDelegate> delegate;

@end
