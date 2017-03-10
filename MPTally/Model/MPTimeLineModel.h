//
//  MPTimeLineModel.h
//  MPTally
//
//  Created by Maple on 2017/3/10.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TimeLineType)
{
  TimeLineNormalItem = 0, // 普通类型Cell
  TimeLineDayItem = 1     // 显示日期类型的Cell
};
/// 时间线模型
@interface MPTimeLineModel : NSObject

/// 模型的类型
@property (nonatomic, assign) TimeLineType type;
/// 账单模型

@end
