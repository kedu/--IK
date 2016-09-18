//
//  ViewController.m
//  仿映客直播-IK
//
//  Created by Apple on 16/9/16.
//  Copyright © 2016年 lkb-求工作qq:1218773641. All rights reserved.
//
#import "AFNetworking.h"
#import "ViewController.h"
#import "TableViewCell.h"
#import "Model.h"
#import "LiveViewController.h"
#define url1 [NSString stringWithFormat:@"http://116.211.167.106/api/live/gettop?&devi=dce18d012f982eaa697eda4e2f0ecc57d9f7e315&cv=IK3.5.10_Iphone&ua=iPad5_4&proto=7&lc=0000000000000035&idfv=664597CF-A571-43D1-B5CC-A857D7EE18D3&imsi=&imei=&cc=TG0001&osversion=ios_9.300000&idfa=37AA66DE-CA0C-4FDD-AC2A-5B937DEFB7C7&uid=141912707&sid=20DfBFeLrK4ufQg2Ac7RD8lpkG4uZz46XTzofi1X28Sd2sjVTjD&conn=Wifi&mtid=31baf5edc57d76fd3005222389ca498f&mtxid=6c594073a89a&s_sg=d5d6421d701038dd29593f07ee62b9ae&s_sc=100&s_st=1474043911&count=5&multiaddr=1"]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray*dataArray;
@property(nonatomic,strong)NSMutableArray*modelArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    //    [UITableView registerNib:[UINib nibWithNibName:@"TableViewCell"bundle:nil]forCellReuseIdentifier:reUseID];
    [self afn];
    //获取数据
    [self data];
    //还是主要问题没时间,找工作先
    //
}
-(void)data{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURL *URL = [NSURL URLWithString:url1];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8"  forHTTPHeaderField:@"Content-Type"];
    NSURLSessionDataTask*dataTask=[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                if (error) {
//                    NSLog(@"错误Error: %@", error);
                } else {
                    self.dataArray=responseObject[@"lives"];
                    NSLog(@"%@",self.dataArray);
//                    NSString*city=[NSString stringWithFormat:@"%@",self.dataArray[0][@"city"]];
//                    NSLog(@"%@",city);
                    
                    self.modelArray=[NSMutableArray array];
                    //字典转模型了
                    for (NSDictionary*tmp in self.dataArray) {
                        if ([tmp isKindOfClass:[NSDictionary class]]){
                        
                            Model * viewModel = [[Model alloc] initWithDictionary:tmp];
                            //标题
                            viewModel.city=tmp[@"city"];
                           
                            [self.modelArray addObject:viewModel];
                            
                        }
                         [self.tableView reloadData];
                            
                                    
                }
                }
        
    }];
    [dataTask resume];









}
-(void)afn
{
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        extern int gNetWorkeStatus;
        gNetWorkeStatus=status;

        NSLog(@"%d",gNetWorkeStatus);
        
        if (status == AFNetworkReachabilityStatusNotReachable)
        {
            //showAlert

          NSLog(@"没有网络");
            
            return;
            
        }else if (status == AFNetworkReachabilityStatusUnknown){
            
            NSLog(@"未知网络");
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            
            NSLog(@"WiFi");
            
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            
            NSLog(@"手机网络");
        }
        
    }];}
    
    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 100;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell的复用
    static NSString*reUseID=@"cell";

    TableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:reUseID];
    if (cell==nil) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reUseID];
    }
    
        
   
    Model * viewModel = [self.modelArray objectAtIndex:indexPath.row];
    cell.model=viewModel;//数据还没有过来   你就先调用了
//     NSLog(@"%@",viewModel.city);

    //需要自定义cell

    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 300;

}
// Cell跳转直播
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   //实例化liveView
    LiveViewController * liveVc = [[LiveViewController alloc] init];
    Model * viewModel = self.modelArray[indexPath.row];
    // 直播url
    liveVc.liveUrl=viewModel.url;
    // 直播图片
    liveVc.imageUrl = viewModel.portrait;
    [self.navigationController pushViewController:liveVc animated:true];
    self.navigationController.navigationBar.hidden = YES;
    
}

// cell动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
