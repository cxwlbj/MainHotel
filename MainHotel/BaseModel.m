//
//  BaseModel.m
//  MovieXP
//
//  Created by iMac on 15-8-20.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

//提供初始化方法
- (id)initWithContent:(NSDictionary *)json{
    if (self = [super init]) {
        [self setModelData:json];
    }
    return self;
}

//对象的属性建立映射关系
// 1.获取当前字典的映射关系
#warning 一般可以默认使用父类的映射方法,如果遇到json中有oc的关键字,可以让子类重写父类的这个映射.
- (id)mapAttributes:(NSDictionary *)dic{
    
    // 创建映射关系字典
    NSMutableDictionary *keyAndAttDic = [NSMutableDictionary dictionary];
    // 给字典设置默认的映射关系
    for (NSString *key in dic) {
        // key :字典里面的key
        // value :model里面属性的名字
        [keyAndAttDic setObject:key forKey:key];
    }
    return keyAndAttDic;
}


//为属性生成setter方法
- (SEL)setterMethod:(NSString *)key{
    //取key的第一个字符并转换成大写字母
    NSString *first = [[key substringToIndex:1] capitalizedString];
    //返回key的第一个字符(不包括第一个)到结尾的字符串
    NSString *end = [key substringFromIndex:1];
    //链接成setter方法的名称
    NSString *setterName = [NSString stringWithFormat:@"set%@%@:",first,end];
    return NSSelectorFromString(setterName);
    
}

//为字典建立模型对象
- (void)setModelData:(NSDictionary *)json{
    
    //建立映射关系
    NSDictionary *mapDic = [self mapAttributes:json];
    
    for (id key in mapDic) {
        
        //1.setter方法 映射@"key":"value" 中的key建立 setter方法
        SEL sel = [self setterMethod:key];
        
        if ([self respondsToSelector:sel]) {
            
            //2.得到JSON key
            id jsonKey = [mapDic objectForKey:key];
            
            //3.得到json的 value
            
            id jsonValue = [json objectForKey:jsonKey];
            
            [self performSelector:sel withObject:jsonValue];
        }
    }
}

@end
