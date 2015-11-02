//
//  BoutiqueHotelDetailVC.m
//  MainHotel
//
//  Created by iMac on 15-10-9.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BoutiqueHotelDetailVC.h"

#define NavButtonHW 30

#define ImageShowHeight 220
#define CentreViewHeight 180
#define BottomButtonHeight 40

@interface BoutiqueHotelDetailVC ()


@end

@implementation BoutiqueHotelDetailVC


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KBoutiqueHotelDetailRefesh object:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roomsDidSelect:) name:KBoutiqueHotelDetailRefesh object:nil];
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initMainView];
    
    [self requestDetailData];
}

- (void)initMainView{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.UIScrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.frame = self.view.bounds;
    
    [self.view addSubview:_scrollView];
    
    //2.头部创建一个占位图片
    _placeholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth, ImageShowHeight)];
    [_scrollView addSubview:_placeholderView];
    
    //3.导航图标
    UIButton *navButton = [[UIButton alloc] initWithFrame:CGRectZero];
    navButton.frame = CGRectMake(XMargin*2, XMargin*5, NavButtonHW, NavButtonHW);
    [navButton setImage:[UIImage imageNamed:@"btn_back~iphone"] forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    
    
    //4.创建中间部分视图
    _detailCentreView = [[DetailCentreView alloc] initWithFrame:CGRectMake(0, _placeholderView.bottom, KIPHONEWidth, CentreViewHeight)];
    [_scrollView addSubview:_detailCentreView];
    
    
    //5.创建分页滑动视图
    _pageSliderView = [[PageSliderView alloc] initWithFrame:CGRectMake(0, _detailCentreView.bottom, KIPHONEWidth, 100)];
    [_scrollView addSubview:_pageSliderView];
    
    //6.创建价格和预定按钮
    _priceButton = [UIButton buttonWithType:UIButtonTypeCustom];//价格按钮
    _bookingButton = [UIButton buttonWithType:UIButtonTypeCustom];//预订按钮
    
    CGFloat btnH = BottomButtonHeight;
    CGFloat btnW = KIPHONEWidth / 2;
    CGFloat btnY = KIPHONEHeight - btnH;
    _priceButton.frame = CGRectMake(0, btnY, btnW, btnH);
    _bookingButton.frame = CGRectMake(btnW, btnY, btnW, btnH);
    
    [_priceButton setBackgroundColor:[UIColor blackColor]];
    [_priceButton setTitle:@"￥ 0 / 晚" forState:UIControlStateNormal];
    [_bookingButton setBackgroundColor:[UIColor redColor]];
    [_bookingButton setTitle:@"立即预定" forState:UIControlStateNormal];
    [_bookingButton addTarget:self action:@selector(bookingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_priceButton];
    [self.view addSubview:_bookingButton];
    
    //导航返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
}

//创建图片循环展示视图
- (void)showImagesView{
    
    NSMutableArray *viewsArray = [NSMutableArray array];
    NSArray *dataArr = _model.images;
    for (NSString *imageStr in dataArr) {
        UIImageView *imageShow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth, ImageShowHeight)];
        [imageShow sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@""]];
        [viewsArray addObject:imageShow];
    }
    
    _autoSlideScrollView = [[AutoSlideScrollView alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth, ImageShowHeight) animationDuration:2];
    
    _autoSlideScrollView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };
    _autoSlideScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
        return viewsArray[pageIndex];
    };
    
    _autoSlideScrollView.delegate = self;
    
//    _autoSlideScrollView.TapActionBlock = ^(NSInteger pageIndex){
//        block中不适用self 出现循环强引用
//    };
    
    //取代占位视图
    [_placeholderView removeFromSuperview];
    _placeholderView = nil;
    [_scrollView addSubview:_autoSlideScrollView];
    
}

//刷新视图,请求完数据之后进行
- (void)refreshMainView{
    
    //刷新视图数据
    
    //1.创建图片循环展示视图
    [self showImagesView];
    
    //2.详情视图
    _detailCentreView.model = _model;
    
    //3.分页视图
    _pageSliderView.model = _model;
    _pageSliderView.height = _pageSliderView.viewHeight;//重新设置高度
    
    //开启滑动视图
    _scrollView.contentSize = CGSizeMake(0, _pageSliderView.bottom + BottomButtonHeight);
    
    //4.价格标签和预订按钮
    NSString *average = nil;
    if (_model.rooms.count > 0) {
        average = [NSString stringWithFormat:@"￥ %@ / 晚",[_model.rooms[0] averageRate]];
    }else{
        average = @" 暂 无 ";
    }
    [_priceButton setTitle:average forState:UIControlStateNormal];
    
}

#pragma mark --数据请求
- (void)requestDetailData{
    
    [self hudProgressLoading];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.checkIn forKey:@"checkin"];
    [params setObject:self.checkOut forKey:@"checkout"];
    [params setObject:self.hotelID forKey:@"hotelID"];
    
    NSMutableDictionary *headerDict = [NSMutableDictionary dictionary];
    [headerDict setObject:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    
    [DataService requestAFWithURL:KHotelDeatilData params:params requestHeader:headerDict httpMethod:@"POST" block:^(id result, NSError *error) {
        //NSLog(@"%@",result);
        
        NSDictionary *resultDict = result;
        _model = [[HotelDetailModel alloc] initWithContent:resultDict];
        //封装rooms
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in _model.rooms) {
            RoomsModel *roomModel = [[RoomsModel alloc] initWithContent:dict];
            [tempArr addObject:roomModel];
        }
        _model.rooms = tempArr;
        //刷新视图
        [self refreshMainView];
        
    }];
    //隐藏视图
    [_HUD hide:YES];
    
}

//加载进度
- (void)hudProgressLoading{
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
    _HUD.labelText = @"加载中";
    [_HUD show:YES];
    
    
}

#pragma mark -- 按钮点击事件
//导航按钮点击事件
- (void)navBtnClick:(UIButton *)btn{
    
    //返回按钮
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)bookingAction:(UIButton *)button{
    NSLog(@"立即预订");
    
}

#pragma mark -- 通知事件
- (void)roomsDidSelect:(NSNotification *)notification{
    //刷新价格按钮
    NSInteger roomNum = [[notification.userInfo objectForKey:KRoomsDidSelectNumber] integerValue];
    NSString *average = [NSString stringWithFormat:@"￥ %@ / 晚",[_model.rooms[roomNum] averageRate]];
    [_priceButton setTitle:average forState:UIControlStateNormal];
    
}

#pragma mark --  AutoSlideScrollViewDelegate代理方法
- (void)autoSlideScrollViewDidSelectPageNum:(AutoSlideScrollView *)autoSlideScrollView pageIndex:(NSInteger)pageIndex{
    //图片点击后进行跳转进入
    ImageShowViewController *imageVC = [[ImageShowViewController alloc] init];
    imageVC.dataList = _model.images;//相册数据
    imageVC.index = pageIndex;//被点击的相片index
    [self.navigationController pushViewController:imageVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
