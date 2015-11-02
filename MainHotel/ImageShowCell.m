//
//  ImageShowCell.m
//  MovieXP
//
//  Created by iMac on 15-8-26.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "ImageShowCell.h"

@implementation ImageShowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        _showScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth + 10, KIPHONEHeight-64)];
        [self.contentView addSubview:_showScroll];
        
        _showScroll.delegate = self;
        
        //设置最小缩放
        _showScroll.minimumZoomScale = 1.0;
        //设置最大缩放
        _showScroll.maximumZoomScale = 1.5;
        
        _showImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, KIPHONEWidth, KIPHONEHeight-64)];
        _showImage.contentMode = UIViewContentModeScaleAspectFit;
        [_showScroll addSubview:_showImage];
        
        _showImage.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _showScroll.zoomScale = 1.0;
    
    [_showImage sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return _showImage;
}

@end
