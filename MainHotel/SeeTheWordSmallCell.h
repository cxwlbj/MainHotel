//
//  SeeTheWordSmallCell.h
//  MainHotel
//
//  Created by iMac on 15-10-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeeTheWordModel.h"

@interface SeeTheWordSmallCell : UITableViewCell{
    
    UIImageView *_imageShow;
    
    UILabel *_title;
    
    UILabel *_textDetail;
    
    UIButton *_collectView;
    
    UIButton *_seeView;
    
}


@property (nonatomic, strong) SeeTheWordModel *model;


@end




