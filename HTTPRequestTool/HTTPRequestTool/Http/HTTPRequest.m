//
//  HTTPRequest.m
//  FollowInclinationBuy
//
//  Created by DJC on 14-6-14.
//  Copyright (c) 2014年 DJC. All rights reserved.

#import "HTTPRequest.h"
//日志输出
#ifdef DEBUG
#define YBDLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#else
#define YBDLog(...)
#endif

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

@implementation HTTPRequest

//加载进度显示
- (void)showProgressHUDWithView:(UIView *)view warnMessage:(NSString *)message
{
    
    if (view != nil) {
        _progress = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:_progress];
        [view bringSubviewToFront:_progress];
        _progress.removeFromSuperViewOnHide = YES;
        if (message.length>0) {
            _progress.detailsLabel.text = message;
        }
        _progress.detailsLabel.font = [UIFont systemFontOfSize:14];
        _progress.animationType = MBProgressHUDAnimationZoom;
        _progress.mode = MBProgressHUDModeIndeterminate;
        _progress.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        _progress.bezelView.color = [UIColor blackColor];
        _progress.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        _progress.contentColor = [UIColor whiteColor];
        _progress.delegate = self;
        [_progress  showAnimated:YES];
        
    }else{
        [self removeProgressHUD];
    }
}
//加载进度移除
- (void)removeProgressHUD{
    if (_progress)
    {
        [_progress removeFromSuperview];
        _progress = nil;
    }
}

- (void)displayWarn:(NSString *)warnStr WithStus:(BOOL)status duringTime:(CGFloat)duringTime completion:(NotifyCompletionBlock)newBlock{
    
    if (warnStr.length == 0) return;
    if (warnStr.length <= 5) {
        duringTime = 1.0;
    }
    
    self.notifyBlock = newBlock;
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow  animated:YES];
        hud.detailsLabel.text = ([warnStr length]>0)?warnStr:@"网不好";
        hud.detailsLabel.font =[UIFont systemFontOfSize:14];
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor blackColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.contentColor = [UIColor whiteColor];
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
//        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageWithImageSimple:[UIImage imageNamed:status?@"Checkmark":@"wrong"] scaledToSize:CGSizeMake(37, 37)]];
        hud.mode = MBProgressHUDModeCustomView;
        [hud hideAnimated:YES afterDelay:duringTime];
        @weakify(self)
        hud.completionBlock = ^{
            if (weak_self.notifyBlock) {
                weak_self.notifyBlock(YES);
            }
        };
    });
}

// 点赞专用 提醒
- (void)displayText:(NSString *)warnStr WithStus:(BOOL)status duringTime:(CGFloat)duringTime completion:(NotifyCompletionBlock)newBlock{
    
    if (warnStr.length == 0) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        
    self.notifyBlock = newBlock;
    
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow  animated:YES];
        hud.detailsLabel.text = ([warnStr length]>0)?warnStr:@"网络不好";
        hud.detailsLabel.font =[UIFont systemFontOfSize:14];
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [UIColor blackColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.contentColor = [UIColor whiteColor];
        hud.removeFromSuperViewOnHide = YES;
        hud.mode = MBProgressHUDModeText;
        hud.animationType = MBProgressHUDAnimationZoom;
        [hud hideAnimated:YES afterDelay:duringTime];
        @weakify(self)
        hud.completionBlock = ^{
            if (weak_self.notifyBlock) {
                weak_self.notifyBlock(YES);
            }
        };
    });
}



// 获取数据的单例
+ (instancetype)sharedInstance {
    static HTTPRequest *_SessionManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _SessionManager = [[HTTPRequest alloc] initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        if (!_SessionManager.AFManager) {
            _SessionManager.AFManager = [[HTTPRequest alloc] initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        }
    });
    return _SessionManager;
}
//+ (instancetype)sharedInstance {
//    static HTTPRequest *_SessionManager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _SessionManager = [[HTTPRequest alloc] initWithBaseURL:[NSURL URLWithString:@"www.baidu.com"] sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    });
//    return _SessionManager;
//}



//[[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]]

// 返回的Data 类型数据 转为json字符串
-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

