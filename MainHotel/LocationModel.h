//
//  LocationModel.h
//  MainHotel
//
//  Created by iMac on 15-10-8.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseModel.h"

@interface LocationModel : BaseModel


/*
 citylist = (
 {
 cityID = 38;
 code = aj;
 name_en = Anji;
 name = 安吉/湖州;
 }
 */


@property (nonatomic,strong) NSNumber *cityID;
@property (nonatomic,copy) NSString *code;
@property (nonatomic,copy) NSString *name_en;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *key;


@end
