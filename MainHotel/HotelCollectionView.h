//
//  HotelCollectionView.h
//  MainHotel
//
//  Created by iMac on 15-10-19.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelCollectionViewCell.h"
#import "HotelCollectionViewLayout.h"


@interface HotelCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, assign) NSInteger currentIndex; //当前停留的页面

//必须设置值
@property (nonatomic,assign) CGFloat layoutItemWidth; //layout的item宽度

@end
