//
//  BaseModel.h
//  MovieXP
//
//  Created by iMac on 15-8-20.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (id)initWithContent:(NSDictionary *)json;
//建立映射关系
- (id)mapAttributes:(NSDictionary *)dic;

@end
