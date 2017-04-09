//
//  SymbolsValueFormatter.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "SymbolsValueFormatter.h"

@implementation SymbolsValueFormatter

- (instancetype)init
{
  if (self = [super init]) {
    
  }
  return self;
}

//IChartAxisValueFormatter的代理方法
- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
  return [NSString stringWithFormat:@"%ld",(NSInteger)value];
}

@end
