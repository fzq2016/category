//
//  OYOAlignLabel.m
//  iOSBaseProject
//
//  Created by shawn on 2018/7/31.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import "OYOAlignLabel.h"
#import <CoreText/CoreText.h>

@interface OYOAlignLabel ()


@end

@implementation OYOAlignLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _verticalAlignment = VerticalAlignmentTop;
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment
{
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

/**
 MARK: - 需求:固定 frame 来展示，默认左边对齐，默认顶部对齐
 
 @param lineSpace 行间距
 @param font 字体font
 @param textContent 文本内容
 */
- (void)makeLeftAlignWithFrame:(CGRect)frame
                     lineSpace:(CGFloat)lineSpace
                          font:(UIFont *)font
                   textContent:(NSString *)textContent
{
    self.frame = frame;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textContent];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    // frame 不能显示完整时，以 ... 的形式显示
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.lineSpacing = lineSpace;
    
    
    NSDictionary *attributes = @{NSFontAttributeName:font,
                                 NSParagraphStyleAttributeName:paragraphStyle.copy};
    [attributedString addAttributes:attributes range:NSMakeRange(0, [textContent length])];
    
    
    self.attributedText = attributedString;
    self.numberOfLines = 0;
    
    
    // 会自动根据文字改变高度
    // [self sizeToFit];
    [self sizeThatFits:frame.size];
}


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
                   textContent:(NSString *)textContent
{
    self.frame = frame;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textContent];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    // frame 不能显示完整时，以 ... 的形式显示
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [paragraphStyle setLineSpacing:lineSpace];
    
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:font,
                                 NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone],
                                 NSParagraphStyleAttributeName:paragraphStyle.copy
                                 };
    
    [attributedString addAttributes:attributes range:NSMakeRange(0, [textContent length])];
    
    self.attributedText = attributedString;
    self.numberOfLines = 0;
    
    // 会自动根据文字改变高度
    //    [self sizeToFit];
    [self sizeThatFits:frame.size];
}


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
{
    //    CGSize rtSize;
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    ////    paragraphStyle.alignment = NSTextAlignmentLeft;
    //
    //    // frame 不能显示完整时，以 ... 的形式显示
    //    //    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    //
    //    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //    paragraphStyle.lineSpacing = lineSpacing;
    //
    //    NSDictionary *attributes = @{
    //                                 NSFontAttributeName:font,
    //                                 NSParagraphStyleAttributeName:paragraphStyle.copy
    //                                 };
    //    rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //    return ceil(rtSize.height) + 0.5;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(rtSize.height) + 0.5;
    
}


/**
 MARK: - 文字只显示一行时，计算宽度
 
 @param string 文本信息
 @param font 文本字体
 @return 文本宽度
 */
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize rtSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return ceil(rtSize.width) + 0.5;
}


/**
 MARK: - 截取 label 中换行后每一行的文字
 
 @param text 该label的文本信息
 @param rect 该label的bounds
 @param font 该label的font
 @return 每一行文字所组成的数组
 */
+ (NSArray *)getSeparatedLinesWith:(NSString *)text bounds:(CGRect)rect font:(UIFont *)font;
{
    //    NSString *text = [label text];
    //    CGRect    rect = [label frame];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //    [paragraphStyle setLineSpacing:lineSpace];
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, rect.size.width, 100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    //    NSLog(@"frame==%@", frame);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}


// 重写自带的方法，设置顶部 垂直居中 底部对齐
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment)
    {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect
{
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
