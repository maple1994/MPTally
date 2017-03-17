//
//  MPTableView.m
//  MPTally
//
//  Created by Maple on 2017/3/17.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPTableView.h"
#import "MPTimeLineItemTableViewCell.h"

@implementation MPTableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  kFuncNameLog;
  [super touchesBegan:touches withEvent:event];
  for (UITableViewCell *cell in self.visibleCells)
  {
    if([cell isKindOfClass:[MPTimeLineItemTableViewCell class]])
    {
      MPTimeLineItemTableViewCell *cell1 = (MPTimeLineItemTableViewCell *)cell;
      [cell1 hideEditView];
    }
  }
}


@end
