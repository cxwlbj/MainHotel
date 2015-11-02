//
//  ShareView.m
//  MainHotel
//
//  Created by iMac on 15-10-15.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "ShareView.h"

#define KShareButtonHW 50
#define KShareViewH 100
#define KCancelButtonH 40

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
        [self shareViewAnimation];
    }
    return self;
}


- (instancetype)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}


- (void)setUpSubviews{
    
    
    CGFloat showHeight = self.frame.size.height;
    
//    CGFloat showHeight = KIPHONEHeight - XNavgationBarHeight - XTabBarHeight;
    
    _maskView = [[UIView alloc] initWithFrame:self.bounds];//遮盖图层
    [self addSubview:_maskView];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = .5;
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.alpha = 0;
    _cancelButton.frame = CGRectMake(XMargin, showHeight - KCancelButtonH - XMargin * 2, KIPHONEWidth - XMargin * 2, KCancelButtonH);
    _cancelButton.layer.cornerRadius = 10;
    _cancelButton.layer.masksToBounds = YES;
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.backgroundColor = [UIColor whiteColor];
    [_cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:_cancelButton];
    
    _showView = [[UIView alloc] initWithFrame:CGRectMake(XMargin, _cancelButton.top - XMargin * 2 - KShareViewH, KIPHONEWidth -  XMargin * 2, KShareViewH)];//展示图层
    _showView.alpha = 0;
    [self addSubview:_showView];
    _showView.layer.cornerRadius = 10;
    _showView.layer.masksToBounds = YES;
    _showView.backgroundColor = [UIColor whiteColor];
    
    //分享按钮
    NSArray *titleArr = @[@"微信好友",@"微信朋友圈",@"微信收藏"];
    NSArray *imageArr = @[@"share_daodao_weixin",@"share_daodao_friend",@"share_daodao_message"];
    
    CGFloat margin = (KIPHONEWidth - titleArr.count * KShareButtonHW) / (titleArr.count + 1);
    for (int i=0; i<titleArr.count; i++) {
        
        CenterLabelButton *button = [[CenterLabelButton  alloc] initWithFrame:CGRectMake(margin + (margin + KShareButtonHW) * i, 20, KShareButtonHW, KShareButtonHW)];
        button.tag = 1000 + i;
        [_showView addSubview:button];
        
        [button addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    
    
    
}

//点击分享
- (void)shareClick:(UIButton *)button{
    
    if (button.tag == 1000) {
        //微信好友
        [self sendLinkContent:WXSceneSession];
        
    }else if(button.tag == 1001){
        //微信朋友圈
        [self sendLinkContent:WXSceneTimeline];
        
    }else if(button.tag == 1002){
        //微信收藏
        [self sendLinkContent:WXSceneFavorite];
        
    }
    
}

- (void)cancelClick:(UIButton *)button{
    
    _cancelButton.alpha = 0;
    _showView.alpha = 0;
    [self removeFromSuperview];
    
}

//发送链接
- (void)sendLinkContent:(int)scene;
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"专访张小龙：产品之上的世界观";
    message.description = @"微信的平台化发展方向是否真的会让这个原本简洁的产品变得臃肿？在国际化发展方向上，微信面临的问题真的是文化差异壁垒吗？腾讯高级副总裁、微信产品负责人张小龙给出了自己的回复。";
    [message setThumbImage:[UIImage imageNamed:@"res2.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

//动画效果
- (void)shareViewAnimation{
    
    //添加动画
    
    [UIView animateWithDuration:.35 delay:.35 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        
        _cancelButton.alpha = 1;
        _showView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

@end











