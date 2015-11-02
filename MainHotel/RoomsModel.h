//
//  RoomsModel.h
//  MainHotel
//
//  Created by iMac on 15-10-6.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseModel.h"

/**
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
 */

@interface RoomsModel : BaseModel

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *desc;
@property (nonatomic,copy) NSString *bedName;
@property (nonatomic,strong) NSNumber * averageRate;
@property (nonatomic,strong) NSNumber * totalRate;
@property (nonatomic,strong) NSNumber * roomTypeId;
@property (nonatomic,strong) NSNumber * ratePlanId;
@property (nonatomic,copy) NSString *ValueAddIds;
@property (nonatomic,copy) NSString * needGuarantee;
@property (nonatomic,strong) NSNumber * bedType;

@end
