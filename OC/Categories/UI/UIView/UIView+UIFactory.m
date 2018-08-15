//
//  UIView+UIFactory.m
//  iOSBaseProject
//
//  Created by Felix on 18-8-12.
//  Copyright (c) 2018年 Felix. All rights reserved.
//

#import "UIView+UIFactory.h"
#import <Masonry.h>
#import <CoreText/CoreText.h>
#import "UIPlaceHolderTextView.h"

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@implementation UIView (UIFactory)

#pragma mark - Line

+ (id)createLineView:(CGRect)frame
{
    return [self createLineView:frame
                          color:kHexRGB(0xE6E6E6)];
}

+ (id)createLineView:(CGRect)frame
               color:(UIColor *)color
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = color;
    view.userInteractionEnabled = NO;
    return view;
}

#pragma mark - Label

+ (id)createLabel
{
    return [self createLabel:CGRectZero];
}

+ (id)createLabel:(CGRect)frame
{
    return [self createLabel:frame
                        text:nil];
}

+ (id)createLabel:(CGRect)frame
             text:(NSString *)text
{
    return [self createLabel:frame
                        text:text
                        size:12.0f];
}

+ (id)createLabel:(CGRect)frame
             text:(NSString *)text
             size:(CGFloat)fontSize
{
    return [self createLabel:frame
                        text:text
                        size:fontSize
                   textColor:[UIColor blackColor]];
}

+ (id)createLabel:(CGRect)frame
             text:(NSString *)text
             size:(CGFloat)fontSize
        textColor:(UIColor *)textColor;
{
    return [self createLabel:frame
                        text:text
                        size:fontSize
                   textColor:textColor
                     bgColor:nil];
}

+ (id)createLabel:(CGRect)frame
             text:(NSString *)text
             size:(CGFloat)fontSize
        textColor:(UIColor *)textColor
          bgColor:(UIColor *)bgColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    if (text) {
        label.text = text;
    }
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    if (textColor) {
        label.textColor = textColor;
    }
    label.font = kFont(fontSize);
    return label;
}

#pragma mark - TextField

+ (id)createTextField
{
    return [UIView createTextField:CGRectZero
                         textColor:nil
                          fontSize:0
               placeholderFontSize:0
                       placeholder:nil
                  placeholderColor:nil
                   backgroundColor:nil];
}

+ (id)createTextField:(CGRect)frame
            textColor:(UIColor *)textColor
             fontSize:(CGFloat)fontSize
  placeholderFontSize:(CGFloat)placeholderFontSize
          placeholder:(NSString *)placeholder
     placeholderColor:(UIColor *)placeholderColor
      backgroundColor:(UIColor *)backgroundColor
{
    return [self createTextField:frame
                       textColor:textColor
                        fontSize:fontSize
             placeholderFontSize:placeholderFontSize
                     placeholder:placeholder
                placeholderColor:placeholderColor
                 backgroundColor:backgroundColor
                    cornerRadius:0
                     borderColor:nil
                     borderWidth:0];
}

+ (id)createTextField:(CGRect)frame
            textColor:(UIColor *)textColor
             fontSize:(CGFloat)fontSize
  placeholderFontSize:(CGFloat)placeholderFontSize
          placeholder:(NSString *)placeholder
     placeholderColor:(UIColor *)placeholderColor
      backgroundColor:(UIColor *)backgroundColor
         cornerRadius:(CGFloat)cornerRadius
          borderColor:(UIColor *)borderColor
          borderWidth:(CGFloat)borderWidth;
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    if (fontSize > 0) {
        textField.font = kFont(fontSize);
    }
    if (textColor) {
        textField.textColor = textColor;
    }
    if (placeholder) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                                          attributes:@{NSFontAttributeName: kFont(placeholderFontSize),
                                                                                       NSForegroundColorAttributeName: placeholderColor}];
    }
    if (cornerRadius > 0) {
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = cornerRadius;
    }
    if (borderColor) {
        textField.layer.borderColor = borderColor.CGColor;
        textField.layer.borderWidth = borderWidth;
    }
    textField.backgroundColor = backgroundColor;
    return textField;
}

