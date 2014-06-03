//
//  ProfileViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface ProfileViewController : UIViewController<SlideNavigationControllerDelegate> {
    IBOutlet UILabel* lbName;
    IBOutlet UILabel* lbAccount;
    IBOutlet UILabel* lbNumPlans;
    NSDictionary* userInfo;

}

+(NSDictionary*)getUserProfileWithAuthKey:(NSString*)authKey;
+(NSString*)getAuthKey;
+(void)setAuthKey:(NSString*)authKey;
@end
