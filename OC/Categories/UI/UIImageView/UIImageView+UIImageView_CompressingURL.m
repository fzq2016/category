//
//  UIImageView+UIImageView_CompressingURL.m
//  iOSBaseProject
//
//  Created by Felix on 04/12/15.
//  Copyright © 2015 Felix. All rights reserved.
//

#import "UIImageView+UIImageView_CompressingURL.h"
#import "NSString+ZQContainString.h"


@implementation UIImageView (UIImageView_CompressingURL)

#pragma mark - Utility
- (NSArray *)getAllCompressedURLforURL:(NSURL *)url{
    if(url.absoluteString.length > 0 && ![self isCompressedURL:url.absoluteString]){
    return @[[self getUrlWithCompressionType:imageCompressionTypeLarge andUrl:url],
             [self getUrlWithCompressionType:imageCompressionTypeMedium andUrl:url],
             [self getUrlWithCompressionType:imageCompressionTypeSmall andUrl:url]];
    }
    return nil;
}

- (NSURL *)getCompressedImageURLForImageURl:(NSURL *)currentURL{
    if(currentURL.absoluteString.length > 0){
        CGFloat width = 2 * self.bounds.size.width;
        if(width >= 510){ // high
            return [self getUrlWithCompressionType:imageCompressionTypeLarge andUrl:currentURL];
        }
        else if(width >= 340 ){ // medium
            return [self getUrlWithCompressionType:imageCompressionTypeMedium andUrl:currentURL];
        }
        else{   // low
            return [self getUrlWithCompressionType:imageCompressionTypeSmall andUrl:currentURL];
        }
        return currentURL;
    }
    return [NSURL URLWithString:@""];
}

- (NSURL *) getUrlWithCompressionType:(enum ImageCompressionType)type andUrl:(NSURL *)originalUrl{
    NSRange range =  [[originalUrl absoluteString] rangeOfString:@"/" options:NSBackwardsSearch];
    NSMutableString *newURL = [NSMutableString stringWithString:[originalUrl absoluteString]];
    if(range.location <= newURL.length){
        switch (type) {
            case imageCompressionTypeLarge:
                [newURL insertString:@"large/" atIndex:range.location + 1];
                break;
                
            case imageCompressionTypeMedium:
                [newURL insertString:@"medium/" atIndex:range.location + 1];
                break;
                
            case imageCompressionTypeSmall:
                [newURL insertString:@"small/" atIndex:range.location + 1];
                break;
            default:
                return originalUrl;
                break;
        }
    }
    return [NSURL URLWithString:newURL];
}

- (BOOL)isCompressedURL:(NSString *)urlString{
    if([urlString hasSubstring:@"/small/"] || [urlString hasSubstring:@"/medium/"] || [urlString hasSubstring:@"/large/"]){
        return YES;
    }
    return NO;
}

#pragma mark - Image Download Methods
- (void)sd_setCompressedImageWithURL:(NSURL *)url{
    [self sd_setImageWithURL:[self getCompressedImageURLForImageURl:url]];
}
- (void)sd_setCompressedImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    [self sd_setImageWithURL:[self getCompressedImageURLForImageURl:url] placeholderImage:placeholder];
}
- (void)sd_setCompressedImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options{
    [self sd_setImageWithURL:[self getCompressedImageURLForImageURl:url] placeholderImage:placeholder options:options];
}
- (void)sd_setCompressedImageWithURL:(NSURL *)url completed:(SDExternalCompletionBlock)completedBlock{
    [self sd_setImageWithURL:[self getCompressedImageURLForImageURl:url] completed:completedBlock];
}
- (void)sd_setCompressedImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock{
    [self sd_setImageWithURL:[self getCompressedImageURLForImageURl:url] placeholderImage:placeholder completed:completedBlock];
}
- (void)sd_setCompressedImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDExternalCompletionBlock)completedBlock{
    [self sd_setImageWithURL:[self getCompressedImageURLForImageURl:url] placeholderImage:placeholder options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        completedBlock(image, error, cacheType, imageURL);
    }];
}
- (void)sd_setCompressedImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock{
    [self sd_setImageWithURL:[self getCompressedImageURLForImageURl:url] placeholderImage:placeholder options:options progress:progressBlock completed:completedBlock];
}

#pragma mark - Animation
- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder animated:(BOOL)animated{
    [self setImageWithURL:url placeholder:placeholder animated:animated completion:nil];
}

- (void) setImageWithURL:(NSURL *)url animated:(BOOL)animated{
    [self setImageWithURL:url placeholder:nil animated:animated completion:nil];
}

- (void) setCompressedImageWithURL:(NSURL *)url animated:(BOOL)animated{
    [self setImageWithURL:[self getCompressedImageURLForImageURl:url] animated:animated];
}

- (void) setImageWithURL:(NSURL *)url placeholder:(UIImage *)placeholder animated:(BOOL)animated completion:(void (^ __nullable)(BOOL finished))completion{
    if(url){
        if(animated){
            __weak typeof(self) weakImageView = self;
            [self sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageAvoidAutoSetImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                if(cacheType == SDImageCacheTypeNone){
                    [UIView transitionWithView:weakImageView
                                      duration:0.3
                                       options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionAllowUserInteraction
                                    animations:^{
                                        weakImageView.image = image;
                                    } completion:^(BOOL isFinished){
                                    }];
                }
                else{
                    weakImageView.image = image;
                }
            }];
        }
        else{
            [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        }
    }
}


@end
