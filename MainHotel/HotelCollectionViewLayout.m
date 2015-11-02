//
//  HotelCollectionViewLayout.m
//  MainHotel
//
//  Created by iMac on 15-10-19.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "HotelCollectionViewLayout.h"


#define ACTIVE_DISTANCE 300
#define ZOOM_FACTOR 0.2

@implementation HotelCollectionViewLayout


- (instancetype)init {
    
    self = [super init];
    
    if (self != nil) {
        //定义布局
        self.minimumLineSpacing = 0;
        
        //横向滚动
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return self;
}


//当bounds发生变化时，是否继续布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
    
}


//返回一个目标偏移量（最终停留的位置）
#warning collectionView的layout的居中效果
- (CGPoint)targetContentOffsetForProposedContentOffset: (CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    //proposedContentOffset是没有对齐到网格时本来应该停下的位置
    
    CGFloat offsetAdjustment = MAXFLOAT;
    
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    //对当前屏幕中的UICollectionViewLayoutAttributes逐个与屏幕中心进行比较，找出最接近中心的一个
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array)
    {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment))
        {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}


//3D效果

#warning collectionView的layout 3D效果 ZOOM_FACTOR是指放大的倍数 0.2指原来基础上再放大 0.2 就是1.2

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect;
    
    visibleRect.origin = self.collectionView.contentOffset;
    
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array)
    {
        if (CGRectIntersectsRect(attributes.frame, rect))
        {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            
            if (ABS(distance) < ACTIVE_DISTANCE){
                
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
                
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                
                attributes.zIndex = 1;
            }
        }
    }
    return array;
}





@end
