//
//  UIView+ViewController.h
//  UIKit_触摸手势
//
//  Created by iMac on 15-8-17.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewController)
/**
 *  通过view 的事件响应链 获取该视图的视图控制器
 *
 *  @return UIViewController
 */
- (UIViewController *)viewController;

@end
