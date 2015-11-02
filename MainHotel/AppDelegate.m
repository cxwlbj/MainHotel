//
//  AppDelegate.m
//  MainHotel
//
//  Created by iMac on 15-9-30.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "AppDelegate.h"
#import "RESideMenu.h"
#import "LeftViewController.h"
#import "MainTabBarController.h"


#import <AMapNaviKit/AMapNaviKit.h>
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlySetting.h"




@interface AppDelegate ()<RESideMenuDelegate,GestureViewDelegate>{
    UIView *_lockBackgroundView;//解锁背景图片
    UILabel *_tipsLable;//提示label
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor clearColor]];
    [self.window makeKeyAndVisible];
    
    //解锁视图
    [self lockView];
    
    
    return YES;
}

- (void)initMainView{
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:[[MainTabBarController alloc] init] leftMenuViewController:[[LeftViewController alloc] init] rightMenuViewController:nil];
    sideMenuViewController.delegate = self;
    [sideMenuViewController setDefaultStatus];
    
    self.window.rootViewController = sideMenuViewController;
    
    //设置状态栏 plist中 View controller-based status bar appearance 设置NO,可生效
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //高度地图导航
    [self configureAPIKey];
    //讯飞语音
    [self configIFlySpeech];
    
    //微信分享
    [WXApi registerApp:KWeChatAppID withDescription:nil];
    
}

//手势解锁
- (void)lockView{
    
    _lockBackgroundView = [[UIView alloc] initWithFrame:self.window.bounds];//解锁背景图片
    [self.window addSubview:_lockBackgroundView];
    
    _lockBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    GestureView *gestureLockView = [[GestureView alloc] init];
    gestureLockView.bounds = CGRectMake(0, 0, KIPHONEWidth, KIPHONEWidth);
    gestureLockView.backgroundColor = [UIColor clearColor];
    gestureLockView.center = _lockBackgroundView.center;
    gestureLockView.delegate = self;
    [_lockBackgroundView addSubview:gestureLockView];
    
    _tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, _lockBackgroundView.width, 30)];
    [_lockBackgroundView addSubview:_tipsLable];
    _tipsLable.textColor = [UIColor redColor];
    _tipsLable.textAlignment = NSTextAlignmentCenter;
    _tipsLable.font = [UIFont systemFontOfSize:18];
    _tipsLable.text = @"换个姿势,再来一次";
    _tipsLable.alpha = 0;
    
    
}


- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"apiKey为空，请检查key是否正确设置" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [AMapNaviServices sharedServices].apiKey = (NSString *)APIKey;
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
}


- (void)configIFlySpeech
{
    [IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@,timeout=%@",@"561cf6f3",@"20000"]];
    
    [IFlySetting setLogFile:LVL_NONE];
    [IFlySetting showLogcat:NO];
    
    // 设置语音合成的参数
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];//合成的语速,取值范围 0~100
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];//合成的音量;取值范围 0~100
    
    // 发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    
    // 音频采样率,目前支持的采样率有 16000 和 8000;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    // 当你再不需要保存音频时，请在必要的地方加上这行。
    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
}


//微信点击  你的app发送出去的链接 回调到你的app时调用
-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
        
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
       
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}
//发送完消息后,返回自己程序调用
-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    //NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
}

#pragma mark --  gestureView代理方法
- (void)gestureView:(GestureView *)gestureView didSelectPassword:(NSString *)password{
    
    if ([password isEqualToString:@"01"]) {
        //移除解锁视图
        [_lockBackgroundView removeFromSuperview];
        _lockBackgroundView = nil;
        
        //开启主视图
        [self initMainView];
    }else{
        
        [UIView animateWithDuration:.35 animations:^{
            _tipsLable.alpha = 1;
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:.35 animations:^{
                _tipsLable.alpha = 0;
            }];
        });
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