#pragma mark - TextView

+ (id)createTextView
{
    return [self createTextView:CGRectZero];
}

+ (id)createTextView:(CGRect)frame
{
    return [self createTextView:frame
                           size:12.0f];
}

+ (id)createTextView:(CGRect)frame
                size:(CGFloat)fontSize
{
    return [self createTextView:frame
                           size:fontSize
                    placeholder:@""];
}

+ (id)createTextView:(CGRect)frame
                size:(CGFloat)fontSize
         placeholder:(NSString *)placeholder
{
    return [self createTextView:frame
                           size:fontSize
                    placeholder:placeholder
               placeholderColor:[UIColor colorWithWhite:0.800 alpha:1.000]
                placeholderFont:[UIFont systemFontOfSize:14]];
}

+ (id)createTextView:(CGRect)frame
                size:(CGFloat)fontSize
         placeholder:(NSString *)placeholder
    placeholderColor:(UIColor *)placeholderColor
     placeholderFont:(UIFont *) placeholderFont
{
    UIPlaceHolderTextView *textView = [[UIPlaceHolderTextView alloc] initWithFrame:frame];
    textView.font = kFont(fontSize);
    textView.placeholder = placeholder;
    textView.placeholderColor = placeholderColor;
    textView.placeholderFont = placeholderFont;
    return textView;
}

#pragma mark - Button

+ (id)createButton:(CGRect)frame
{
    return [self createButton:frame
                         size:16.0f];
}

+ (id)createButton:(CGRect)frame
              size:(CGFloat)fontSize
{
    return [self createButton:frame
                         size:fontSize
                        title:nil];
}

+ (id)createButton:(CGRect)frame
             image:(UIImage *)image
{
    UIButton *button = [self createButton:frame];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    return button;
}

+ (id)createButton:(CGRect)frame
             image:(UIImage *)image
     selectedImage:(UIImage *)selectedImage
{
    UIButton *button = [self createButton:frame
                                    image:image];
    if (selectedImage) {
        [button setImage:image forState:UIControlStateHighlighted];
        [button setImage:selectedImage forState:UIControlStateSelected];
    }
    return button;
}

+ (id)createButton:(CGRect)frame
             image:(UIImage *)image
  highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = [self createButton:frame
                                    image:image];
    if (highlightedImage) {
        [button setImage:highlightedImage forState:UIControlStateHighlighted];
    }
    return button;
}

+ (id)createButton:(CGRect)frame
              size:(CGFloat)fontSize
             title:(NSString *)title
{
    return [self createButton:frame
                         size:fontSize
                        title:title
                   titleColor:[UIColor blackColor]];
}

+ (id)createButton:(CGRect)frame
              size:(CGFloat)fontSize
             title:(NSString *)title
        titleColor:(UIColor *)titleColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = kFont(fontSize);
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    return button;
}

+ (id)createButton:(CGRect)frame
              size:(CGFloat)fontSize
             title:(NSString *)title
        titleColor:(UIColor *)titleColor
