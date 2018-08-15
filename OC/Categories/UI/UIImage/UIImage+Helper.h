//
//  UIImage+Helper.h
//  iOSBaseProject
//
//  Created by Felix on 2018/7/17.
//  Copyright © 2018年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Helper)

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;


//保持原来的长宽比，生成一个缩略图
+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (UIImage*)imageWithImage:(UIImage* )sourceImage scaledToWidth: (CGFloat)i_width;

+ (UIImage *)imageWithImage:(UIImage *)image cropToFrame:(CGRect)frame;

+ (UIImage *)cropImage:(UIImage*)image toSize:(CGSize)size;
/**
 *  等比例缩放后居中裁剪图片
 *
 *  @param image 图片
 *  @param newSize  裁剪的大小
 *
 *  @return 处理后的图片
 */

+ (UIImage *)cropImage:(UIImage *)image scaledToSize:(CGSize)newSize;



/**
 *  图片添加文字
 *
 *  @param img   图片
 *  @param text1 文字
 *
 *  @return UIImage
 */
+ (UIImage *)addTexttoImage:(UIImage *)img text:(NSString *)text1;

/**
 *  图片添加Logo
 *
 *  @param img  图片
 *  @param logo logo
 *
 *  @return UIImage
 */
+ (UIImage *)addImageLogo:(UIImage *)img logoImage:(UIImage *)logo;

/**
 *  图片合并
 *
 *  @param useImage  图片
 *  @param addImage1 图片
 *
 *  @return UIImage
 */
+ (UIImage *)addImage:(UIImage *)useImage addImage1:(UIImage *)addImage1;

/**
 获取图片中某个位置的颜色
 */
- (UIColor *)colorAtPixel:(CGPoint)point;


@end
