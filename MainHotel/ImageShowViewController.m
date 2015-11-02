//
//  ImageShowViewController.m
//  MovieXP
//
//  Created by iMac on 15-8-25.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "ImageShowViewController.h"
#import "ImageShowCell.h"

#define ImageShowCellId @"imageShowCellId"

@interface ImageShowViewController ()

@end

@implementation ImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self _initMainviews];
    
    //取消填充效果
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //显示当前位置
    _showCollectionView.contentOffset = CGPointMake((KIPHONEWidth + 10) * self.index, 0);
    
    
}

- (void)_initMainviews{
    
    
    // 1.设置标题
    self.title = @"图片详情";
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    
    //图片显示collectionView (注意相册需要添加5左右的)
    //1.创建layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(KIPHONEWidth + 10, KIPHONEHeight);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //2.创建collectionView
    _showCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-5, 0, KIPHONEWidth + 10, KIPHONEHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:_showCollectionView];
    _showCollectionView.showsHorizontalScrollIndicator = NO;
    //注册cell
    [_showCollectionView registerClass:[ImageShowCell class] forCellWithReuseIdentifier:ImageShowCellId];
    
    //数据源和代理
    _showCollectionView.delegate = self;
    _showCollectionView.dataSource = self;
    
    _showCollectionView.pagingEnabled = YES;
    
    //添加点击事件(点击隐藏状态栏)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    
    [_showCollectionView addGestureRecognizer:tap];
    
    
    
}

#pragma  mark -- 点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark--数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageShowCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:ImageShowCellId forIndexPath:indexPath];
    
    cell.imageUrl = self.dataList[indexPath.item];
    cell.backgroundColor = [UIColor clearColor];
    //手动刷新
    [cell setNeedsLayout];
    
    return cell;
    
    
}

#pragma mark--UICollectionView的代理方法
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //因为scrollView覆盖了视图, 点击cell事件被scrollView截获 无法使用
    
}


#pragma mark--UIScrollView的代理方法






@end
