//
//  SHPushVC.m
//  qianmingPJ
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "SHPushVC.h"
#import "network.h"
#import "EBBannerView.h"

@interface SHPushVC ()

@property (nonatomic, strong)NSString *APPIDStr;
@end

@implementation SHPushVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)registerSHPush:(UIApplication *)application{
    
    

    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){//iOS8-iOS9
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    } else {//iOS8以下
        [application registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    
}
+ (void)uploadDeviceToken:(NSData *)deviceToken  APPID:(NSString *)appID{
    
    NSString *token=[NSString stringWithFormat:@"%@",deviceToken];
    
    token=[token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token=[token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token=[token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    NSLog(@"tokenmass:%@",token);
    
    
    
    network *networking = [network sharedOneTimeClass];
    
    
    
    NSString *url = [NSString stringWithFormat:@"http://app.c300.net/api/uploadtoken.ashx?appid=%@&token=%@",appID,token];
    
    //    __weak typeof(self) weakself = self;
    [networking getWithURLString:url parameters:nil success:^(id responseObject) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        if (dic) {
            
            NSString *issuccess = [NSString stringWithFormat:@"%@",dic[@"success"]];
            if ([issuccess isEqualToString:@"1"]) {
                
                NSLog(@"token上传成功");
            }else{
                NSLog(@"token上传成功");

                
            }
            
        }
        
//        NSLog(@"shujuiddd:%@",jsons);
        
//        [[NSUserDefaults standardUserDefaults]setObject:jsons forKey:@"json"];
        
        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"shujuidd:%@",dic);
        
        
    } failure:^(NSError *error) {
        
    }];
    
}

+ (void)PushBeforShowView:(NSDictionary *)userInfo{

    NSString *message = [NSString stringWithFormat:@"%@",[[userInfo objectForKey:@"aps"]objectForKey:@"alert"]];

    [EBBannerView showWithContent:message];
    

}

+ (void)getSHObjectInBackgroundWithAppId:(NSString *)appID success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    
    network *networking = [network sharedOneTimeClass];
    NSString *urlstr = [NSString stringWithFormat:@"http://120.78.176.158:55/api/getdata.ashx?appid=%@",appID];
    [networking getWithURLString:urlstr parameters:nil success:^(id responseObject) {
        success(responseObject);

        
    } failure:^(NSError *error) {
        failure(error);

    }];
    
}



@end
