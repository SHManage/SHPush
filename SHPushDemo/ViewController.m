//
//  ViewController.m
//  SHPushDemo
//
//  Created by mac on 2018/10/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "SHPushVC.h"
@interface ViewController ()
@property (nonatomic, strong)UILabel *messLB;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    _messLB = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, self.view.frame.size.width-40, 200)];
    _messLB.numberOfLines = 0;
    _messLB.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_messLB];
    [self getSHMessage];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reciveMessage:) name:@"APNSNotifi" object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)reciveMessage:(NSNotification *)notif{
    
    NSDictionary *dic = notif.userInfo;
    NSString *message = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"aps"]objectForKey:@"alert"]];
    
    _messLB.text = message;
}

//获取顺恒后台数据
- (void)getSHMessage{
    
    [SHPushVC getSHObjectInBackgroundWithAppId:@"APPID" success:^(id responseObject) {//
        
        NSString *jsonstr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSLog(@"shuju:%@",jsonstr);
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
