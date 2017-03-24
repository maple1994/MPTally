//
//  MPCreateBillHeaderView.m
//  MPTally
//
//  Created by Maple on 2017/3/5.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCreateBillHeaderView.h"
#import "CCColorCube.h"

@interface MPCreateBillHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *NumLabel;
@property (nonatomic, weak) CAShapeLayer *bgColorlayer;
/// 之前的选中的颜色
@property (nonatomic, strong) UIColor *previousColor;

@end

@implementation MPCreateBillHeaderView

- (void)setCategoryModel:(MPCategoryModel *)categoryModel
{
  _categoryModel = categoryModel;
  self.iconImageView.image = [UIImage imageNamed:categoryModel.categoryImageFileName];
  self.categoryNameLabel.text = categoryModel.categoryName;
  UIColor *color = [self extractColorFromImage:[UIImage imageNamed:categoryModel.categoryImageFileName]];
  // 第一次不做动画
  if(_previousColor)
    [self animationWithBgColor:color];
  else
  {
    self.backgroundColor = color;
    _previousColor = color;
  }
}

- (void)setResults:(NSString *)results
{
  _results = results;
  self.NumLabel.text = results;
}

/// 从图片提取颜色
- (UIColor *)extractColorFromImage:(UIImage *)image
{
  CCColorCube *cube = [[CCColorCube alloc] init];
  NSArray *colors = [cube extractColorsFromImage:image flags:CCAvoidBlack count:1];
  return colors.firstObject;
}

- (void)drawRect:(CGRect)rect {
  
}

- (void)animationWithBgColor:(UIColor *)color {
  
  //* 如果选择的类别图片的颜色和上次选择的一样  直接return */
  if ([color isEqual: self.previousColor]) return;
  //* 修改背景颜色为上一次选择的颜色,不然就会是最开始默认的颜色,动画会很丑,给用户的体验很不好 */
  self.backgroundColor = self.previousColor;
  
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
  animation.fromValue = @0.0;
  animation.toValue = @(self.bounds.size.width * 2);
  animation.duration = 0.3f;
  //* 设置填充色 */
  self.bgColorlayer.fillColor = color.CGColor;
  //* 设置边框色 */
  self.bgColorlayer.strokeColor = color.CGColor;
  
  self.previousColor = color;
  //* 保持动画 */
  animation.removedOnCompletion = NO;
  animation.fillMode = kCAFillModeForwards;
  
  [self.bgColorlayer addAnimation:animation forKey:@"bgColorAnimation"];
}

- (CAShapeLayer *)bgColorlayer
{
  if(_bgColorlayer == nil)
  {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.bounds.origin];
    [path addLineToPoint:CGPointMake(self.bounds.origin.x, self.bounds.size.height)];
    CAShapeLayer *layer = [CAShapeLayer layer];
    //* 设置路径 */
    layer.path = path.CGPath;
    //* 设置填充色 */
    layer.fillColor = [UIColor clearColor].CGColor;
    //* 设置边框色 */
    layer.strokeColor = [UIColor clearColor].CGColor;
    [self.layer insertSublayer:layer atIndex:0];
    self.bgColorlayer = layer;
  }
  return _bgColorlayer;
}

@end
