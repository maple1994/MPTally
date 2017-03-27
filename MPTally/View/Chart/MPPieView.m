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

@interface MPPieView ()

@property (nonatomic, strong) PieChartView *pieChartView;

@end

@implementation MPPieView

- (instancetype)init
{
  if(self = [super init])
  {
    self.backgroundColor = [UIColor redColor];
    self.pieChartView = [[PieChartView alloc] init];
    self.pieChartView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.pieChartView];
    [self.pieChartView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.size.mas_equalTo(CGSizeMake(300, 300));
      make.center.mas_equalTo(self);
    }];
    [self setupChartView:self.pieChartView];
    self.pieChartView.data = [self setData];
  }
  return self;
}

- (void)setupChartView:(PieChartView *)pieChartView
{
  [pieChartView setExtraOffsetsWithLeft:30 top:0 right:30 bottom:0];//饼状图距离边缘的间隙
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
    //普通文本
    //        self.pieChartView.centerText = @"饼状图";//中间文字
    //富文本
    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@"饼状图"];
    [centerText setAttributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:16],
                                NSForegroundColorAttributeName: [UIColor orangeColor]}
                        range:NSMakeRange(0, centerText.length)];
    pieChartView.centerAttributedText = centerText;
    
    pieChartView.descriptionText = @"饼状图示例";
    pieChartView.descriptionFont = [UIFont systemFontOfSize:10];
    pieChartView.descriptionTextColor = [UIColor grayColor];
    
    
    pieChartView.legend.maxSizePercent = 1;//图例在饼状图中的大小占比, 这会影响图例的宽高
    pieChartView.legend.formToTextSpace = 5;//文本间隔
    pieChartView.legend.font = [UIFont systemFontOfSize:10];//字体大小
    pieChartView.legend.textColor = [UIColor grayColor];//字体颜色
    pieChartView.legend.position = ChartLegendPositionBelowChartCenter;//图例在饼状图中的位置
    pieChartView.legend.form = ChartLegendFormCircle;//图示样式: 方形、线条、圆形
    pieChartView.legend.formSize = 12;//图示大小
    
  }
}

- (PieChartData *)setData{
  
  double mult = 100;
  int count = 5;//饼状图总共有几块组成
  
  //每个区块的数据
  NSMutableArray *yVals = [[NSMutableArray alloc] init];
  for (int i = 0; i < count; i++) {
    //    double randomVal = arc4random_uniform(mult + 1);
    double randomVal = 25;
    NSString *title = [NSString stringWithFormat:@"part%d", i+1];
    PieChartDataEntry *entry = [[PieChartDataEntry alloc] initWithValue:randomVal label:title];
    [yVals addObject:entry];
  }
  
  PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:yVals label:@""];
  dataSet.drawValuesEnabled = YES;//是否绘制显示数据
  NSMutableArray *colors = [[NSMutableArray alloc] init];
  //  [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
  //  [colors addObjectsFromArray:ChartColorTemplates.joyful];
  //  [colors addObjectsFromArray:ChartColorTemplates.colorful];
  //  [colors addObjectsFromArray:ChartColorTemplates.liberty];
  //  [colors addObjectsFromArray:ChartColorTemplates.pastel];
  //  [colors addObject:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
  [colors addObject:[UIColor redColor]];
  [colors addObject:[UIColor blueColor]];
  [colors addObject:[UIColor yellowColor]];
  [colors addObject:[UIColor greenColor]];
  [colors addObject:[UIColor brownColor]];
  
  dataSet.colors = colors;//区块颜色
  dataSet.sliceSpace = 0;//相邻区块之间的间距
  dataSet.selectionShift = 8;//选中区块时, 放大的半径
  dataSet.xValuePosition = PieChartValuePositionInsideSlice;//名称位置
  dataSet.yValuePosition = PieChartValuePositionOutsideSlice;//数据位置
  //数据与区块之间的用于指示的折线样式
  dataSet.valueLinePart1OffsetPercentage = 0.85;//折线中第一段起始位置相对于区块的偏移量, 数值越大, 折线距离区块越远
  dataSet.valueLinePart1Length = 0.5;//折线中第一段长度占比
  dataSet.valueLinePart2Length = 0.4;//折线中第二段长度最大占比
  dataSet.valueLineWidth = 1;//折线的粗细
  dataSet.valueLineColor = [UIColor brownColor];//折线颜色
  
  //data
  //  PieChartData *data = [[PieChartData alloc] initWithXVals:xVals dataSet:dataSet];
  PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
  NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
  pFormatter.numberStyle = NSNumberFormatterPercentStyle;
  pFormatter.maximumFractionDigits = 1;
  pFormatter.multiplier = @1.f;
  pFormatter.percentSymbol = @" %";
  [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
  [data setValueTextColor:[UIColor brownColor]];
  [data setValueFont:[UIFont systemFontOfSize:10]];
  
  return data;
}

@end
