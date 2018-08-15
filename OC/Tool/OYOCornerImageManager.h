//
//  OYOCornerImageManager.h
//  OYOConsumer
//
//  Created by zhanglei on 2018/8/4.
//  Copyright © 2018 www.oyohotels.cn. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OYOCornerImageModel : NSObject

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, assign) UIRectCorner corner;

@property (nonatomic, strong) UIColor * borderColor;

@end

static inline id OYOCornerImageModelMake(UIColor * borderColor, UIRectCorner corner, CGFloat radius){
    OYOCornerImageModel * model = [[OYOCornerImageModel alloc]init];
    model.radius = radius;
    model.corner = corner;
    model.borderColor = borderColor;
    return model;
}

@interface OYOCornerImageManager : NSObject

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)sharedManager;

- (UIImage *)getImageWithOYOCornerImageModel:(nonnull OYOCornerImageModel *)model;

@end
