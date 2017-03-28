//
//  DateValueFormatter.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "DateValueFormatter.h"

@interface DateValueFormatter ()

@property (nonatomic, strong) NSArray *arr;

@end

@implementation DateValueFormatter

-(id)initWithArr:(NSArray *)arr
{
  self = [super init];
  if (self)
  {
    _arr = arr;
    
  }
  return self;
}

-(NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
  return _arr[(NSInteger)value];
}

@end
