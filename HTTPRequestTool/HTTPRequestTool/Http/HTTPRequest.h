//
//  HTTPRequest.h
//  FollowInclinationBuy
//
//  Created by DJC on 14-6-14.
//  Copyright (c) 2014年 DJC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "UIDevice+Resolutions.h"

//定义一个block
typedef void(^sendResponse) (NSDictionary * resultDic);
typedef void(^NotifyCompletionBlock) (BOOL status);
// 请求结束之后的错误类型判断
typedef NS_ENUM(NSInteger,ErrorType)  {
    ErrorTypeConnectionInterruption = 500,  // 服务器连接中断
    ErrorTypeNetWorkUnuse = 1005,           // 网络故障（本地检测的NetWorkNoUse）
};

@interface HTTPRequest : AFHTTPSessionManager<MBProgressHUDDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) MBProgressHUD *progress;
@property (assign, nonatomic) ErrorType errorType;
@property (assign, nonatomic) BOOL isApiDataEncrypt; // api是否需要加密默认NO不加密

@property (copy, nonatomic) sendResponse block;
@property (copy, nonatomic) sendResponse eiorBlock;
@property (copy, nonatomic) NotifyCompletionBlock notifyBlock;
@property (nonatomic, strong) AFHTTPSessionManager *AFManager;
@property (nonatomic, strong) NSURLSessionDataTask *currentTask;

+ (instancetype)sharedInstance;

// post 方式获取数据

- (void)postDataSendHttpRequestWithUrlString:(NSString *)urlString withView:(UIView *)superView isJsonStr:(BOOL )isJson AES:(BOOL )isAES isUpdateToken:(BOOL)isUpdateToken WithDic:(NSDictionary *)dic withApiVersion:(NSString*)apiVersion completion:(void (^)(NSDictionary *resultDic))success;

// 通用提醒MBProgress 实现
- (void)displayWarn:(NSString *)warnStr WithStus:(BOOL)status duringTime:(CGFloat)duringTime completion:(NotifyCompletionBlock)newBlock;

// 点赞专用提醒 包含圆角 位置等设置
- (void)displayText:(NSString *)warnStr WithStus:(BOOL)status duringTime:(CGFloat)duringTime completion:(NotifyCompletionBlock)newBlock;

- (void)removeProgressHUD;
- (void)showProgressHUDWithView:(UIView *)view warnMessage:(NSString *)message;

@end

