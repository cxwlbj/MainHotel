//
//  SeeTheWordBigFrame.m
//  MainHotel
//
//  Created by iMac on 15-10-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "SeeTheWordBigFrame.h"


#define KTitleFont 14
#define KDetailFont 12

@implementation SeeTheWordBigFrame


//当model赋值时,直接计算出frame
- (void)setModel:(SeeTheWordModel *)model{
    
    if (_model != model) {
        _model = model;
        
        CGFloat imageShowW = KIPHONEWidth;
        CGFloat imageShowH = 210;
        CGFloat imageShowX = 0;
        CGFloat imageShowY = 0;
        self.imageShowFrame = CGRectMake(imageShowX, imageShowY, imageShowW, imageShowH);
        
        
        CGFloat titleX = XMargin * 2;
        CGFloat titleY = imageShowH + XMargin * 2;
        CGFloat titleW = KIPHONEWidth - XMargin * 4;
        CGFloat titleH = [self calculateLabelHeightWithText:self.model.title fieldWidth:(titleW) font:KTitleFont];
        self.titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
        
        
        
        CGFloat textDetailX = XMargin * 2;
        CGFloat textDetailY = self.titleFrame.origin.y + titleH + XMargin * 2;
        CGFloat textDetailW = KIPHONEWidth - XMargin * 4;
        CGFloat textDetailH = [self calculateLabelHeightWithText:self.model.describe fieldWidth:textDetailW font:KDetailFont];
        self.textDetailFrame = CGRectMake(textDetailX, textDetailY, textDetailW, textDetailH);
        
        
        
        CGFloat collectViewX = XMargin * 2;
        CGFloat collectViewY = self.textDetailFrame.origin.y + textDetailH + XMargin * 2;
        CGFloat collectViewW = 60;
        CGFloat collectViewH = 15;
        self.collectViewFrame = CGRectMake(collectViewX, collectViewY, collectViewW, collectViewH);
        
        
        CGFloat seeViewX = self.collectViewFrame.origin.x + collectViewW + XMargin * 2;
        CGFloat seeViewY = self.collectViewFrame.origin.y;
        CGFloat seeViewW = 70;
        CGFloat seeViewH = 15;
        self.seeViewFrame = CGRectMake(seeViewX, seeViewY, seeViewW, seeViewH);
        
        
        self.bigCellHeight = self.collectViewFrame.origin.y + self.collectViewFrame.size.height + XMargin;
        
    }
    
}


//根据单元格宽度,文本内容和字体大小  计算文本高度
- (CGFloat)calculateLabelHeightWithText:(NSString *)text fieldWidth:(CGFloat)width font:(CGFloat)font{
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return size.height;
}




@end






