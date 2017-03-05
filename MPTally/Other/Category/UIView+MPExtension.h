//
//  UIView+MPExtension.h
//  百思不得姐
//
//  Created by Maple on 16/5/14.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MPExtension)
@property (nonatomic, assign) CGSize mp_size;
@property (nonatomic, assign) CGFloat mp_width;
@property (nonatomic, assign) CGFloat mp_height;
@property (nonatomic, assign) CGFloat mp_x;
@property (nonatomic, assign) CGFloat mp_y;
@property (nonatomic, assign) CGFloat mp_centerX;
@property (nonatomic, assign) CGFloat mp_centerY;

+ (instancetype)viewFromNib;

@end
