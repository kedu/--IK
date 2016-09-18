//
//  Model.m
//  仿映客直播-IK
//
//  Created by Apple on 16/9/16.
//  Copyright © 2016年 lkb-求工作qq:1218773641. All rights reserved.
//

#import "Model.h"

@implementation Model
- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        //字典转模型
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}
@end
