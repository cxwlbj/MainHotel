//
//  ThreeKilometersCell.m
//  MainHotel
//
//  Created by iMac on 15-10-12.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "ThreeKilometersCell.h"

@interface ThreeKilometersCell()
//展示图片
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
//地方简介
@property (weak, nonatomic) IBOutlet UILabel *hotelDetail;
//地方名称
@property (weak, nonatomic) IBOutlet UILabel *hotelName;
//地方价格
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//加载中
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingShow;

@end

@implementation ThreeKilometersCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.loadingShow.hidden = NO;
    [self.loadingShow startAnimating];
    
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:self.model.images] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.loadingShow stopAnimating];
        self.loadingShow.hidden = YES;
    }];
    
    self.hotelDetail.text = [NSString  stringWithFormat:@"%@",self.model.feature];
    self.hotelDetail.textColor = [UIColor whiteColor];
    
    self.hotelName.text = [NSString stringWithFormat:@"[%@]",self.model.name];
    
    if (self.model.averagePrice == 0) {
        
        self.priceLabel.text = [NSString  stringWithFormat:@"免费"];
    }else{
        self.priceLabel.text = [NSString  stringWithFormat:@"￥%@",self.model.averagePrice];
    }
    
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
