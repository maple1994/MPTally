//
//  MPWalletAddView.m
//  MPTally
//
//  Created by Maple on 2017/3/19.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPAccountAddView.h"

@interface MPAccountAddView ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

@implementation MPAccountAddView

- (void)awakeFromNib
{
  [super awakeFromNib];
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
  [self.contentView addGestureRecognizer:tap];
  self.contentView.layer.cornerRadius = 3;
  self.contentView.layer.masksToBounds = YES;
  self.contentView.layer.borderWidth = 1;
  self.contentView.layer.borderColor = colorWithRGB(220, 220, 220).CGColor;
}

- (void)tap
{
  if(self.clickBlock)
    self.clickBlock();
}

@end
