//
//  MPCalculatorView.m
//  MPTally
//
//  Created by Maple on 2017/3/7.
//  Copyright © 2017年 Maple. All rights reserved.
//

#import "MPCalculatorView.h"

@interface MPCalculatorView ()

@property (weak, nonatomic) IBOutlet UIButton *accountButton;
@property (weak, nonatomic) IBOutlet UIButton *remarkButton;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;
@property (nonatomic, copy) NSMutableString *resultString;

/** 小数点前的字符串 */
@property (nonatomic, copy) NSString *beforSting;
/** 小数点后的字符串 */
@property (nonatomic, copy) NSString *afterString;
/** 当前字符串 */
@property (nonatomic, copy) NSString *currentString;
/** 做运算之前的字符串 */
@property (nonatomic, copy) NSString *previousString;
/** 选择了小数点 */
@property (nonatomic, assign, getter=isSelectedPoint) BOOL selectedPoint;
/** 选择了`＋`号运输符 */
@property (nonatomic, assign, getter=isSelectedPlusOperation) BOOL selectedPlusOperation;
/** 选择了运行操作符号 */
@property (nonatomic, assign, getter=isSelectedOperation) BOOL selectedOperation;
/** 第一次做运算操作 */
@property (nonatomic, assign, getter=isFirstOperation) BOOL firstOperation;
/** 计算结果 */
@property (nonatomic, copy) NSString *results;

@end

@implementation MPCalculatorView

- (void)awakeFromNib
{
  [super awakeFromNib];
  self.selectedDate = [NSDate date];
  [self initializesWithPreparation];
}

/** 初始化准备 */
- (void)initializesWithPreparation {
  self.beforSting = @"0";
  self.afterString = @"00";
  self.currentString = [NSString stringWithFormat:@"%@.%@",self.beforSting,self.afterString];
  self.selectedPoint = NO;
  self.selectedPlusOperation = NO;
  self.selectedOperation = NO;
  self.previousString = @"";
}

#pragma mark - Action
- (IBAction)selectAccount:(UIButton *)sender
{
  if([self.delegate respondsToSelector:@selector(calculatorViewDidClickAccount:)])
  {
    [self.delegate calculatorViewDidClickAccount:self];
  }
  kFuncNameLog;
}

- (IBAction)selectDate:(UIButton *)sender
{
  if([self.delegate respondsToSelector:@selector(calculatorViewDidClickCalendar:)])
  {
    [self.delegate calculatorViewDidClickCalendar:self];
  }
}

- (IBAction)mark:(UIButton *)sender
{
  if([self.delegate respondsToSelector:@selector(calculatorViewDidClickRemark:)])
  {
    [self.delegate calculatorViewDidClickRemark:self];
  }
  kFuncNameLog;
}

- (IBAction)calculatorClick:(UIButton *)sender
{
  NSString *text = sender.currentTitle;
  if (sender.tag == 111) // 点击了.
  {
    self.selectedPoint = YES;
//    return;
  } else if (sender.tag == 115) // 归零
  {
    [self initializesWithPreparation];
    NSLog(@"results = %@",self.currentString);
    _results = self.currentString;
//    return;
  }
  else if (sender.tag == 113 || sender.tag == 114)
  {
    if (sender.tag == 114) //加号
    {
      self.selectedPlusOperation = YES;
      float sum = self.previousString.floatValue + self.currentString.floatValue;
      self.currentString = [NSString stringWithFormat:@"%.2f",sum];
    } else
    { //减号
      if (self.previousString.floatValue != 0)
      {
        float poor = self.previousString.floatValue - self.currentString.floatValue;
        self.currentString = [NSString stringWithFormat:@"%.2f",poor];
      }
      self.selectedPlusOperation = NO;
    }
    _results = self.currentString;
    NSLog(@"results = %@",self.currentString);
    self.previousString = self.currentString;
    self.beforSting = @"0";
    self.afterString = @"00";
    self.selectedPoint = NO;
    self.selectedOperation = YES;
//    return;
  }
  else if (sender.tag == 112) // =
  {//* ------------------------------------- */
    if (self.isSelectedOperation) {//当用户选择了运输操作符则进行运算,没有则直接输出
      if (self.isSelectedPlusOperation)
      {
        float sum = self.previousString.floatValue + self.currentString.floatValue;
        self.currentString = [NSString stringWithFormat:@"%.2f",sum];
      } else
      {
        float poor = self.previousString.floatValue - self.currentString.floatValue;
        self.currentString = [NSString stringWithFormat:@"%.2f",poor];
      }
    }
    //* 传值 */
    NSLog(@"OK results = %@",self.currentString);
    _results = self.currentString;
    [self initializesWithPreparation];
    if([self.delegate respondsToSelector:@selector(calculatorView:passTheResult:)])
    {
      [self.delegate calculatorView:self passTheResult:_results];
    }
    return;
  }
  else if (self.isSelectedPoint)
  {
    //小数点后
    self.afterString = [NSString stringWithFormat:@"%@0",text];
  }
  else
  {
    //小数点前
    if ([self.beforSting isEqualToString:@"0"])
    {
      //第一次输入或者用户输入为0
      self.beforSting = text;
    } else
    {
      self.beforSting = [NSString stringWithFormat:@"%@%@",self.beforSting,text];
    }
  }
  self.currentString = [NSString stringWithFormat:@"%@.%@",self.beforSting,self.afterString];
  NSLog(@"results = %@",self.currentString);
  _results = self.currentString;
  
  if([self.delegate respondsToSelector:@selector(calculatorView:passTheResult:)])
  {
    [self.delegate calculatorView:self passTheResult:_results];
  }

}

