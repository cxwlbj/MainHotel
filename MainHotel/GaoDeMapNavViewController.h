//
//  GaoDeMapNavViewController.h
//  MainHotel
//
//  Created by iMac on 15-10-13.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"

#import <AMapNaviKit/MAMapKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>

#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

@interface GaoDeMapNavViewController : BaseViewController<MAMapViewDelegate,AMapSearchDelegate,AMapNaviManagerDelegate,IFlySpeechSynthesizerDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) AMapNaviManager *naviManager;

@property (nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;

@end


