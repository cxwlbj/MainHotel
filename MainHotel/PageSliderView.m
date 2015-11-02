//
//  PageSliderView.m
//  MainHotel
//
//  Created by iMac on 15-10-11.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "PageSliderView.h"


#define KLabelFont 12

@implementation PageSliderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setUpSubviews];
    }
    return self;
}


- (void)setUpSubviews{
    
    _scrollViewMain = [[UIScrollView alloc] initWithFrame:CGRectZero];//主要视图
    [self addSubview:_scrollViewMain];
    
    
    _scrollViewPage = [[UIScrollView alloc] initWithFrame:CGRectZero];//分页栏
    [self addSubview:_scrollViewPage];
    
    
    _pageImage = [[UIImageView alloc] initWithFrame:CGRectZero];;//红色分页条
    [_scrollViewPage addSubview:_pageImage];
    _pageImage.image = [UIImage imageNamed:@"bg_tickit_top~iphone"];
    _pageImage.userInteractionEnabled = YES;
    
    _firstButton = [UIButton buttonWithType:UIButtonTypeCustom]; //第一页视图
    [_scrollViewPage addSubview:_firstButton];
    [_firstButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];//默认颜色
    
    _secondButton = [UIButton buttonWithType:UIButtonTypeCustom]; //第二页视图
    [_scrollViewPage addSubview:_secondButton];
    [_secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _threeButton = [UIButton buttonWithType:UIButtonTypeCustom]; //第三页视图
    [_scrollViewPage addSubview:_threeButton];
    [_threeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    _firstView = [[UIView alloc] initWithFrame:CGRectZero];
    [_scrollViewMain addSubview:_firstView];
    
    _secondView = [[UIView alloc] initWithFrame:CGRectZero];
    [_scrollViewMain addSubview:_secondView];
    
    _threeView = [[UIView alloc] initWithFrame:CGRectZero];
    [_scrollViewMain addSubview:_threeView];
    
    
    //计算frame
    [self setViewFrame];
}


- (void)setViewFrame{
    
    
    CGFloat pageHeight = 30;
    
    _scrollViewPage.frame = CGRectMake(0, 0, KIPHONEWidth, pageHeight);
    
    _scrollViewMain.frame = CGRectMake(0, _scrollViewPage.bottom, KIPHONEWidth, 30);
    
    
    //分页栏按钮frame
    NSArray *buttonArr = @[_firstButton,_secondButton,_threeButton];
    
    NSArray *buttonTitle = @[L(@"lightspotOfHotel"),L(@"hotelFacilities"),L(@"pricesInclude")];
    
    CGFloat buttonWidth = 80;
    
    CGFloat btnMargin = (KIPHONEWidth - buttonWidth * buttonArr.count) / (buttonArr.count + 1);
    
    for (int i=0; i<buttonArr.count; i++) {
        
        CGFloat buttonH = pageHeight;
        CGFloat buttonX = btnMargin * (i+1) + buttonWidth * i;
        CGFloat buttonY = 0;
        
        UIButton *button = buttonArr[i];
        button.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonH);
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        button.tag = 1000+i;
        
        [button addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    _pageImage.frame = CGRectMake(btnMargin, _firstButton.bottom - 2, _firstButton.width, 2);
    
    
    //main视图frame
    NSArray *viewArr = @[_firstView,_secondView,_threeView];
    
    for (int i=0; i<viewArr.count; i++) {
        UIView *mainView = viewArr[i];
        mainView.frame = CGRectMake(KIPHONEWidth * i, 0, KIPHONEWidth, 30);
        
    }
    
    //main视图开启滑动
    _scrollViewMain.contentSize = CGSizeMake(KIPHONEWidth * viewArr.count, 0);
    _scrollViewMain.pagingEnabled = YES;
    _scrollViewMain.showsHorizontalScrollIndicator = NO;
    _scrollViewMain.delegate = self;
    
    
    
}

- (void)pageAction:(UIButton *)button{
    
    if (button.tag == 1000) {
        //点睛之处
        _scrollViewMain.contentOffset = CGPointMake(0, 0);
        
    }else if(button.tag == 1001){
        //酒店设施
        _scrollViewMain.contentOffset = CGPointMake(KIPHONEWidth, 0);
        
    }else if(button.tag == 1002){
        //价格包含
        _scrollViewMain.contentOffset = CGPointMake(KIPHONEWidth * 2, 0);
    }
    
    [UIView animateWithDuration:.35 animations:^{
        
        _pageImage.left = button.left;
    }];
    
}


- (void)setModel:(HotelDetailModel *)model{
    
    if (_model != model) {
        _model = model;
        
        
        //1.点睛之处
        CGFloat totalHeight = 0;
        
        if (model.whylike.count > 0) {
            
            for (int i=0; i<model.whylike.count; i++) {
                NSString *text = model.whylike[i];
                NSString *textLast = [NSString stringWithFormat:@"%d丶%@",i+1,text];
                CGFloat height = [self calculateLabelHeightWithText:textLast fieldWidth:(KIPHONEWidth - XMargin * 6) font:KLabelFont];
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(XMargin * 3, totalHeight + XMargin * 2, KIPHONEWidth - XMargin * 6, height)];
                
                label.numberOfLines = 0;
                label.font = [UIFont systemFontOfSize:KLabelFont];
                label.text = textLast;
                [_firstView addSubview:label];
                
                //累计高度
                totalHeight = label.bottom;
                
            }
            
        }
        
        _firstView.height = totalHeight + XCellMargin;//重新定义视图高度
        _secondView.height = totalHeight + XCellMargin;
        _threeView.height = totalHeight + XCellMargin;
        
        _scrollViewMain.height = _firstView.bottom;//重新定义scrollViewMain高度
        self.viewHeight = _scrollViewMain.bottom; //计算视图高度
        
        
        //2.酒店设施
        
//        "ft_bath"           = "浴室";
//        "ft_carpark"        = "停车场";
//        "ft_gym"            = "健身房";
//        "ft_hair_dryer"     = "电吹风";
//        "ft_laundry"        = "洗衣房";
//        "ft_meal"           = "含早餐";
//        "ft_pool"           = "游泳池";
//        "ft_tv"             = "电视机";
//        "ft_wifi"           = "无线WIFI";
        
        NSDictionary *detailDict = @{@"ft_bath":@[L(@"ft_bath"),@"ft_bath~iphone"],
                                     @"ft_carpark":@[L(@"ft_carpark"),@"ft_carpark~iphone"],
                                     @"ft_gym":@[L(@"ft_gym"),@"ft_gym~iphone"],
                                     @"ft_hair_dryer":@[L(@"ft_hair_dryer"),@"ft_hair_dryer~iphone"],
                                     @"ft_laundry":@[L(@"ft_laundry"),@"ft_laundry~iphone"],
                                     @"ft_meal":@[L(@"ft_meal"),@"ft_meal~iphone"],
                                     @"ft_pool":@[L(@"ft_pool"),@"ft_pool~iphone"],
                                     @"ft_tv":@[L(@"ft_tv"),@"ft_tv~iphone"],
                                     @"ft_wifi":@[L(@"ft_wifi"),@"ft_wifi~iphone"]};//关键字:中文描述,图片
        
        CGFloat infoMargin =  20;//button离 左右上方的间隔
        CGFloat infoWidth = 100;//button宽度
        CGFloat infoHeight = 15;//button高度
        CGFloat infoCenterMargin = KIPHONEWidth - infoMargin * 2 - infoWidth * 2;//button中间宽度
        if (model.features.count > 0) {
            
            for (int i=0; i<model.features.count; i++) {
                //提取数据
                NSString *detail = model.features[i];
                NSArray *detailArr = [detailDict objectForKey:detail];
                NSString *info = detailArr[0];
                NSString *imageInfo = detailArr[1];
                
                //创建button
                UIButton *infoButton = [UIButton  buttonWithType:UIButtonTypeCustom];
                //根据行和列排布
                int row = i / 2;//行
                int line = i % 2;//列
                infoButton.frame = CGRectMake(infoMargin + (infoWidth + infoCenterMargin) * line, infoMargin + (infoHeight + infoMargin) * row, infoWidth, infoHeight);//设置frame
                [infoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                infoButton.titleLabel.font = [UIFont systemFontOfSize:KLabelFont];
                [infoButton setImage:[UIImage imageNamed:imageInfo] forState:UIControlStateNormal];//图片
                infoButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
                [infoButton setTitle:info forState:UIControlStateNormal];//标题
                
                [_secondView addSubview:infoButton];
                
            }
            
        }
        
        
        
        //3.价格包含
        CGFloat threeHeight = 0;
        UILabel *priceInlude = [[UILabel alloc] initWithFrame:CGRectMake(XMargin * 3, XMargin * 2, KIPHONEWidth - XMargin * 6, threeHeight)];
        priceInlude.numberOfLines = 0;
        priceInlude.font = [UIFont systemFontOfSize:KLabelFont];
        priceInlude.text = [NSString stringWithFormat:@"%@",model.container];
        CGFloat heightTh = [self calculateLabelHeightWithText:model.container fieldWidth:(KIPHONEWidth - XMargin * 6) font:KLabelFont];
        priceInlude.height = heightTh; //重新定义高度
        priceInlude.textColor = [UIColor blackColor];
        priceInlude.font = [UIFont systemFontOfSize:KLabelFont];
        [_threeView addSubview:priceInlude];
    }
    
    
}


//根据单元格宽度,文本内容和字体大小  计算文本高度
- (CGFloat)calculateLabelHeightWithText:(NSString *)text fieldWidth:(CGFloat)width font:(CGFloat)font{
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return size.height;
}


#pragma mark -- scrollView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x > KIPHONEWidth / 2 && scrollView.contentOffset.x < KIPHONEWidth * 1.5) {
        [self scrollToPoint:_secondButton];
    }else if( scrollView.contentOffset.x > KIPHONEWidth * 1.5){
        
        [self scrollToPoint:_threeButton];
    }else if(scrollView.contentOffset.x < KIPHONEWidth / 2){
        
        [self scrollToPoint:_firstButton];
    }
    
}


- (void)scrollToPoint:(UIButton *)button{
    [UIView animateWithDuration:.35 animations:^{
        _pageImage.left = button.left;
    }];
    
    if (_firstButton == button) {
        
        [_firstButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_threeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if (_secondButton == button){
        [_secondButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_threeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if (_threeButton == button){
        [_threeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

@end









