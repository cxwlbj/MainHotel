//
//  SvGifView.h
//  MainHotel
//
//  Created by iMac on 15-10-9.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SvGifView : UIView

/*
 
 * @brief desingated initializer
 
 */

- (id)initWithCenter:(CGPoint)center fileURL:(NSURL*)fileURL;
/*
 
 * @brief start Gif Animation
 
 */

- (void)startGif;
/*
 
 * @brief stop Gif Animation
 
 */

- (void)stopGif;
/*
 
 * @brief get frames image(CGImageRef) in Gif
 
 */

+ (NSArray*)framesInGif:(NSURL*)fileURL;


@end
