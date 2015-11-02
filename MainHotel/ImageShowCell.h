//
//  ImageShowCell.h
//  MovieXP
//
//  Created by iMac on 15-8-26.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageShowCell : UICollectionViewCell<UIScrollViewDelegate>{
    
    UIScrollView *_showScroll;
    
    UIImageView *_showImage;
}

@property (nonatomic,copy) NSString *imageUrl;

@end
