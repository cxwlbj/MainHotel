//
//  ShareView.h
//  MainHotel
//
//  Created by iMac on 15-10-15.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CenterLabelButton.h"
#import "WXApiObject.h"

@interface ShareView : UIView{
    UIView *_maskView;//遮盖图层
    UIView *_showView;//展示图层
    
    UIButton *_cancelButton; //取消按钮
    
    
}

//初始化方法
- (instancetype)initWithView:(UIView *)view;

- (void)shareViewAnimation;

@end
