//
//  UIImageView+ZQUtil.m
//  iOSBaseProject
//
//  Created by Felix on 6/16/15.
//  Copyright (c) 2015 Felix. All rights reserved.
//

#import "UIImageView+ZQUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (ZQUtil)

- (void)zq_loadPortrait:(NSURL *)portraitURL
{
    [self sd_setImageWithURL:portraitURL placeholderImage:[UIImage imageNamed:@"portrait_loading"] options:0];
}

@end
