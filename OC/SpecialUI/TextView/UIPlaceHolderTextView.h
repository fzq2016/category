//
//  UIPlaceHolderTextView.h
//  iOSBaseProject
//
//  Created by Felix on 13-5-21.
//  Copyright (c) 2013年 Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeholderColor;

- (void)textChanged:(NSNotification*)notification;

@end
