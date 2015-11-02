//
//  ThreeKilometersModel.h
//  MainHotel
//
//  Created by iMac on 15-10-12.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseModel.h"

@interface ThreeKilometersModel : BaseModel

    
@property (nonatomic , strong) NSNumber *ThreeKid;

@property (nonatomic , strong) NSNumber *type;

@property (nonatomic , strong) NSNumber *hotel_id;

@property (nonatomic , strong) NSNumber *city_id;

@property (nonatomic , copy) NSString *name;

@property (nonatomic , strong) NSNumber *phone;

@property (nonatomic , strong) NSNumber *averagePrice;

@property (nonatomic , copy) NSString *images;

@property (nonatomic , copy) NSString *style;

@property (nonatomic , copy) NSString *opening_hours;

@property (nonatomic , copy) NSString *district;

@property (nonatomic , copy) NSString *street;

@property (nonatomic , copy) NSString *address;

@property (nonatomic , strong) NSNumber *longitude;

@property (nonatomic , strong) NSNumber *latitude;

@property (nonatomic , copy) NSString *feature;

@property (nonatomic , copy) NSString *menu;

@property (nonatomic , strong) NSNumber *hot;

@property (nonatomic , strong) NSNumber *status;

@property (nonatomic , copy) NSString *update_date;

@property (nonatomic , strong) NSNumber *_id;



@end


/*
    feature = 民族历史文化发展成果的聚积地;
	hotel_id = 0;
	style = 景点;
	city_id = 29;
	district = 青羊区;
	status = 1;
	opening_hours = 9:00-17:00;
	averagePrice = 0;
	street = 浣花南路251;
	_id = 442;
	images = http://121.40.95.51:4000/public/store/chengdu/bwg.jpg;
	latitude = 30.6599;
	hot = 0;
	menuIcon = http://api.meetboutiquehotels.com/public/images/app/icon_around_menu.png;
	name = 四川省博物馆;
	menu = <null>;
	type = 3;
	id = 442;
	longitude = 104.034;
	phone = 028-65521888;
	menuTitle = 倾心之选;
	address = ;
	update_date = 2015-10-01T06:17:50.000Z;
 
 */