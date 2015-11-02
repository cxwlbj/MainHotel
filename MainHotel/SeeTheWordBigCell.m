//
//  SeeTheWordBigCell.m
//  MainHotel
//
//  Created by iMac on 15-10-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "SeeTheWordBigCell.h"

#define KTitleFont 14
#define KDetailFont 12

@implementation SeeTheWordBigCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    
    _imageShow = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageShow];
    _imageShow.userInteractionEnabled = YES;
    
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_title];
    _title.font = [UIFont systemFontOfSize:KTitleFont];
    _title.numberOfLines = 0;
    _title.textColor = [UIColor whiteColor];
    
    _textDetail = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_textDetail];
    _textDetail.font = [UIFont systemFontOfSize:KDetailFont];
    _textDetail.numberOfLines = 0;
    _textDetail.textColor = [UIColor whiteColor];
    
    _collectView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_collectView];
    [_collectView setImage:[UIImage imageNamed:@"button_zan_default"] forState:UIControlStateNormal];
    _collectView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_collectView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _collectView.titleLabel.font = [UIFont systemFontOfSize:KDetailFont];
    
    
    _seeView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_seeView];
    [_seeView setImage:[UIImage imageNamed:@"icon_read~iphone"] forState:UIControlStateNormal];
    _seeView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_seeView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _seeView.titleLabel.font = [UIFont systemFontOfSize:KDetailFont];
    
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //计算frame
    self.bigFrame = [[SeeTheWordBigFrame alloc] init];
    self.bigFrame.model = self.model;
    
    _imageShow.frame = self.bigFrame.imageShowFrame;
    _title.frame = self.bigFrame.titleFrame;
    _textDetail.frame = self.bigFrame.textDetailFrame;
    _collectView.frame = self.bigFrame.collectViewFrame;
    _seeView.frame = self.bigFrame.seeViewFrame;
    
    //设置内容
    [_imageShow sd_setImageWithURL:[NSURL URLWithString:self.model.img_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _title.text = [NSString stringWithFormat:@"%@",self.model.title];
    _textDetail.text = [NSString stringWithFormat:@"%@",self.model.describe];
    [_collectView setTitle:[NSString stringWithFormat:@"%@",self.model.likes] forState:UIControlStateNormal];
    [_seeView setTitle:[NSString stringWithFormat:@"%@",self.model.views] forState:UIControlStateNormal];
    
    
    
}






@end







