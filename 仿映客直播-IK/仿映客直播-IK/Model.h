//
//  Model.h
//  仿映客直播-IK
//
//  Created by Apple on 16/9/16.
//  Copyright © 2016年 lkb-求工作qq:1218773641. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
@property(nonatomic,copy)NSString*city;//地理位置
@property(nonatomic,copy)NSString*username;//用户名
@property(nonatomic,copy)NSString*uid;//用户头像
@property(nonatomic,copy)NSString*online_users;//人数
@property(nonatomic,strong)NSNumber*dateline;//直播状态
@property(nonatomic,strong)NSNumber*pic;//图片
@property (nonatomic, copy)NSString * ID;//其他属性
@property(nonatomic,strong)NSString *url;
@property(nonatomic,strong)NSString*portrait;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
