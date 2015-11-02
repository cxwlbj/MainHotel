//
//  SeeTheWordBigFrame.h
//  MainHotel
//
//  Created by iMac on 15-10-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeeTheWordModel.h"

@interface SeeTheWordBigFrame : NSObject

@property (nonatomic, strong) SeeTheWordModel *model;

@property (nonatomic, assign) CGRect imageShowFrame;

@property (nonatomic, assign) CGRect titleFrame;

@property (nonatomic, assign) CGRect textDetailFrame;

@property (nonatomic, assign) CGRect collectViewFrame;

@property (nonatomic, assign) CGRect seeViewFrame;

@property (nonatomic, assign) CGFloat bigCellHeight;

@end
