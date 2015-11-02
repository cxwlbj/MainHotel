//
//  ItemView.m
//  MovieXP
//
//  Created by iMac on 15-8-18.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "ItemButton.h"

@implementation ItemButton


//重写父类的init方法创建视图里的内容

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        //1.创建itemView中的图片
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake((44-25)/2,XMargin,25,25);
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        [self addSubview:_imageView];
        
        //2.创建itemView中的label
        _labelView = [[UILabel alloc] init];
        _labelView.frame = CGRectMake(0,_imageView.bottom+XMargin, 44, 8);
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.font = [UIFont systemFontOfSize:9];
        _labelView.textColor = [UIColor whiteColor];
        [self addSubview:_labelView];
        
        
    }
    return self;
}



@end
