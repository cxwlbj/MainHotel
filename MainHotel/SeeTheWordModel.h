//
//  SeeTheWordModel.h
//  MainHotel
//
//  Created by iMac on 15-10-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseModel.h"

@interface SeeTheWordModel : BaseModel

@property (nonatomic, strong) NSNumber *_id;
@property (nonatomic,  copy ) NSString *title;
@property (nonatomic,  copy ) NSString *describe;
@property (nonatomic, strong) NSNumber *likes;
@property (nonatomic, strong) NSNumber *views;
@property (nonatomic,  copy ) NSString *img_url;
@property (nonatomic,  copy ) NSString *content_url;
@property (nonatomic, strong) NSNumber *recommend;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic,  copy ) NSString *partner_name;
@property (nonatomic, strong) NSNumber *islike;



@end


/*
 {
 "_id": 283,
 "title": "这个秋天，去看美不胜收的日本红枫（附全日本最佳赏枫时刻表）",
 "describe": "看到时间表，大家应该知道了吧，现在去日本从北海道到四国，都是赏枫的最佳时节，还不快点备签，来一次说走就走的“赏枫之旅”。",
 "likes": 10,
 "views": 2142,
 "img_url": "http://api.meetboutiquehotels.com/public/article/resource/images/201510/101303/15.jpeg",
 "content_url": "http://api.meetboutiquehotels.com/public/article/html/201510/101304.html",
 "recommend": 1,
 "type": 1,
 "partner_name": "MeetBoutique",
 "islike": 0
 },
 */