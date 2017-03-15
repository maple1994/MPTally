//
//  MPBookListView.h
//  MPTally
//
//  Created by Maple on 2017/3/14.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPBookListView;
@protocol MPBookListViewDelegate <NSObject>

@optional
/// 切换了账本
- (void)bookListView:(MPBookListView *)listView didChangeBook:(MPBookModel *)book;

@end

/// 账本列表View
@interface MPBookListView : UIView

@property (nonatomic, weak) id<MPBookListViewDelegate> delegate;

- (instancetype)initWithItemSize:(CGSize)size;

@end
