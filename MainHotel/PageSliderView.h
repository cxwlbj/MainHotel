//
//  PageSliderView.h
//  MainHotel
//
//  Created by iMac on 15-10-11.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HotelDetailModel.h"


/**
 *  分页滚动视图
 */
@interface PageSliderView : UIView<UIScrollViewDelegate>{
    
    UIScrollView *_scrollViewMain;//主要视图
    UIScrollView *_scrollViewPage;//分页栏
    
    UIImageView *_pageImage;//红色分页条
    
    UIButton *_firstButton; //第一页视图
    UIButton *_secondButton; //第二页视图
    UIButton *_threeButton; //第三页视图
    
    UIView *_firstView;
    UIView *_secondView;
    UIView *_threeView;
    
}

//视图高度
@property (nonatomic,assign) CGFloat viewHeight;

@property (nonatomic,strong) HotelDetailModel *model;

@end
