//
//  XpGestureView.h
//  Gesture
//
//  Created by iMac on 15-10-16.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GestureView;

@protocol GestureViewDelegate <NSObject>

@optional

- (void)gestureView:(GestureView *)gestureView didSelectPassword:(NSString *)password;

@end

@interface GestureView : UIView


@property (nonatomic,  weak ) id<GestureViewDelegate> delegate;

@end
