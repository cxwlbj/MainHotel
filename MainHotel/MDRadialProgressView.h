//
//  MDRadialProgressView.h
//  MDRadialProgress
//
//  Created by Marco Dinacci on 25/03/2013.
//  Copyright (c) 2013 Marco Dinacci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDRadialProgressView : UIView
//圆划分成总共多少份(注:需要为整数)
@property (assign, nonatomic) NSUInteger progressTotal;
//当前所占的份数 相对于progressTotal(注:需要为整数)
//和progressValue分开,为了让视图(按照模块)和百分比进度(浮点)加载更明显
@property (assign, nonatomic) NSUInteger progressCurrent;
//进度条完成的颜色
@property (strong, nonatomic) UIColor *completedColor;
//进度条显示的颜色
@property (strong, nonatomic) UIColor *incompletedColor;
//进度条宽度
@property (assign, nonatomic) CGFloat thickness;
//模块之间空隙的颜色
@property (strong, nonatomic) UIColor *sliceDividerColor;
//是否将圆切成等份模块显示(NO为分模块)
@property (assign, nonatomic) BOOL sliceDividerHidden;
//等份模块间隙的大小
@property (assign, nonatomic) NSUInteger sliceDividerThickness;
//百分比加载的值(以100为基数)
@property (nonatomic,assign) float progressValue;
//百分比加载的颜色
@property (strong, nonatomic) UIColor *progressValueColor;

//类方法创建视图
+ (instancetype)mdRadialProgressViewCreate;

@end