// 加密方式请求数据
- (void)postDataSendHttpRequestWithUrlString:(NSString *)urlString withView:(UIView *)superView isJsonStr:(BOOL )isJson AES:(BOOL )isAES isUpdateToken:(BOOL)isUpdateToken WithDic:(NSDictionary *)dic withApiVersion:(NSString*)apiVersion completion:(void (^)(NSDictionary *resultDic))success
{
    @weakify(self)
    // 进度条必须加到主线程中显示
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self);
        [self removeProgressHUD];
        [self showProgressHUDWithView:superView warnMessage:nil];
    });

    self.requestSerializer.timeoutInterval = 10;

        NSLog(@"RequestUrl-->%@",urlString);
        NSString * str = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
        id temDic = [[NSMutableDictionary alloc]initWithDictionary:dic];
        if (isJson) {
            NSError *error = nil;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            temDic = jsonTemp;
        }
    
//        if (XXGF_App.netWorkReachable) {
            
            NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST"URLString:str parameters:nil error:nil];
            request.timeoutInterval= 20;
            [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            /**
             imei//手机卡槽信息
             meid//手机卡槽信息
             
             location//经纬度
             area//地址
             */
            
            [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            // 渠道
            [request setValue:@"0" forHTTPHeaderField:@"channel"];
            
//            // token
//            [request setValue:UserToken forHTTPHeaderField:@"token"];
//            // 是否更新token
//            if ([UserToken length] > 0) {
//                [request setValue:(isUpdateToken?@"true":@"false") forHTTPHeaderField:@"isTokenUpdate"];
//            }else{
//                [request setValue:@"false" forHTTPHeaderField:@"isTokenUpdate"];
//            }
//
//            //当前版本号
//            [request setValue:XXGF_App.currentVersion forHTTPHeaderField:@"version"];
//
//            // 手机IP WIFI
//            if (XXGF_App.status == AFNetworkReachabilityStatusReachableViaWWAN){
//                [request setValue:XXGF_App.ipStr forHTTPHeaderField:@"X-Client-IP"];
//            }
//
//            // 设备号
//            [request setValue:XXGF_App.udidStr forHTTPHeaderField:@"device"];
//            // 接口路径
//            [request setValue:str forHTTPHeaderField:@"path"];
//            // 推送ID
//            [request setValue:XXGF_App.pushId forHTTPHeaderField:@"pushID"];
//
//            //手机系统版本
//            [request setValue:XXGF_App.phoneVersion forHTTPHeaderField:@"os"];
//
//            // 手机型号
//            [request setValue:XXGF_App.model forHTTPHeaderField:@"model"];
//
//            // 地址
//            [request setValue:XXGF_App.addressStr forHTTPHeaderField:@"area"];
//
//            // location
//            [request setValue:[NSString stringWithFormat:@"%@,%@",XXGF_App.lat,XXGF_App.lng] forHTTPHeaderField:@"location"];
            
            // 设置body
            NSData *body = [temDic dataUsingEncoding:NSUTF8StringEncoding];
            
            [request setHTTPBody:body];
            
            
            AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
            responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/plain",
                                                         nil];
            [HTTPRequest sharedInstance].AFManager.responseSerializer = responseSerializer;
            
//            @weakify(self);
            [[[HTTPRequest sharedInstance].AFManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
                
            } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
                
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
                    NSDictionary *dic = [r allHeaderFields];
                    if (isUpdateToken) {
                        // 保持登录状态下自动更新token
                        if ([dic objectForKey:@"token"]) {
                            NSString *token = [dic objectForKey:@"token"];
                            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                        }
                    }
                }
                @strongify(self)
                if (!error) {
                    
                    [self removeProgressHUD];
                    NSDictionary * dataDic = [self resultDatahandle:responseObject requestUrl:urlString task:nil];
                    if (dataDic) {
                        success(dataDic);
                    }
                }else{
                    
                    [self removeProgressHUD];
                    NSDictionary * temDic= [[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)error.code],@"resError",[NSString stringWithFormat:@"%@",[error description]],@"Error", nil];
                    success(temDic);
                    return ;
                }
            }] resume];
            
//        }else{
//
////            @strongify(self)
//            // 什么网都没开
//            [self removeProgressHUD];
//            NSDictionary * temDic= [[NSDictionary alloc]initWithObjectsAndKeys:netErrrorStr,@"resError",[NSString stringWithFormat:@"%ld",(long)ErrorTypeNetWorkUnuse],@"ErrorCode", nil];
//            success(temDic);
//            [self displayWarn:netErrrorStr WithStus:NO duringTime:DisShowTime completion:^(BOOL complt) {
//            }];
//        }
}




