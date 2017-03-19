//
//  UIColor+MPHex.h
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MPHex)

/**
 *  根据16进制的字符串返回颜色
 *
 *  @param stringToConvert 16进制的字符串
 *
 *  @return color
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
