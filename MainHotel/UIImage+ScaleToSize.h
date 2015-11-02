//
//  UIImage+ScaleToSize.h
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScaleToSize)
//修改图片的尺寸
+ (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size;

@end
