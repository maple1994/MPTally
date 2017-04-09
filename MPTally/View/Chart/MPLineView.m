//
//  MPLineView.m
//  MPTally
//
//  Created by Maple on 2017/3/31.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPLineView.h"
#import "MPTrendModel.h"

@interface MPLineView ()

/// 折线图
@property (nonatomic, strong) LineChartView *lineView;
/// 记录收入数据的数组
@property (nonatomic, strong) NSMutableArray *incomeArray;
/// 记录支出数据的数组
@property (nonatomic, strong) NSMutableArray *outcomeArray;
/// 记录结余数据的数组
@property (nonatomic, strong) NSMutableArray *balanceArray;

@end

@implementation MPLineView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _lineView = [[LineChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, self.mp_height - 20)];
    _lineView.backgroundColor =  [UIColor whiteColor];
    _lineView.noDataText = @"暂无数据";
    _lineView.chartDescription.enabled = YES;
    // 取消Y轴缩放
    _lineView.scaleYEnabled = NO;
    // 取消双击缩放
    _lineView.doubleTapToZoomEnabled = NO;
    _lineView.userInteractionEnabled = NO;

    // 描述及图例样式
    [_lineView setDescriptionText:@""];
    _lineView.legend.enabled = YES;
    _lineView.legend.form = ChartLegendFormLine;
    [_lineView animateWithXAxisDuration:1.0f];
    
    // 不绘制右边轴
    _lineView.rightAxis.enabled = NO;

    ChartXAxis *xAxis = _lineView.xAxis;
    // 设置重复的值不显示
    xAxis.granularityEnabled = YES;
    // 设置x轴的范围
    xAxis.axisMinimum = 0;
    xAxis.axisMaximum = 11;
    // 设置x轴数据在底部
    xAxis.labelPosition= XAxisLabelPositionBottom;
    xAxis.gridColor = [UIColor clearColor];
    // 文字颜色
    xAxis.labelTextColor = [UIColor blackColor];
    xAxis.axisLineColor = [UIColor grayColor];
    
    [self addSubview:_lineView];
}

/// 设置最大值
- (void)setupLeftAxisWithMax:(double)max
{
    ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
    leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
    leftAxis.forceLabelsEnabled = YES;
    leftAxis.axisMaximum = max;
    leftAxis.axisMinimum = -max;
    leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
    leftAxis.inverted = NO;//是否将Y轴进行上下翻转
    leftAxis.axisLineColor = [UIColor clearColor];//Y轴颜色
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
    leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
    leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
    leftAxis.gridColor = [UIColor grayColor];//网格线颜色
    leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
    leftAxis.valueFormatter = [[SymbolsValueFormatter alloc]init];//设置y轴的数据格
}

/// 根据TrendModel模型数组生成折线图数据
- (void)setDatas:(NSArray *)datas
{
    if(datas.count == 0)
        return;
    self.incomeArray = [NSMutableArray array];
    self.outcomeArray = [NSMutableArray array];
    self.balanceArray = [NSMutableArray array];
    _datas = datas;
    // 获得最大的y值后，设置y坐标的区间
    [self setupLeftAxisWithMax:[self getMaxValueInData:datas]];
    MPTrendModel *firstModel = datas.firstObject;
    NSString *year = [firstModel.month substringToIndex:4];
    // 判断是否是今年，来决定计算报表的月份
    NSInteger count = 0;
    if([self isCurrentYeat:year])
    {
        // 如果是今年，则报表数据从1月~当前月
        NSDate *date = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
        count = month;
    }
    else
    {
        // 如果不是今年，则报表数据计算全年的
        count = 12;
    }
    // 存储该年的yyyy-MM格式字符串
    NSMutableArray *monthArray = [NSMutableArray array];
    for(int i = 1; i<= count; i++)
    {
        NSString *month = nil;
        if(i < 10)
        {
            month = [NSString stringWithFormat:@"%@-0%zd", year, i];
        }
        else
        {
            month = [NSString stringWithFormat:@"%@-%zd", year, i];
        }
        [monthArray addObject:month];
    }
    
    for (NSString *monthStr in monthArray) {
        // 标记这个月是否有数据
        BOOL monthHasValue = NO;
        for (MPTrendModel *trend in datas) {
            if([monthStr isEqualToString:trend.month])
            {
                [self.incomeArray addObject:@(trend.income)];
                [self.outcomeArray addObject:@(trend.outcome)];
                [self.balanceArray addObject:@(trend.balance)];
                monthHasValue = YES;
                break;
            }
        }
        // 当这个月没有数据时，全部填充为0
        if(!monthHasValue)
        {
            [self.incomeArray addObject:@(0)];
            [self.outcomeArray addObject:@(0)];
            [self.balanceArray addObject:@(0)];
        }
    }
    // 设置折线图的数据
    _lineView.data = [self createChartData];
}

