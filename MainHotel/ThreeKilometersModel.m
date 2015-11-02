//
//  ThreeKilometersModel.m
//  MainHotel
//
//  Created by iMac on 15-10-12.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "ThreeKilometersModel.h"

@implementation ThreeKilometersModel

- (instancetype)initWithContent:(NSDictionary *)json
{
    self = [super initWithContent:json];
    if (self) {
        
        self.ThreeKid = json[@"id"];
        
    }
    return self;
}

@end