#pragma mark-- 处理返回数据中可能存在的Null类型

//删除字典里的null值
- (NSDictionary *)deleteEmpty:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] initWithDictionary:dic];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    for (id obj in mdic.allKeys)
    {
        id value = mdic[obj];
        if ([value isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:value];
            [dicSet setObject:changeDic forKey:obj];
        }
        else if ([value isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:value];
            [arrSet setObject:changeArr forKey:obj];
        }
        else
        {
            if ([value isKindOfClass:[NSNull class]]) {
                [set addObject:obj];
            }
        }
    }
    for (id obj in set)
    {
        mdic[obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        mdic[obj] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        mdic[obj] = arrSet[obj];
    }
    
    return mdic;
}


//删除数组中的null值
- (NSArray *)deleteEmptyArr:(NSArray *)arr
{
    NSMutableArray *marr = [NSMutableArray arrayWithArray:arr];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    NSMutableDictionary *dicSet = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *arrSet = [[NSMutableDictionary alloc] init];
    
    for (id obj in marr)
    {
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *changeDic = [self deleteEmpty:obj];
            NSInteger index = [marr indexOfObject:obj];
            [dicSet setObject:changeDic forKey:@(index)];
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            NSArray *changeArr = [self deleteEmptyArr:obj];
            NSInteger index = [marr indexOfObject:obj];
            [arrSet setObject:changeArr forKey:@(index)];
        }
        else
        {
            if ([obj isKindOfClass:[NSNull class]]) {
                NSInteger index = [marr indexOfObject:obj];
                [set addObject:@(index)];
            }
        }
    }
    for (id obj in set)
    {
        marr[(int)obj] = @"";
    }
    for (id obj in dicSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = dicSet[obj];
    }
    for (id obj in arrSet.allKeys)
    {
        int index = [obj intValue];
        marr[index] = arrSet[obj];
    }
    return marr;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 666666) {
        if (buttonIndex == 0) {
            // token失效未登录
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"exitLogin" object:XXGF_App.viewController];
        }
    }
}

//// 成功解析返回数据
-(NSDictionary*)resultDatahandle:(id)responseObject requestUrl:(NSString*)requestUrl task:(NSURLSessionDataTask *) task{

    NSDictionary *  resultDic = nil;
    if(!responseObject){
        return nil;
    }
//    NSLog(@"responseObject-->:%@",responseObject);
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        resultDic = responseObject;
        //清楚数据中可能存在的null
        resultDic = [self deleteEmpty:resultDic];
        
    }else{
        
        if (responseObject == nil||[responseObject isKindOfClass:[NSNull class]]) {
            return nil ;
            
        }else if ([responseObject isKindOfClass:[NSString class]]){
            return nil;

        }else if ([responseObject isKindOfClass:[NSData class]]){
            
            // 返回加密的NSData 类型
            NSString *requestTmp = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
            //系统自带JSON解析
            resultDic =[NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
            if ([[NSString stringWithFormat:@"%@",[resultDic objectForKey:@"status"]] isEqualToString:@"201"]) {
            }else{
                return resultDic;
            }
        }
    }
    
    
    NSString * codeStr = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"code"]];
    if ([codeStr isEqualToString:@"404"]) {
        // token过期
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"UserInfo"];
//
//        [XXGF_App setNullTags];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"MineDataUpdate" object:nil];
//        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:XXGFBangDingQRCode];
//        [[NSUserDefaults standardUserDefaults] synchronize];


    }else if ([codeStr isEqualToString:@"400"]){
        // 没有登录
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"UserInfo"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
//
//        [XXGF_App setNullTags];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"MineDataUpdate" object:nil];
//        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:XXGFBangDingQRCode];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//        [[HTTPRequest sharedInstance] displayWarn:[resultDic objectForKey:@"message"] WithStus:NO duringTime:DisShowTime completion:nil];
//        return resultDic;
        
    }else if ([codeStr isEqualToString:@"405"]){
        // 用户不存在
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"UserInfo"];
//        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
//
//        [XXGF_App setNullTags];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"MineDataUpdate" object:nil];
//        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:XXGFBangDingQRCode];
//        [[NSUserDefaults standardUserDefaults] synchronize];


    }

    return resultDic;
}


@end
