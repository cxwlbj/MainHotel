//
//  RoomDetailView.m
//  MainHotel
//
//  Created by iMac on 15-10-12.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "RoomDetailView.h"

#define KRoomDetailCell @"kRoomDetailCell"

#define KCommonFont 12
#define KLilteFont 10

#define KCellHeight 65
/**
 房型cell
 */

@implementation RoomDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    _showImageView = [[UIImageView alloc] initWithFrame:CGRectZero];//图片展示
    [self.contentView addSubview:_showImageView];
    
    
    _roomType = [[UILabel alloc] initWithFrame:CGRectZero];//房型
    [self.contentView addSubview:_roomType];
    _roomType.font = [UIFont systemFontOfSize:KCommonFont];
    
    
    _roomInfo = [[UILabel alloc] initWithFrame:CGRectZero];//房间信息
    [self.contentView addSubview:_roomInfo];
    _roomInfo.font = [UIFont systemFontOfSize:KLilteFont];
    _roomInfo.numberOfLines = 2;
    
    
    _roomPrice = [[UILabel alloc] initWithFrame:CGRectZero];;//房价价格
    [self.contentView addSubview:_roomPrice];
    _roomPrice.textColor = [UIColor redColor];
    
    //计算frame
    [self setSubviewsFrame];
}

- (void)setSubviewsFrame{
    //图片展示
    CGFloat marin = 5;
    CGFloat imageHW = 30;
    _showImageView.frame = CGRectMake(marin * 4, marin * 2, imageHW, imageHW);
    
    //房型
    _roomType.frame = CGRectMake(_showImageView.right + marin * 2, _showImageView.top, KIPHONEWidth - _showImageView.right - marin * 10, 20);
    
    _roomPrice.frame = CGRectMake(KIPHONEWidth - 75 - marin * 6, _roomType.top, 75, 20);//房价价格
    
    _roomInfo.frame = CGRectMake(_roomType.left, _roomType.bottom + marin, KIPHONEWidth - _roomType.left - marin, 20);//房间信息
    
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //图片展示
    NSInteger bedType = [self.model.bedType integerValue];
    if (bedType == 1) {
        _showImageView.image = [UIImage imageNamed:@"icon_bedtype_one~iphone"];
    }else{
        _showImageView.image = [UIImage imageNamed:@"icon_bedtype_two~iphone"];
    }
    //房型
    _roomType.text = [NSString stringWithFormat:@"%@",self.model.name];
    //房间信息
    _roomInfo.text = [NSString stringWithFormat:@"%@",self.model.desc];
   //房价价格
    _roomPrice.text = [NSString stringWithFormat:@"￥%@",self.model.averageRate];
    
}



@end


/**
 房型view
 */
@implementation RoomDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}



- (void)setUpSubviews{
    
    //1.tableView
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)setModel:(HotelDetailModel *)model{
    if (_model != model) {
        _model = model;
        
        self.viewHeight = KCellHeight * model.rooms.count;
        //重新设置tableView的高度
        _tableView.height = self.viewHeight;
    }
}


#pragma mark -- tableview数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.model.rooms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = KRoomDetailCell;
    RoomDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[RoomDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    
    //设置cell内容
    cell.model = self.model.rooms[indexPath.row];
    
    return cell;
    
}



#pragma mark -- tableview代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger roomNum = indexPath.row;
    
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KBoutiqueHotelDetailRefesh object:self userInfo:@{KRoomsDidSelectNumber:@(roomNum)}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KCellHeight;
}

@end



