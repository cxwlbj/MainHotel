//
//  ThreeKilometersViewCtrl.h
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"
#import "SUNSlideSwitchView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "TitleButton.h"
#import "LocationViewController.h"
#import "BaseNavigationController.h"
#import "MBProgressHUD.h"


@interface ThreeKilometersViewCtrl : BaseViewController<SUNSlideSwitchViewDelegate,locationViewControllerDelegate>{
    TitleButton *_titleButton;//头标题
    
}

@property (nonatomic , strong) SUNSlideSwitchView *slideSwitchView;

@property (nonatomic , strong) FirstViewController *firstVC;
@property (nonatomic , strong) SecondViewController *secondVC;
@property (nonatomic , strong) ThirdViewController *ThirdVC;
@property (nonatomic , strong) FourViewController *fourVC;

@end
