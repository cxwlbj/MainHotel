//
//  ImageShowViewController.h
//  MovieXP
//
//  Created by iMac on 15-8-25.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"
#import "HotelDetailModel.h"

/**
 *  图片模态显示
 */
@interface ImageShowViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    UICollectionView *_showCollectionView;
    
    
}

//@property (nonatomic,copy) NSString *imageURL;

//接收模型数据
@property (nonatomic,strong) NSArray *dataList;

//接收目前是第几个图片
@property (nonatomic,assign) NSInteger index;


@end