- (void)test2:(UIButton *)button
{
  // 100 ~ 109 = 0 ~ 9
  if(button.tag >= 100 && button.tag <= 109)
  {
    // 识别0的情况
    if(self.resultString.length == 0 && button.tag == 100)
    {
      return;
    }
    [self.resultString appendString:[NSString stringWithFormat:@"%zd", button.tag - 100]];
    
    NSLog(@"%@", _resultString);
  }
  else if(button.tag == 110) // C归零
  {
    self.resultString = nil;
  }
  else if(button.tag == 111) // 小数点
  {
    NSLog(@"小数点");
  }
  else if(button.tag == 112) // =
  {
    NSLog(@"=");
  }
  else if(button.tag == 113)
  {
    NSLog(@"-");
  }
  else if(button.tag == 114)
  {
    NSLog(@"+");
  }
  else if(button.tag == 115)
  {
    NSLog(@"删除");
  }
}

- (void)test:(UIButton *)sender
{
  NSString *text = sender.currentTitle;
  
  if ([text isEqualToString:@"."])
  {
    self.selectedPoint = YES;
    return;
  } else if ([text isEqualToString:@"清零"])
  {
    [self initializesWithPreparation];
    NSLog(@"results = %@",self.currentString);
  } else if ([text isEqualToString:@"+"] || [text isEqualToString:@"-"] )
  {
    if ([text isEqualToString:@"+"])
    {
      //加号
      self.selectedPlusOperation = YES;
      //* 和 */
      float sum = self.previousString.floatValue + self.currentString.floatValue;
      self.currentString = [NSString stringWithFormat:@"%.2f",sum];
    } else {
      //减号
      //* 差 */
      if (self.previousString.floatValue != 0) {
        float poor = self.previousString.floatValue - self.currentString.floatValue;
        self.currentString = [NSString stringWithFormat:@"%.2f",poor];
      }
      self.selectedPlusOperation = NO;
    }
    NSLog(@"results = %@",self.currentString);
    self.previousString = self.currentString;
    self.beforSting = @"0";
    self.afterString = @"00";
    self.selectedPoint = NO;
    self.selectedOperation = YES;
    return;
  } else if ([text isEqualToString:@"OK"])
  {//* ------------------------------------- */
    if (self.isSelectedOperation) {//当用户选择了运输操作符则进行运算,没有则直接输出
      if (self.isSelectedPlusOperation) {
        float sum = self.previousString.floatValue + self.currentString.floatValue;
        self.currentString = [NSString stringWithFormat:@"%.2f",sum];
      } else {
        float poor = self.previousString.floatValue - self.currentString.floatValue;
        self.currentString = [NSString stringWithFormat:@"%.2f",poor];
      }
    }
    //* 传值 */
    NSLog(@"OK results = %@",self.currentString);

    [self initializesWithPreparation];
    return;
  }
  if (self.isSelectedPoint)
  {
    //小数点后
    self.afterString = [NSString stringWithFormat:@"%@0",text];
  } else
  {
    //小数点前
    if ([self.beforSting isEqualToString:@"0"])
    {
      //第一次输入或者用户输入为0
      self.beforSting = text;
    } else
    {
      self.beforSting = [NSString stringWithFormat:@"%@%@",self.beforSting,text];
    }
  }
  self.currentString = [NSString stringWithFormat:@"%@.%@",self.beforSting,self.afterString];
  NSLog(@"results = %@",self.currentString);
}

#pragma mark - setter
- (void)setSelectedDate:(NSDate *)selectedDate
{
  _selectedDate = selectedDate;
  NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
  fmt.dateFormat = @"M月d日";
  [self.dateButton setTitle:[fmt stringFromDate:selectedDate] forState:UIControlStateNormal];
}

- (NSMutableString *)resultString
{
  if(_resultString == nil)
  {
    _resultString = [[NSMutableString alloc] initWithString:@"00.00"];
  }
  return _resultString;
}


@end
