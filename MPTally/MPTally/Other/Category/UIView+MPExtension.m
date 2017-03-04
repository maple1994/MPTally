//
//  UIView+MPExtension.m
//  百思不得姐
//
//  Created by Maple on 16/5/14.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "UIView+MPExtension.h"

@implementation UIView (MPExtension)

- (void)setMp_size:(CGSize)mp_size
{
  CGRect frame = self.frame;
  frame.size = mp_size;
  self.frame = frame;
}

- (CGSize)mp_size
{
    return self.frame.size;
}

- (void)setMp_width:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setMp_height:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setMp_x:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setMp_y:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setMp_centerX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setMp_centerY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)mp_centerY
{
    return self.center.y;
}

- (CGFloat)mp_centerX
{
    return self.center.x;
}

- (CGFloat)mp_width
{
    return self.frame.size.width;
}

- (CGFloat)mp_height
{
    return self.frame.size.height;
}

- (CGFloat)mp_x
{
    return self.frame.origin.x;
}

- (CGFloat)mp_y
{
    return self.frame.origin.y;
}

+ (instancetype)viewFromNib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

@end
