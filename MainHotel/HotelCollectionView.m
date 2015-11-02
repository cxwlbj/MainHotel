//
//  HotelCollectionView.m
//  MainHotel
//
//  Created by iMac on 15-10-19.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "HotelCollectionView.h"

#define KHotelCollectionViewCell @"KHotelCollectionViewCell"

@implementation HotelCollectionView


//- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
//    
//    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
//        
//        // CollectionView自己作为代理
//        self.dataSource = self;
//        self.delegate = self;
//        
//        // 滚动条的样式
//        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
//        
//        // 减速的速率
//        self.decelerationRate = UIScrollViewDecelerationRateFast;
//        //设置注册单元格
//        [self registerClass:[HotelCollectionViewCell class] forCellWithReuseIdentifier:KHotelCollectionViewCell];
//        
//    }
//    
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame{
    
    // 1.创建单元格的布局对象
    HotelCollectionViewLayout *flowLayout = [[HotelCollectionViewLayout alloc] init];
    // 设置单元格的大小 (代理方法中设置)
    //flowLayout.itemSize = CGSizeMake(frame.size.width * .85, frame.size.height * .85);
    // 设置单元格之前的间距
    //flowLayout.minimumInteritemSpacing = 0;
    //flowLayout.minimumLineSpacing = 10;
    // 设置滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 2.通过父类创建对象
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        // 设置代理对象，加载单元格
        self.delegate = self;
        self.dataSource = self;
        // 设置当前视图的注册单元格类
        [self registerClass:[HotelCollectionViewCell class] forCellWithReuseIdentifier:KHotelCollectionViewCell];
    }
    
    return self;
}


#pragma mark -- 数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HotelCollectionViewCell *hotelCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:KHotelCollectionViewCell forIndexPath:indexPath];
    
    hotelCollectionCell.model  = self.dataList[indexPath.item];

    [hotelCollectionCell setNeedsLayout];
    
    return hotelCollectionCell;
    
}

#pragma mark -- UICollectionViewDelegate代理方法

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //如果点击的是中间的视图,点击视图进行翻转,如果是两边的视图,移动到终点
    if (self.currentIndex == indexPath.item) {
        
        //根据collectionView拿到单元格
        HotelCollectionViewCell * cell = (HotelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //单元格的翻转方法
        [cell flipCell];
    }else{
        //进行平移
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        //记录翻转后的位置
        self.currentIndex = indexPath.item;
    }
    
    //__weak __typeof(self)weakSelf = self;
    
}
//cell消失后调用
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HotelCollectionViewCell *endCell = (HotelCollectionViewCell *)cell;
    
    if(endCell.isDetail == YES){
        [endCell flipCell];
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout代理方法(也可以用self.contentInset 进行内填充)
//初始偏移量
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, (KIPHONEWidth - self.layoutItemWidth) / 2.0, 0, (KIPHONEWidth - self.layoutItemWidth) /2.0);
}

#pragma mark -- UICollectionViewDelegateFlowLayout代理方法
//定义每个item的大小(初始化bodyView的时候给的itemWidth)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.layoutItemWidth, self.height);
}

#pragma mark --UIScrollView代理方法

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity //速率(x轴,y轴)
              targetContentOffset:(inout CGPoint *)targetContentOffset //目标偏移量(x轴,y轴)
{
    
    
    
    //计算collectionView的页数时 是 targetContentOffset->x(偏振x轴) 除以 layout item的宽度,非collectionView的width
    
    CGFloat offX = targetContentOffset->x;
    
    NSInteger index; //定义页数
    
    if (offX < (self.layoutItemWidth / 2)) {
        index = 0;
    }else{
        
        index = (offX - (self.layoutItemWidth / 2)) / self.layoutItemWidth + 1;
    }
    
    self.currentIndex = index;
    
    //    NSLog(@"%.2f",targetContentOffset->x);
    //    NSLog(@"当前在第%ld",self.currentIndex);
    
}




@end