selectedTitleColor:(UIColor *)selectedTitleColor
{
    UIButton *button = [self createButton:frame
                                     size:fontSize
                                    title:title
                               titleColor:titleColor];
    if (selectedTitleColor) {
        [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
        [button setTitleColor:selectedTitleColor forState:UIControlStateHighlighted];
    }
    return button;
}

+ (id)createButton:(CGRect)frame
              size:(CGFloat)fontSize
             title:(NSString *)title
        titleColor:(UIColor *)titleColor
highlightedTitleColor:(UIColor *)highlightedTitleColor
{
    UIButton *button = [self createButton:frame
                                     size:fontSize
                                    title:title
                               titleColor:titleColor];
    if (highlightedTitleColor) {
        [button setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
    }
    return button;
}

+ (id)createButton:(CGRect)frame
              size:(CGFloat)fontSize
             title:(NSString *)title
        titleColor:(UIColor *)titleColor
   backgroundColor:(UIColor *)backgroundColor
      cornerRadius:(CGFloat)cornerRadius
       borderWidth:(CGFloat)borderWidth
       borderColor:(UIColor *)borderColor
{
    UIButton *button = [self createButton:frame
                                     size:fontSize
                                    title:title
                               titleColor:titleColor];
    if (backgroundColor) {
        button.backgroundColor = backgroundColor;
    }
    if (cornerRadius > 0) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = cornerRadius;
    }
    if (borderWidth > 0) {
        button.layer.borderWidth = borderWidth;
        button.layer.borderColor = borderColor.CGColor;
    }
    return button;
}

#pragma mark - ImageView

+ (id)createImageView
{
    return [self createImageView:CGRectZero];
}

+ (id)createImageView:(CGRect)frame
{
    return [self createImageView:frame
                           image:nil];
}

+ (id)createImageView:(CGRect)frame
                image:(UIImage *)image
{
    return [self createImageView:frame
                           image:image
                highlightedImage:nil];
}

+ (id)createImageView:(CGRect)frame
                image:(UIImage *)image
     highlightedImage:(UIImage *)highlightedImage
{
    return [self createImageView:frame
                           image:image
                highlightedImage:highlightedImage
                    cornerRadius:0.0f];
}

+ (id)createImageView:(CGRect)frame
                image:(UIImage *)image
     highlightedImage:(UIImage *)highlightedImage
         cornerRadius:(CGFloat)cornerRadius
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (image) {
        imageView.image = image;
    }
    if (highlightedImage) {
        imageView.highlightedImage = highlightedImage;
    }
    if (cornerRadius > 0.0f) {
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = cornerRadius;
    }
    return imageView;
}

#pragma -mark - ScrollView

+ (id)createScrollView
{
    return [self createScrollView:CGRectZero];
}

+ (id)createScrollView:(CGRect)frame
{
    return [self createScrollView:frame
                      contentSize:frame.size];
}

+ (id)createScrollView:(CGRect)frame
           contentSize:(CGSize)contentSize
{
    return [self createScrollView:frame
                      contentSize:contentSize
             showsScrollIndicator:NO];
}

+ (id)createScrollView:(CGRect)frame
           contentSize:(CGSize)contentSize
  showsScrollIndicator:(BOOL)showsScrollIndicator
{
    return [self createScrollView:frame
                      contentSize:contentSize
             showsScrollIndicator:showsScrollIndicator
                    pagingEnabled:NO];
}

+ (id)createScrollView:(CGRect)frame
           contentSize:(CGSize)contentSize
  showsScrollIndicator:(BOOL)showsScrollIndicator
         pagingEnabled:(BOOL)pagingEnabled
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = contentSize;
    scrollView.showsHorizontalScrollIndicator = showsScrollIndicator;
    scrollView.showsVerticalScrollIndicator = showsScrollIndicator;
    scrollView.pagingEnabled = pagingEnabled;
    scrollView.delaysContentTouches = NO;
    return scrollView;
}

#pragma -mark - NavigationBar

