//
//  UIView+UIFactory.h
//  CBNWeekly
//
//  Created by Neo on 14-11-12.
//  Copyright (c) 2017年 CBN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIFactory)

/**
    Create Line

 @param frame frame
 @param color color. 默认是kHexRGB(0xE6E6E6)
 @return UIView
 */
+ (id)createLineView:(CGRect)frame color:(UIColor *)color;
+ (id)createLineView:(CGRect)frame;

/**
    Create Label

 @param frame frame
 @param text text. 默认是nil
 @param fontSize fontSize. 默认是12.0f
 @param textColor textColor. 默认是[UIColor blackColor]
 @param bgColor background Color. 默认是nil
 @return UILabel
 */
+ (id)createLabel:(CGRect)frame text:(NSString *)text size:(CGFloat)fontSize textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor;
+ (id)createLabel:(CGRect)frame text:(NSString *)text size:(CGFloat)fontSize textColor:(UIColor *)textColor;
+ (id)createLabel:(CGRect)frame text:(NSString *)text size:(CGFloat)fontSize;
+ (id)createLabel:(CGRect)frame text:(NSString *)text;
+ (id)createLabel:(CGRect)frame;
+ (id)createLabel;

/**
 Create TextField

 @param frame frame. 默认是CGRectZero
 @param textColor textColor. 默认是nil
 @param fontSize fontSize. 默认是0
 @param placeholderFontSize placeholderFontSize. 默认是0
 @param placeholder placeholder. 默认是nil
 @param placeholderColor placeholderColor. 默认是nil
 @param backgroundColor backgroundColor. 默认是nil
 @param cornerRadius cornerRadius. 默认是0
 @param borderColor borderColor. 默认是nil
 @param borderWidth borderWidth. 默认是0
 @return UITextField
 */
+ (id)createTextField:(CGRect)frame textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize placeholderFontSize:(CGFloat)placeholderFontSize placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
+ (id)createTextField:(CGRect)frame textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize placeholderFontSize:(CGFloat)placeholderFontSize placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor backgroundColor:(UIColor *)backgroundColor;
+ (id)createTextField;

/**
 Create TextView

 @param frame frame. 默认是CGRectZero
 @param fontSize fontSize. 默认是12.0f
 @param placeholder placeholder. 默认是@""
 @param placeholderColor placeholderColor. 默认是[UIColor colorWithWhite:0.800 alpha:1.000]
 @param placeholderFont placeholderFont. 默认是[UIFont systemFontOfSize:14]
 @return UITextView
 */
+ (id)createTextView:(CGRect)frame size:(CGFloat)fontSize placeholder:(NSString *)placeholder placeholderColor:(UIColor *)placeholderColor placeholderFont:(UIFont *) placeholderFont;
+ (id)createTextView:(CGRect)frame size:(CGFloat)fontSize placeholder:(NSString *)placeholder;
+ (id)createTextView:(CGRect)frame size:(CGFloat)fontSize;
+ (id)createTextView:(CGRect)frame;
+ (id)createTextView;

/**
 Create Button
 
 @param frame frame. 默认是CGRectZero
 @param fontSize fontSize. 默认是12.0f
 @param placeholder placeholder. 默认是@""
 @param placeholderColor placeholderColor. 默认是[UIColor colorWithWhite:0.800 alpha:1.000]
 @param placeholderFont placeholderFont. 默认是[UIFont systemFontOfSize:14]
 @return UITextView
 */

/**
 Create Button

 @param frame frame
 @param fontSize fontSize. 默认是16.0f
 @param title title. 默认是nil
 @param titleColor titleColor. 默认是[UIColor blackColor]
 @return UIButton
 */
+ (id)createButton:(CGRect)frame size:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor;
+ (id)createButton:(CGRect)frame size:(CGFloat)fontSize title:(NSString *)title;
+ (id)createButton:(CGRect)frame size:(CGFloat)fontSize;
+ (id)createButton:(CGRect)frame;

// 底层方法是"+ (id)createButton:(CGRect)frame";
+ (id)createButton:(CGRect)frame image:(UIImage *)image;
+ (id)createButton:(CGRect)frame image:(UIImage *)image selectedImage:(UIImage *)selectedImage;
+ (id)createButton:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;

// 底层方法是"+ (id)createButton:(CGRect)frame size:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor";
+ (id)createButton:(CGRect)frame size:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor;
+ (id)createButton:(CGRect)frame size:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor highlightedTitleColor:(UIColor *)highlightedTitleColor;
+ (id)createButton:(CGRect)frame size:(CGFloat)fontSize title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor  cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 Create ImageView

 @param frame frame. 默认是CGRectZero
 @param image image. 默认是nil
 @param highlightedImage highlightedImage. 默认是CGRectZero
 @param cornerRadius cornerRadius. 默认是0.0f
 @return UIImageView
 */
+ (id)createImageView:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage cornerRadius:(CGFloat)cornerRadius;
+ (id)createImageView:(CGRect)frame image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage;
+ (id)createImageView:(CGRect)frame image:(UIImage *)image;
+ (id)createImageView:(CGRect)frame;
+ (id)createImageView;

/**
 Create ScrollView

 @param frame frame. 默认是CGRectZero
 @param contentSize contentSize. 默认是frame.size
 @param showsScrollIndicator showsScrollIndicator. 默认是NO
 @param pagingEnabled pagingEnabled. 默认是NO
 @return UIScrollView
 */
+ (id)createScrollView:(CGRect)frame contentSize:(CGSize)contentSize showsScrollIndicator:(BOOL)showsScrollIndicator pagingEnabled:(BOOL)pagingEnabled;
+ (id)createScrollView:(CGRect)frame contentSize:(CGSize)contentSize showsScrollIndicator:(BOOL)showsScrollIndicator;
+ (id)createScrollView:(CGRect)frame contentSize:(CGSize)contentSize;
+ (id)createScrollView:(CGRect)frame;
+ (id)createScrollView;

// NavigationBar
+ (UINavigationBar *)setFakeNavigationBarStyle:(UINavigationBar *)navBar forView:(UIView *)view isGreen:(BOOL)isGreen isWhite:(BOOL)isWhite;
+ (void)setNavigationBarStyle:(UINavigationBar *)navBar isGreen:(BOOL)isGreen isWhite:(BOOL)isWhite;

/**
 Create CAGradientLayer

 @param frame frame
 @param colors colors
 @param locations locations
 @param startPoint startPoint
 @param endPoint endPoint
 @return CAGradientLayer
 */
+ (id)creatGradientLayerWithFrame:(CGRect)frame colors:(NSArray *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
    获取1像素的分割线

 @param frame frame
 @param color color. 默认是kHexRGB(0xd6d6d6)
 @return UILabel
 */
+ (UILabel *)getSeparatorLine:(CGRect)frame withColor:(UIColor *)color;
+ (UILabel *)getSeparatorLine:(CGRect)frame;

// 按行切割文字
+ (NSArray<NSAttributedString *> *)getLinesOfAttributestringInLabel:(UILabel *)label;
+ (NSArray<NSString *> *)getLinesOfStringInLabel:(UILabel *)label;

- (void)distributeSpacingHorizontallyWith:(NSArray *)views
                                   vWidth:(CGFloat)width;

@end
