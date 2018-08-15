//
//  UIColor+Theme.h
//  OYOConsumer
//
//  Created by neo on 2018/8/10.
//  Copyright © 2018年 www.oyohotels.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Theme)

UIColor * themeBackgroundColor();


/**
 *  Defines the gradient style and direction of the gradient color.
 *
 *  @since 1.0
 */
typedef NS_ENUM (NSUInteger, UIGradientStyle) {
    /**
     *  Returns a gradual blend between colors originating at the leftmost point of an object's frame, and ending at the rightmost point of the object's frame.
     */
    UIGradientStyleLeftToRight,
    /**
     *  Returns a gradual blend between colors originating at the center of an object's frame, and ending at all edges of the object's frame. NOTE: Supports a Maximum of 2 Colors.
     */
    UIGradientStyleRadial,
    /**
     *  Returns a gradual blend between colors originating at the topmost point of an object's frame, and ending at the bottommost point of the object's frame.
     */
    UIGradientStyleTopToBottom,
    UIGradientStyleDiagonal
};



#pragma mark - Gradient Colors

/**
 *  Creates and returns a gradient as a color object with an alpha value of 1.0
 *
 *  @param gradientStyle Specifies the style and direction of the gradual blend between colors.
 *  @param frame The frame rectangle, which describes the view’s location and size in its superview’s coordinate system.
 *  @param colors An array of color objects used to create a gradient.
 *
 *  @return A @c UIColor object using colorWithPattern.
 */
+ (UIColor *)colorWithGradientStyle:(UIGradientStyle)gradientStyle withFrame:(CGRect)frame andColors:(NSArray<UIColor *> * _Nonnull)colors;

#pragma mark - Colors from Hex Strings

/**
 *  Creates and returns a @c UIColor object based on the specified hex string.
 *
 *  @param string The hex string.
 *
 *  @return A @c UIColor object in the RGB colorspace.
 */
+ (UIColor * _Nullable)colorWithHexString:(NSString* _Nonnull)string;

/**
 *  Creates and returns a @c UIColor object based on the specified hex string.
 *
 *  @param string The hex string.
 *  @param alpha  The opacity.
 *
 *  @return A @c UIColor object in the RGB colorspace.
 */
+ (UIColor * _Nullable)colorWithHexString:(NSString * _Nonnull)string withAlpha:(CGFloat)alpha;

@end
