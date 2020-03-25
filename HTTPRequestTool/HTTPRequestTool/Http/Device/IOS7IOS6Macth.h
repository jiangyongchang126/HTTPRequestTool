//
//  IOS7IOS6Macth.h
//  ZYCoreDataSuperDemo1
//
//  Created by Box on 14-3-13.
//  Copyright (c) 2014年 Box. All rights reserved.
//

#ifndef ZYCoreDataSuperDemo1_IOS7IOS6Macth_h
#define ZYCoreDataSuperDemo1_IOS7IOS6Macth_h

//disable loggin on production
#ifdef DEBUG
#define KSLog(format, ...) CFShow((__bridge CFTypeRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);

#import "Extend_Description.h"

#else
#define KSLog(...)
#endif

#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define CGRECT_NO_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?20:0)), (w), (h))
#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))
//by  Box
#define is4Inch ([UIScreen mainScreen].bounds.size.height == 568.0)
#define Height_NO_NAV (is4Inch?568:460)
#define Height_HAVE_NAV (is4Inch?504:416)


#pragma mark --- 判断设备尺寸
// 这种判断只是为了宽高 适配机型 只是尺寸上的适配

//判断是不是iphone4  3
#define kYX_IS_IPHONE4 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height < 481.0f)
//判断是不是iphone5
#define kYX_IS_IPHONE5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height > 481.0f&& [[UIScreen mainScreen] bounds].size.height < 569.0f)
//判断是不是iphone6，6s
#define kYX_IS_IPHONE6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height > 569.0f&& [[UIScreen mainScreen] bounds].size.height < 668.0f)
//判断是不是iphone6p 6sp
#define kYX_IS_IPHONE6P ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height > 668.0f&& [[UIScreen mainScreen] bounds].size.height < 737.0f)
////判断是不是有刘海的设备
#define kYX_IS_IPHONEX ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height > 737.0f)
////判断是不是iphoneX或者iphoneXS
#define kYX_IS_IPHONEXS ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height > 737.0f&& [[UIScreen mainScreen] bounds].size.height < 813.0f)
////判断是不是iphoneX MAX或者iphoneXR
#define kYX_IS_IPHONEXR ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height > 813.0f&& [[UIScreen mainScreen] bounds].size.height < 897.0f)

#pragma mark --- 判断设备类型

//判断是不是iphone
#define kYX_IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//判断是不是iPad
#define EGODevice_iPad  (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark --- 判断设备系统

//判断版本是否是5.0及以上
#define EGOVersion_iOS5 ([[UIDevice currentDevice].systemVersion doubleValue] >= 5.0)

//判断版本是否是6.0及以上
#define EGOVersion_iOS6 ([[UIDevice currentDevice].systemVersion doubleValue] >= 6.0)

//判断版本是否是7.0及以上
#define EGOVersion_iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

//判断版本是否是8.0及以上
#define EGOVersion_iOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

//判断版本是否是9.0及以上
#define EGOVersion_iOS9 ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0)

//判断版本是否是10.0及以上
#define EGOVersion_iOS10 ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)

//判断版本是否是11.0及以上
#define EGOVersion_iOS11 ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0)

//判断版本是否是12.0及以上
#define EGOVersion_iOS12 ([[UIDevice currentDevice].systemVersion doubleValue] >= 12.0)

#endif

