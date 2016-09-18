//
//  TableViewCell.m
//  仿映客直播-IK
//
//  Created by Apple on 16/9/16.
//  Copyright © 2016年 lkb-求工作qq:1218773641. All rights reserved.
//

#import "TableViewCell.h"
@interface TableViewCell()
@property (weak, nonatomic) IBOutlet UIButton *icon;
@property (weak, nonatomic) IBOutlet UIButton *useName;
@property (weak, nonatomic) IBOutlet UIButton *loc;

@property (weak, nonatomic) IBOutlet UIButton *people;
@property (weak, nonatomic) IBOutlet UIButton *statues;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@end
@implementation TableViewCell
-(void)setModel:(Model *)model{
    _model=model;
    [self.loc setTitle:model.city forState:UIControlStateNormal];
    NSLog(@"%@",model.city);





}

- (void)awakeFromNib {

    NSLog(@"我被调用了");
 
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    NSLog(@"重写cell方法实现");
    if(self){
        self=[[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil]lastObject];
    }
    return self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
