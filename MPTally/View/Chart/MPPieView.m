//
//  MPPieView.m
//  MPTally
//
//  Created by Maple on 2017/3/27.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPPieView.h"
#import "MPBillManager.h"
#import "MPTally-Bridging-Header.h"
#import "MPPieModel.h"
#import "CCColorCube.h"

@interface MPPieView ()

@property (nonatomic, strong) PieChartView *pieChartView;

@end

@implementation MPPieView

- (instancetype)init
{
  if(self = [super init])
  {
    self.backgroundColor = [UIColor whiteColor];
    self.pieChartView = [[PieChartView alloc] init];
    [self addSubview:self.pieChartView];
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.height.width.mas_equalTo(300);
      make.centerX.equalTo(self);
      make.top.equalTo(self).offset(-5);
    }];
    [self setupChartView:self.pieChartView];
  }
  return self;
}

- (void)setupChartView:(PieChartView *)pieChartView
{
  [pieChartView setExtraOffsetsWithLeft:0 top:0 right:0 bottom:0];//饼状图距离边缘的间隙
  pieChartView.usePercentValuesEnabled = YES;//是否根据所提供的数据, 将显示数据转换为百分比格式
  pieChartView.dragDecelerationEnabled = YES;//拖拽饼状图后是否有惯性效果
  pieChartView.drawSliceTextEnabled = YES;//是否显示区块文本
  
  pieChartView.drawHoleEnabled = YES;//饼状图是否是空心
  pieChartView.holeRadiusPercent = 0.5;//空心半径占比
  pieChartView.holeColor = [UIColor clearColor];//空心颜色
  pieChartView.transparentCircleRadiusPercent = 0.52;//半透明空心半径占比
  pieChartView.transparentCircleColor = [UIColor colorWithRed:210/255.0 green:145/255.0 blue:165/255.0 alpha:0.3];//半透明空心的颜色
  
  if(pieChartView.isDrawHoleEnabled == YES) {
    pieChartView.drawCenterTextEnabled = YES;//是否显示中间文字
  }
  pieChartView.chartDescription.enabled = NO;  // 隐藏图例描述label
  pieChartView.legend.form = ChartLegendFormNone; // 隐藏图例Item
  pieChartView.highlightPerTapEnabled = NO;  // 不可点击
}

- (void)setData:(NSArray *)data
{
  NSUInteger count = data.count;//饼状图总共有几块组成
  
  //每个区块的数据
  NSMutableArray *yVals = [[NSMutableArray alloc] init];
  NSMutableArray *colors = [[NSMutableArray alloc] init];
  for (int i = 0; i < count; i++) {
    MPPieModel *pieModel = data[i];
    PieChartDataEntry *entry = [[PieChartDataEntry alloc] initWithValue:pieModel.sum label:@""];
    [yVals addObject:entry];
    // 添加类别图标的颜色
    [colors addObject:[self extractColorFromImage:[UIImage imageNamed:pieModel.category.categoryImageFileName]]];
  }
  
  PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@""];
  dataSet.drawValuesEnabled = NO;//是否绘制显示数据
  
  dataSet.colors = colors;//区块颜色
  dataSet.sliceSpace = 1;//相邻区块之间的间距
  
  //data
  PieChartData *pieData = [[PieChartData alloc] initWithDataSet:dataSet];
  NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
  pFormatter.numberStyle = NSNumberFormatterPercentStyle;
  pFormatter.maximumFractionDigits = 1;
  pFormatter.multiplier = @1.f;
  pFormatter.percentSymbol = @" %";
  [pieData setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
  [pieData setValueTextColor:[UIColor brownColor]];
  [pieData setValueFont:[UIFont systemFontOfSize:10]];
  
  self.pieChartView.data = pieData;
  
  double total = 0;
  for (MPPieModel *pie in data)
  {
    total += pie.sum;
  }
  //富文本
  NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
  paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
  paragraphStyle.alignment = NSTextAlignmentCenter;
  
  NSString *title = @"总支出";
  if(self.isShowIncomeChart)
    title = @"总收入";
  NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%.2lf", title, total]];

  [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:11],
                              NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: paragraphStyle}
                      range:NSMakeRange(0, 3)];
  [centerText setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor colorWithHexString:@"2FB2E8"], NSParagraphStyleAttributeName: paragraphStyle} range:NSMakeRange(4, centerText.length - 3 - 1)];
  self.pieChartView.centerAttributedText = centerText;
}

/// 从图片提取颜色
- (UIColor *)extractColorFromImage:(UIImage *)image
{
  CCColorCube *cube = [[CCColorCube alloc] init];
  NSArray *colors = [cube extractColorsFromImage:image flags:CCAvoidBlack count:1];
  return colors.firstObject;
}


@end
