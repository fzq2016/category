//
//  OYOAlignLabel.h
//  iOSBaseProject
//
//  Created by shawn on 2018/7/31.
//  Copyright © 2018年 Felix. All rights reserved.
/*
 UILabel 中 @property(nonatomic) NSTextAlignment    textAlignment，实现的是水平方向的对齐方式；
 竖直方向是默认将文字放在竖直方向的中间显示的。
 
 这个类实现文字的顶部对齐显示，底部对齐显示，中间显示；
 可以设置 文字的行间距 lineSpace；
 适合iOS 7.0及其以上，不适合iOS 6.0；
 
 */


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VerticalAlignment) {
    VerticalAlignmentTop = 0,  // 文本顶部对齐
    VerticalAlignmentMiddle,   // 文本放在垂直中间
    VerticalAlignmentBottom,   // 文本底部对齐
};

@interface OYOAlignLabel : UILabel

/// 如果不赋值，默认是VerticalAlignmentTop
@property (nonatomic, assign) VerticalAlignment verticalAlignment;

/**
 MARK: - 需求:固定 frame 来展示，默认左边对齐，默认顶部对齐
 
 @param lineSpace 行间距
 @param font 字体font
 @param textContent 文本内容
 */
- (void)makeLeftAlignWithFrame:(CGRect)frame
                     lineSpace:(CGFloat)lineSpace
                          font:(UIFont *)font
                   textContent:(NSString *)textContent;


/**
 MARK: - 需求:固定 frame 来展示，默认左边右边两端对齐，默认顶部对齐
 
 paragraphStyle.alignment = NSTextAlignmentJustified
 [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [text length])];
 这两个设置使文字左边和右边两端对齐
 
 @param frame 需要展示的固定的frame
 @param lineSpace 行间距
 @param font 字体font
 @param textContent 文本内容
 */
- (void)makeBothAlignWithFrame:(CGRect)frame
                     lineSpace:(CGFloat)lineSpace
                          font:(UIFont *)font
                   textContent:(NSString *)textContent;


/**
 MARK: - 固定宽度时算出文本的高度
 
 @param string 文本信息
 @param lineSpacing 行间距
 @param font 文字字体
 @param width 文本固定的宽度
 @return 文本所需的高度
 */
+ (CGFloat)heightWithString:(NSString *)string
                lineSpacing:(CGFloat)lineSpacing
                       font:(UIFont *)font
         constrainedToWidth:(CGFloat)width;


/**
 MARK: - 文字只显示一行时，计算宽度
 
 @param string 文本信息
 @param font 文本字体
 @return 文本宽度
 */
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;


/**
 MARK: - 截取 label 中换行后每一行的文字
 
 @param text 该label的文本信息
 @param rect 该label的bounds
 @param font 该label的font
 @return 每一行文字所组成的数组
 */
+ (NSArray *)getSeparatedLinesWith:(NSString *)text bounds:(CGRect)rect font:(UIFont *)font;


@end
