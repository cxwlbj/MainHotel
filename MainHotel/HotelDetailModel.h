//
//  HotelDetailModel.h
//  MainHotel
//
//  Created by iMac on 15-10-10.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseModel.h"


@interface HotelDetailModel : BaseModel

@property (nonatomic,strong) NSNumber *_id;
@property (nonatomic,strong) NSNumber *elong_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSNumber *rooms_avail;
@property (nonatomic,strong) NSNumber *longitude;
@property (nonatomic,strong) NSNumber *latitude;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,strong) NSArray *whylike;
@property (nonatomic,strong) NSArray *features;
@property (nonatomic,copy) NSString *container;
@property (nonatomic,strong) NSNumber *phone;
@property (nonatomic,strong) NSArray *rooms;
@property (nonatomic,strong) NSNumber *price;


@end



/**
 *  "_id": 26,
 "elong_id": 40101846,
 "name": "北京一驿艺术酒店(798园区)(原格瑞斯北京)",
 "rooms_avail": 2,
 "longitude": 116.50018311,
 "latitude": 39.98748398,
 "images": [
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_05.jpg",
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_02.jpg",
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_03.jpg",
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_04.jpg",
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_01.jpg",
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_06.jpg",
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_07.jpg",
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_08.jpg",
 "http://121.40.95.51:4000/public/images/beijing/GLSBJ_09.jpg"
 ],
 "address": "朝阳区酒仙桥北路798艺术区2号院(北京电机总厂对面)",
 "whylike": [
 "位于798艺术区内，艺术气息浓厚，远离市中心，环境安静",
 "酒店装修以后现代风格为主，大堂音乐与整体风格很协调，电梯走廊内处处有艺术品，细心观察还有许多小的惊喜",
 "酒店带有露天长廊，方便享受阳光，餐吧提供的食物以西式餐品为主，值得推荐"
 ],
 "features": [
 "ft_wifi",
 "ft_gym",
 "ft_meal"
 ],
 "container": "日常服务以酒店提供为准",
 "phone": "010-64361818",
 "rooms": [
 {
 "name": "艺术单人房【含早餐】",
 "desc": "大床1.5米、2楼、20平米、免费WIFI、可入住2人",
 "bedName": "大床1.5米",
 "averageRate": 765,
 "totalRate": 765,
 "roomTypeId": "0012",
 "ratePlanId": 126735,
 "ValueAddIds": "41778_01_126735",
 "needGuarantee": 1,
 "bedType": "1"
 },
 {
 "name": "豪华间【含早餐】",
 "desc": "大/双床、2-3楼、55平米、免费WIFI、可入住2人",
 "bedName": "大/双床",
 "averageRate": 1006,
 "totalRate": 1006,
 "roomTypeId": "0011",
 "ratePlanId": 361287,
 "ValueAddIds": "41778_05_361287,41778_01_361287",
 "needGuarantee": 1,
 "bedType": "1"
 }
 ],
 "price": 765
 */