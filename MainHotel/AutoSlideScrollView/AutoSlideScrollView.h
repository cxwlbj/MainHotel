//
//  AutoSlideScrollView.h
//  AutoSlideScrollViewDemo
//
//  Created by Mike Chen on 14-1-23.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoSlideScrollView;
@protocol AutoSlideScrollViewDelegate <NSObject>

@optional
/**
 点中页面时执行
 */
- (void)autoSlideScrollViewDidSelectPageNum:(AutoSlideScrollView *)autoSlideScrollView pageIndex:(NSInteger)pageIndex;

@end

@interface AutoSlideScrollView : UIView

@property (nonatomic , readonly) UIScrollView *scrollView;
/**
 *  初始化
 *
 *  @param frame             frame
 *  @param animationDuration 自动滚动的间隔时长。如果<=0，不自动滚动。
 *
 *  @return instance
 */
- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;

/**
 数据源：获取总的page个数，如果少于2个，不自动滚动
 **/
@property (nonatomic , copy) NSInteger (^totalPagesCount)(void);

/**
 数据源：获取第pageIndex个位置的contentView
 **/
@property (nonatomic , copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);

/**
 当点击的时候，执行的block,返回点击页index
 **/
@property (nonatomic , copy) void (^TapActionBlock)(NSInteger pageIndex);

/**
 *  代理属性
 */
@property (nonatomic , weak) id<AutoSlideScrollViewDelegate> delegate;

@end


