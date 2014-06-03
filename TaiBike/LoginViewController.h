//
//  LoginViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "ProfileViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, SlideNavigationControllerDelegate>{
    IBOutlet UITextField* tfAccount;
    IBOutlet UITextField* tfPassword;
    IBOutlet UIActivityIndicatorView* indicatorView;
    IBOutlet UIButton* btnLogin;
    IBOutlet UILabel* msg;
}


-(IBAction)login:(id)sender;
-(bool)checkAuthKey:(NSString*)authKey;

@end
