//
//  UIDevice+Resolutions.h
//  Terminal
//
//  Created by lishaowei on 14-4-15.
//  Copyright (c) 2014年 lishaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    // iPhone 1,3,3GS 标准分辨率(320x480px)
    UIDevice_iPhoneStandardRes      = 1,
    // iPhone 4,4S 高清分辨率(640x960px)
    UIDevice_iPhoneHiRes            = 2,
    // iPhone 5 高清分辨率(640x1136px)
    UIDevice_iPhoneTallerHiRes      = 3,
    // iPad 1,2 标准分辨率(1024x768px)
    UIDevice_iPadStandardRes        = 4,
    // iPad 3 High Resolution(2048x1536px)
    UIDevice_iPadHiRes              = 5,
    // 750 * 1334 
    UIDevice_iPhoneTallerHiRe6      = 6,
    // 1242 * 2208
    UIDevice_iPhoneTallerHiRe6p     = 7,
    // 1125 * 2436
    UIDevice_iPhoneTallerHiReX      = 8,
    
}; typedef NSUInteger UIDeviceResolution;

// 根据屏幕尺寸定制系列判断


@interface UIDevice (Resolutions){
    
}

/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 获取当前分辨率
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (UIDeviceResolution) currentResolution;
// 获取具体的设备类型
+ (NSString *)getCurrentDeviceModel;


/******************************************************************************
 函数名称 : + (UIDeviceResolution) currentResolution
 函数描述 : 当前是否运行在iPhone5端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone5;

/******************************************************************************
 函数名称 : + (BOOL)isRunningOniPhone
 函数描述 : 当前是否运行在iPhone端
 输入参数 : N/A
 输出参数 : N/A
 返回参数 : N/A
 备注信息 :
 ******************************************************************************/
+ (BOOL)isRunningOniPhone4s;
+ (BOOL)isRunningOniPhone6;
+ (BOOL)isRunningOniPhone6p;
+ (BOOL)isRunningOniPhoneX;

@end
