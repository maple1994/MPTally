//
//  MPBookModel.m
//  MPTally
//
//  Created by Maple on 2017/3/9.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPBookModel.h"

@implementation MPBookModel

+ (NSString *)primaryKey
{
  return @"bookID";
}

+ (NSArray<NSString *> *)ignoredProperties
{
  return @[@"selected"];
}

- (NSString *)description
{
  NSString *desc = [NSString stringWithFormat:@"name:%@, selected:%zd", _bookName, _selected];
  return desc;
}

@end
