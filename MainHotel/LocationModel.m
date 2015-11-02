//
//  LocationModel.m
//  MainHotel
//
//  Created by iMac on 15-10-8.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

- (instancetype)initWithContent:(NSDictionary *)json
{
    self = [super initWithContent:json];
    if (self) {
        //key
        self.key = [[self.code substringToIndex:1] capitalizedString];
    }
    return self;
}

@end
