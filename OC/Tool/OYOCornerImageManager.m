//
//  OYOCornerImageManager.m
//  OYOConsumer
//
//  Created by zhanglei on 2018/8/4.
//  Copyright © 2018 www.oyohotels.cn. All rights reserved.
//

#import "OYOCornerImageManager.h"


@interface OYOCornerImageModel ()

@property (strong, nonatomic) UIImage * image;

@end


@implementation OYOCornerImageModel

@end;


@interface OYOCornerImageManager ()

@property (strong, nonatomic) NSMutableArray * images;

@end

@implementation OYOCornerImageManager

+ (instancetype)sharedManager{
    static OYOCornerImageManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (UIImage *)getImageWithBorderColor:(UIColor *)borderColor withRectCorner:(UIRectCorner)rectCorner withCornerRadius:(CGFloat)cornerRadius{
    
    CGRect rect = CGRectMake(0, 0, cornerRadius*3, cornerRadius*3);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
    
    rect = CGRectInset(rect, -cornerRadius, -cornerRadius);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius*2, cornerRadius*2)];
    
    [path setLineWidth:cornerRadius*2];
    
    [[UIColor clearColor] setFill];
    
    [borderColor setStroke];
    
    [path fill];
    
    [path stroke];
    
    UIImage * output = UIGraphicsGetImageFromCurrentImageContext();
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(cornerRadius/2*3, cornerRadius/2*3, cornerRadius/2*3, cornerRadius/2*3);
    
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    output = [output resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    
//    CGFloat cgImageBytesPerRow = CGImageGetBytesPerRow(output.CGImage);
//    CGFloat cgImageHeight = CGImageGetHeight(output.CGImage);
//    NSUInteger size  = cgImageHeight * cgImageBytesPerRow;
//    NSLog(@"size:%lu",(unsigned long)size);
    
    
    UIGraphicsEndImageContext();
    
    return output;
}

- (UIImage *)getImageWithOYOCornerImageModel:(OYOCornerImageModel *)model{
    
    for (OYOCornerImageModel * tmp in self.images) {
        if (tmp.corner == model.corner &&
            CGColorEqualToColor(tmp.borderColor.CGColor, model.borderColor.CGColor) &&
            tmp.radius == model.radius) {
            return tmp.image;
        }
    }
    
    model.image = [self getImageWithBorderColor:model.borderColor withRectCorner:model.corner withCornerRadius:model.radius];
    
    [self.images addObject:model];
    
    return model.image;
    
}

#pragma mark - Getter

- (NSMutableArray *)images{
    if (!_images) {
        _images = [[NSMutableArray alloc]init];
    }
    return _images;
}

@end
