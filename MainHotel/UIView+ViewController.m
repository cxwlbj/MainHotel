//
//  UIView+ViewController.m
//  UIKit_触摸手势
//
//  Created by iMac on 15-8-17.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

- (UIViewController *)viewController{
    //获取当前对象的下一个响应者
    UIResponder *nextRes = self.nextResponder;
    //判读循环查找nextResponder,当nextRes为视图控制器或者为nil停止循环.
    while (![nextRes isKindOfClass:[UIViewController class]] && nextRes != nil) {
        nextRes = nextRes.nextResponder;
    }
    return (UIViewController *)nextRes;
}

@end
