//
//  NSDate+MPPrint.h
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 输入扩展
@interface NSDate (MPPrint)

/**
 获得格式化后的字符串date

 @return yyyy-MM-dd 格式的字符串
 */
- (NSString *)dateFormattrString;

/**
 获取yyyy-MM格式的字符串date

 @return yyyy-MM字符创
 */
- (NSString *)getYearMonthDateString;

@end