/// 判断yyyy的字符串是否是今年
- (BOOL)isCurrentYeat:(NSString *)year
{
    NSDate *date = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy";
    NSString *curYear = [df stringFromDate:date];
    return [curYear isEqualToString:year];
}

/// 在模型数组中找出最大值
- (double)getMaxValueInData:(NSArray *)data
{
    double max = 0;
    for (MPTrendModel *model in data) {
        if(model.income > max)
            max = model.income;
        if(model.outcome > max)
            max = model.outcome;
    }
    return max;
}

/// 生成报表数据
- (LineChartData *)createChartData
{
    NSInteger xVals_count = 12;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= xVals_count; i++) {
        [xVals addObject:[NSString stringWithFormat:@"%d月", i]];
    }
    _lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    
    //对应Y轴上面需要显示的数据
    NSMutableArray *incomeVals = [[NSMutableArray alloc] init];
    NSMutableArray *outcomeVals = [[NSMutableArray alloc] init];
    NSMutableArray *balanceVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.incomeArray.count; i++) {
        double income = [self.incomeArray[i] doubleValue];
        double outcome = [self.outcomeArray[i] doubleValue];
        double balncecome = [self.balanceArray[i] doubleValue];
        ChartDataEntry *incomeEntry = [[ChartDataEntry alloc] initWithX:i y:income];
        ChartDataEntry *outcomeEntry = [[ChartDataEntry alloc] initWithX:i y:outcome];
        ChartDataEntry *balanceEntry = [[ChartDataEntry alloc] initWithX:i y:balncecome];
        [incomeVals addObject:incomeEntry];
        [outcomeVals addObject:outcomeEntry];
        [balanceVals addObject:balanceEntry];
    }
    
    LineChartDataSet *set1 = [self setWithData:incomeVals lineColor:[UIColor blueColor] desc:@"收入"];
    LineChartDataSet *set2 = [self setWithData:outcomeVals lineColor:[UIColor greenColor] desc:@"支出"];
    LineChartDataSet *set3 = [self setWithData:balanceVals lineColor:[UIColor redColor] desc:@"结余"];
    
    //将 LineChartDataSet 对象放入数组中
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set3];
    [dataSets addObject:set2];
    [dataSets addObject:set1];
    
    //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
    LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];

    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
    [data setValueTextColor:[UIColor blackColor]];//文字颜色
    return data;
}

/// 根据数据生成LineChartDataSet，并指定这线的颜色，以及图例描述
- (LineChartDataSet *)setWithData:(NSArray *)data lineColor:(UIColor *)lineColor desc:(NSString *)desc
{
    LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:data label:desc];
    // 折线宽度
    set1.lineWidth = 2.0/[UIScreen mainScreen].scale;
    // 是否在拐点处显示数据
    set1.drawValuesEnabled = NO;
    // 设置显示格式
    set1.valueFormatter = [[SetValueFormatter alloc] initWithArr:data];
    // 折线颜色
    [set1 setColor:lineColor];
    // 是否开启绘制阶梯样式的折线图
    set1.drawSteppedEnabled = NO;
    // 折线拐点样式
    set1.drawCircleHoleEnabled = YES;
    set1.circleColors = @[lineColor];
    set1.circleRadius = 3;
    // 是否填充颜色
    set1.drawFilledEnabled = NO;
    return set1;
}


@end
