//
//  SHPushVC.h
//  qianmingPJ
//
//  Created by mac on 2018/10/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHPushVC : UIViewController

+ (void)registerSHPush:(UIApplication *)application;

+ (void)uploadDeviceToken:(NSData *)deviceToken  APPID:(NSString *)appID;

+ (void)PushBeforShowView:(NSDictionary *)userInfo;

+ (void)getSHObjectInBackgroundWithAppId:(NSString *)appID success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
