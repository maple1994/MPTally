//
//  XMGPlaceholderTextView.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/8/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "FQPlaceholderTextView.h"

@interface FQPlaceholderTextView()
/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation FQPlaceholderTextView

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.mp_x = 4;
        placeholderLabel.mp_y = 7;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (instancetype)init
{
  if(self  = [super init])
  {
    [self setUp];
  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
    // 监听文字改变
    [self setUp];
}

- (void)resignKeyboard {
    [self resignFirstResponder];
}

- (void)setUp{
    // 垂直方向上永远有弹簧效果
    self.alwaysBounceVertical = YES;
    
    // 默认字体
    self.font = [UIFont systemFontOfSize:15];
    
    // 默认的占位文字颜色
    self.placeholderColor = [UIColor grayColor];
    
    // 监听文字改变
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}

/**
 * 更新占位文字的尺寸
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect frame = self.placeholderLabel.frame;
    frame.size.width = self.frame.size.width - 2 * frame.origin.x;
    self.placeholderLabel.frame = frame;
//    self.placeholderLabel.width = self.width - 2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
    
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

/** 设置当前placeholder文本中，个别文字的颜色*/
- (void)setSomePlaceholderColor:(UIColor *)color withText:(NSString *)text {
    //如果placeholder中，没有该文字，直接返回
    if (![self.placeholderLabel.text containsString:text]) {
        NSLog(@"改文字在placeholder中找不到！！！");
        return;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.placeholderLabel.text];
    NSRange range = [self.placeholderLabel.text rangeOfString:text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.placeholderLabel.attributedText = str;
}


/**
 * setNeedsDisplay方法 : 会在恰当的时刻自动调用drawRect:方法
 * setNeedsLayout方法 : 会在恰当的时刻调用layoutSubviews方法
 */

@end
