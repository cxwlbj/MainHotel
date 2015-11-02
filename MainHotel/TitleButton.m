//
//  TitleButton.m
//  MainHotel
//
//  Created by iMac on 15-10-8.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "TitleButton.h"

@implementation TitleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //self.adjustsImageWhenHighlighted = NO;
        
        self.titleLabel.font = XNameFont;
        
        UIImage *ImageOrigin = [UIImage imageNamed:@"icon_arrow_down~iphone.png"];
        
        [self setImage:ImageOrigin forState:UIControlStateNormal];
        
        //[self setBackgroundImage:[UIImage resizableWithImageName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.left = self.imageView.left;
    self.imageView.left = CGRectGetMaxX(self.titleLabel.frame);
    
}

- (void)setFrame:(CGRect)frame
{
    frame.size.width += 2;
    [super setFrame:frame];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    [self sizeToFit];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 自动算好尺寸
    [self sizeToFit];
}




@end



