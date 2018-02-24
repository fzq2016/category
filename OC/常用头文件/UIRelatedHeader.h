//
//  UIRelatedHeader.h
//  
//
//  Created by FZQ on 2018/2/9.
//  Copyright © 2018年 FZQ. All rights reserved.
//  此文件记录的是项目中通用UI元素宏；不包括系统控件尺寸，系统控件尺寸放在PrefixHeader中

#ifndef UIRelatedHeader_h
#define UIRelatedHeader_h



//----------------------颜色---------------------------
#pragma mark color
// 背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]
#define BLACK_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//----------------------颜色---------------------------



//----------------------字体----------------------------
#pragma mark - font
//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]
//----------------------字体----------------------------


//----------------------UILabel----------------------------
#define LABELWIDTH                       200
#define LABELHEIGHT                      15
#define LABEL_FONT_SIZE                  12
#define LABEL_FONT               [UIFont systemFontOfSize:UI_LABEL_FONT_SIZE]
//----------------------UILabel----------------------------


#endif /* UIRelatedHeader_h */