+ (void)setNavigationBarStyle:(UINavigationBar *)navBar
                      isGreen:(BOOL)isGreen
                      isWhite:(BOOL)isWhite
{
    if (isGreen) {
        [navBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg"] forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:nil];
    } else {
        [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [navBar setShadowImage:nil];
    }
    
    UIColor *color = nil;
    if (isWhite) {
        color = [UIColor whiteColor];
    } else {
        color = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName: color,
                                   NSFontAttributeName: kFont(20)};
}

+ (UINavigationBar *)setFakeNavigationBarStyle:(UINavigationBar *)navBar
                                       forView:(UIView *)view
                                       isGreen:(BOOL)isGreen
                                       isWhite:(BOOL)isWhite
{
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];

    UIColor *color = nil;
    if (isWhite) {
        color = [UIColor whiteColor];
    } else {
        color = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName: color,
                                   NSFontAttributeName: kFont(20)};

    UINavigationBar *fakeNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 64)];
    if (isGreen) {
        [fakeNavBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg"] forBarMetrics:UIBarMetricsDefault];
        [fakeNavBar setShadowImage:nil];
    } else {
        [fakeNavBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [fakeNavBar setShadowImage:nil];
    }
    [view addSubview:fakeNavBar];

    return fakeNavBar;
}

#pragma -mark - CAGradientLayer
+ (id)creatGradientLayerWithFrame:(CGRect)frame
                           colors:(NSArray *)colors
                        locations:(NSArray<NSNumber *> *)locations
                       startPoint:(CGPoint)startPoint
                         endPoint:(CGPoint)endPoint
{
    //  创建 CAGradientLayer 对象
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    //  设置 gradientLayer 的 Frame
    gradientLayer.frame = frame;
    
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = colors;
    
    //  设置三种颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = locations;
    
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    return gradientLayer;
}

#pragma mark - Separator Line

+ (UILabel *)getSeparatorLine:(CGRect)frame
{
    return [UIView getSeparatorLine:frame
                          withColor:kHexRGB(0xd6d6d6)];
}

+ (UILabel *)getSeparatorLine:(CGRect)frame
                    withColor:(UIColor *)color
{
    CGFloat lineWidth = SINGLE_LINE_WIDTH;
    CGFloat pixelAdjustOffset = SINGLE_LINE_WIDTH;
    if (((int)(lineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
        pixelAdjustOffset = SINGLE_LINE_ADJUST_OFFSET;
    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectZero];
    //xPos yPos
    line.frame = CGRectMake(frame.origin.x-pixelAdjustOffset, frame.origin.y-pixelAdjustOffset, frame.size.width, lineWidth);
    line.backgroundColor = color;
    return line;
}

#pragma mark - Other

+ (NSArray<NSAttributedString *> *)getLinesOfAttributestringInLabel:(UILabel *)label{
    NSAttributedString *attrString = [label attributedText];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:attrString];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0,attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path,NULL,CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter,CFRangeMake(0,0), path,NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSAttributedString *lineString = [attrString attributedSubstringFromRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,lineRange,kCTKernAttributeName,(CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,lineRange,kCTKernAttributeName,(CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}


+ (NSArray<NSString *> *)getLinesOfStringInLabel:(UILabel *)label{
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];
    
    CTFontRef myFont = CTFontCreateWithName((CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0,attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path,NULL,CGRectMake(0,0,rect.size.width,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter,CFRangeMake(0,0), path,NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,lineRange,kCTKernAttributeName,(CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr,lineRange,kCTKernAttributeName,(CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

- (void)distributeSpacingHorizontallyWith:(NSArray *)views
                                   vWidth:(CGFloat)width
{
    NSMutableArray *spaces = [NSMutableArray arrayWithCapacity:views.count+1];
    
    for ( int i = 0 ; i < views.count+1 ; ++i )
    {
        UIView *v = [UIView new];
        [spaces addObject:v];
        [self addSubview:v];
        
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(v.mas_height);
        }];
    }
    
    UIView *v0 = spaces[0];
    
    //__weak __typeof([views[0] superview])
    UIView *ws = [views[0] superview];
    
    [v0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.mas_left);
        make.centerY.equalTo(((UIView*)views[0]).mas_centerY);
    }];
    
    UIView *lastSpace = v0;
    for ( int i = 0 ; i < views.count; ++i )
    {
        UIView *obj = views[i];
        UIView *space = spaces[i+1];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastSpace.mas_right);
            make.centerY.equalTo(ws.mas_centerY);
            make.size.width.equalTo(@(width));
        }];
        
        [space mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(obj.mas_right);
            make.centerY.equalTo(obj.mas_centerY);
            make.width.equalTo(v0);
        }];
        
        lastSpace = space;
    }
    
    [lastSpace mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right);
    }];
}

@end
