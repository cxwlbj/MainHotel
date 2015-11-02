//
//  DetailCentreView.m
//  MainHotel
//
//  Created by iMac on 15-10-11.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "DetailCentreView.h"

#define HotelLabelFont [UIFont systemFontOfSize:12]
#define HotelAdressFont [UIFont systemFontOfSize:11]
#define NormFont [UIFont systemFontOfSize:10]


@implementation DetailCentreView

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KBoutiqueHotelDetailRefesh object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
        
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(roomsDidSelect:) name:KBoutiqueHotelDetailRefesh object:nil];
    }
    return self;
}


- (void)setUpSubviews{
    
    //创建视图
    _hotelName = [[UILabel  alloc] initWithFrame:CGRectZero]; //酒店名称
    _hotelName.font = HotelLabelFont;
    [self addSubview:_hotelName];
    
    
    _hotelAdress = [[UILabel  alloc] initWithFrame:CGRectZero];//酒店地址
    _hotelAdress.font = HotelAdressFont;
    _hotelAdress.numberOfLines = 2;
    _hotelAdress.alpha = .7;
    [self addSubview:_hotelAdress];
    
    
    _telButton = [UIButton buttonWithType:UIButtonTypeCustom];//电话按钮
    [self addSubview:_telButton];
    [_telButton setImage:[UIImage imageNamed:@"icon_detail_contact~iphone"] forState:UIControlStateNormal];
    [_telButton addTarget:self action:@selector(telAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _roomChooseButton = [UIButton buttonWithType:UIButtonTypeCustom];//房型选择按钮
    [self addSubview:_roomChooseButton];
    [_roomChooseButton setImage:[UIImage imageNamed:@"icon_detail_room~iphone"] forState:UIControlStateNormal];
    _roomChooseButton.titleLabel.font = NormFont;
    [_roomChooseButton addTarget:self action:@selector(roomChoosection:) forControlEvents:UIControlEventTouchUpInside];
    
    _mapButton = [UIButton buttonWithType:UIButtonTypeCustom];//地图按钮
    [self addSubview:_mapButton];
    [_mapButton setImage:[UIImage imageNamed:@"icon_detail_navigation~iphone"] forState:UIControlStateNormal];
    _mapButton.titleLabel.font = NormFont;
    [_mapButton addTarget:self action:@selector(mapAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _hotelNearby = [UIButton buttonWithType:UIButtonTypeCustom];//酒店周边
    [self addSubview:_hotelNearby];
    [_hotelNearby setImage:[UIImage imageNamed:@"icon_around~iphone"] forState:UIControlStateNormal];
    _hotelNearby.titleLabel.font = NormFont;
    [_hotelNearby addTarget:self action:@selector(hotelNearbyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _roomLabel = [[UILabel  alloc] initWithFrame:CGRectZero];//房型label
    _roomLabel.font = NormFont;
    _roomLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_roomLabel];
    
    
    _mapLabel = [[UILabel  alloc] initWithFrame:CGRectZero];//房型label
    _mapLabel.textAlignment = NSTextAlignmentCenter;
    _mapLabel.font = NormFont;
    [self addSubview:_mapLabel];
    
    
    _nearbyLabel = [[UILabel  alloc] initWithFrame:CGRectZero];//房型label
    _nearbyLabel.font = NormFont;
    _nearbyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nearbyLabel];
    
    
    
    //定义frame
    
    CGFloat margin = 5;
    CGFloat hotelNameX = margin * 2;
    CGFloat hotelNameY = margin * 2;
    CGFloat hotelNameW = KIPHONEWidth * .8;
    CGFloat hotelNameH = 20;
    _hotelName.frame = CGRectMake(hotelNameX, hotelNameY, hotelNameW, hotelNameH);
    
    
    CGFloat hotelAdressX = _hotelName.left;
    CGFloat hotelAdressY = _hotelName.bottom;
    CGFloat hotelAdressW = KIPHONEWidth * .8;
    CGFloat hotelAdressH = 30;
    _hotelAdress.frame = CGRectMake(hotelAdressX, hotelAdressY, hotelAdressW, hotelAdressH);
    
    
    
    CGFloat telButtonY = margin * 2;
    CGFloat telButtonW = 30;
    CGFloat telButtonH = 30;
    CGFloat telButtonX = KIPHONEWidth - telButtonW - margin * 3;
    _telButton.frame = CGRectMake(telButtonX, telButtonY, telButtonW, telButtonH);
    
    
    CGFloat buttonWidth = 50;
    CGFloat buttonHeight = 50;
    CGFloat buttonMargin = (KIPHONEWidth - 3 * buttonWidth) / 4;
    
    CGFloat roomChooseButtonY = _hotelAdress.bottom + margin * 4;
    CGFloat roomChooseButtonW = buttonWidth;
    CGFloat roomChooseButtonH = buttonHeight;
    CGFloat roomChooseButtonX = buttonMargin;
    _roomChooseButton.frame = CGRectMake(roomChooseButtonX, roomChooseButtonY, roomChooseButtonW, roomChooseButtonH);
    
    
    CGFloat mapButtonX = _roomChooseButton.right + buttonMargin;
    CGFloat mapButtonY = _roomChooseButton.top;
    CGFloat mapButtonW = buttonWidth;
    CGFloat mapButtonH = buttonHeight;
    _mapButton.frame = CGRectMake(mapButtonX, mapButtonY, mapButtonW, mapButtonH);
    
    
    CGFloat hotelNearbyX = _mapButton.right + buttonMargin;
    CGFloat hotelNearbyY = _roomChooseButton.top;
    CGFloat hotelNearbyW = buttonWidth;
    CGFloat hotelNearbyH = buttonHeight;
    _hotelNearby.frame = CGRectMake(hotelNearbyX, hotelNearbyY, hotelNearbyW, hotelNearbyH);
    
    
    CGFloat labelH = 20;
    CGFloat labelW = 100;
    CGFloat roomLabelX = [self calculateOriginXWithWidth:labelW OtherFrame:_roomChooseButton.frame];
    CGFloat roomLabelY = _roomChooseButton.bottom + margin;
    CGFloat roomLabelW = labelW;
    CGFloat roomLabelH = labelH;
    _roomLabel.frame = CGRectMake(roomLabelX, roomLabelY, roomLabelW, roomLabelH);
    
    CGFloat mapLabelX = [self calculateOriginXWithWidth:labelW OtherFrame:_mapButton.frame];
    CGFloat mapLabelY = _roomLabel.top;
    CGFloat mapLabelW = labelW;
    CGFloat mapLabelH = labelH;
    _mapLabel.frame = CGRectMake(mapLabelX, mapLabelY, mapLabelW, mapLabelH);
    
    CGFloat nearbyLabelX = [self calculateOriginXWithWidth:labelW OtherFrame:_hotelNearby.frame];
    CGFloat nearbyLabelY = _roomLabel.top;
    CGFloat nearbyLabelW = labelW;
    CGFloat nearbyLabelH = labelH;
    _nearbyLabel.frame = CGRectMake(nearbyLabelX, nearbyLabelY, nearbyLabelW, nearbyLabelH);

}

//重写model的sett方法
- (void)setModel:(HotelDetailModel *)model{
    
    _model = model;
    
    //设置内容
    
    _hotelName.text = model.name; //酒店名称
    
    _hotelAdress.text = model.address;//酒店地址
    if (model.rooms.count > 0) {
        
        _roomLabel.text = [model.rooms[0] name];//房型label
    }else{
        _roomLabel.text = @" 暂 无 ";
    }
    
    _mapLabel.text = L(@"mapLocation");//房型label
    
    _nearbyLabel.text = L(@"hotelNearby");//房型label
    
    
}


//计算按钮下面文字的x值,根据按钮frame,效果为文字居中
- (CGFloat)calculateOriginXWithWidth:(CGFloat)width OtherFrame:(CGRect)frame{
    
    CGFloat distance = (width - frame.size.width) / 2;
    
    return frame.origin.x - distance;
    
}

#pragma mark -- button点击事件
//拨打电话
- (void)telAction:(UIButton *)button{
    
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@",self.model.phone] delegate:self cancelButtonTitle:L(@"cancelBtn") otherButtonTitles:L(@"confirmBtn"), nil];
    [alter show];
}

//房型选择
- (void)roomChoosection:(UIButton *)button{
    
    //1.视图控制器的视图后移
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7f, 0.7f);
    [UIView commitAnimations];
    
#warning 使用initWithFrame然后给宽和高,是为了让 房型视图中的 tableView进行初始化
    _roomDetailView = [[RoomDetailView alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth, XMargin)];
    _roomDetailView.model = self.model; //赋值得到视图高度
    //2.遮盖视图
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth, KIPHONEHeight - _roomDetailView.viewHeight)];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.alpha = .3f;
    [self.window addSubview:_maskView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [_maskView addGestureRecognizer:tap];
    
    //3.显示房型视图
    _roomDetailView.frame = CGRectMake(0, KIPHONEHeight - _roomDetailView.viewHeight, KIPHONEWidth, _roomDetailView.viewHeight);
    [self.window addSubview:_roomDetailView];
    
    
}

//地图点击
- (void)mapAction:(UIButton *)button{
    NSLog(@"mapAction");
}

//酒店周边
- (void)hotelNearbyAction:(UIButton *)button{
    NSLog(@"hotelNearbyAction");
}

//mask图点击
- (void)tapView:(UITapGestureRecognizer *)tap{
    
    //1.移除mask图
    [_maskView removeFromSuperview];
    _maskView = nil;
    
    //2.移除房型视图
    [_roomDetailView removeFromSuperview];
    _roomDetailView = nil;
    
    //3.控制器视图还原
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.viewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
    [UIView commitAnimations];
    
}

#pragma mark -- alter代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.phone]]];
    }
    
    //sms 短信
    //mailto 邮件
    //http 网址
}

#pragma mark --通知的方法
- (void)roomsDidSelect:(NSNotification *)notificaiton{
    //还原视图效果
    [self tapView:nil];
    //刷新房型按钮和价格按钮(控制器中)
    NSInteger roomNum = [[notificaiton.userInfo objectForKey:KRoomsDidSelectNumber] integerValue];
    RoomsModel *model = self.model.rooms[roomNum];
    _roomLabel.text = model.name;
}


@end
