//
//  WXDataService.m
//  MyWeibo
//
//  Created by zsm on 14-3-5.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^CompletionLoad)(id result,NSError *error);

@interface DataService : NSObject

//封装数据请求,返回模型数组,通过代理继续其他操作
//+ (NSArray *)requestNetWorkDataWith:(NSInteger)cityID checkin:(NSString *)checkin checkout:(NSString *)checkout;

/**
 * 注意 : 如果请求体body中,body为无key值(二进制NSData) params字典中key设置为 @""
 */
//AFNetworking
+ (AFHTTPRequestOperation *)requestAFWithURL:(NSString *)url
                                    params:(NSMutableDictionary *)params
                             requestHeader:(NSDictionary *)header
                                httpMethod:(NSString *)httpMethod
                                     block:(CompletionLoad)block;

//系统自带类库
+ (NSMutableURLRequest *)requestWithURL:(NSString *)url
                                 params:(NSMutableDictionary *)params
                          requestHeader:(NSDictionary *)header
                             httpMethod:(NSString *)httpMethod
                                  block:(CompletionLoad)block;

@end
