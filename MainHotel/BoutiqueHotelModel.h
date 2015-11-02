//
//  BoutiqueHotelModel.h
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseModel.h"

/**
 
 {
 "_id": 300,
 "elong_id": 2301375,
 "name": "成都果然24房酒店",
 "rooms_avail": 2,
 "longitude": 104.12111664,
 "latitude": 30.66862488,
 "level": 0,
 "images": "http://121.40.95.51:4000/public/images/chengdu/cdgr04.jpg",
 "address": "成华区建设南支路4号(成都东区音乐公园内)",
 "weekdayPrice": null,
 "weekendPrice": null,
 "tag": "",
 "rooms": [
 {
 "name": "达人套房A",
 "desc": "大床1.5米、2-3楼、30-40平米、免费WIFI、可入住2人",
 "bedName": "大床1.5米",
 "averageRate": 428,
 "totalRate": 428,
 "roomTypeId": "0001",
 "ratePlanId": 199768,
 "ValueAddIds": "",
 "needGuarantee": 0,
 "bedType": "1"
 },
 {
 "name": "特色套房B",
 "desc": "大床1.5米、2-3楼、40-60平米、免费WIFI、可入住2人",
 "bedName": "大床1.5米",
 "averageRate": 448,
 "totalRate": 448,
 "roomTypeId": "0002",
 "ratePlanId": 199768,
 "ValueAddIds": "",
 "needGuarantee": 0,
 "bedType": "1"
 }
 ],
 "price": 428
 },
 
 */

@interface BoutiqueHotelModel : BaseModel

@property (nonatomic,strong) NSNumber *_id ;
@property (nonatomic,strong) NSNumber * elong_id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSNumber * rooms_avail;
@property (nonatomic,strong) NSNumber * longitude;
@property (nonatomic,strong) NSNumber * latitude;
@property (nonatomic,copy) NSString * level;
@property (nonatomic,copy) NSString *images;

@property (nonatomic,copy) NSString *address;
@property (nonatomic,strong) NSNumber * weekdayPrice;
@property (nonatomic,strong) NSNumber * weekendPrice;
@property (nonatomic,copy) NSString *tag;
@property (nonatomic,strong) NSArray *rooms;
@property (nonatomic,strong) NSNumber * price;



@end
