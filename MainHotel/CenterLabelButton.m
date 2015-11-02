//
//  CenterLabelButton.m
//  MainHotel
//
//  Created by iMac on 15-10-15.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "CenterLabelButton.h"

@implementation CenterLabelButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.font = [UIFont systemFontOfSize:9];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 5;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
}



@end
