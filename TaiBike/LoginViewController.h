//
//  LoginViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UITextField* tfAccount;
    IBOutlet UITextField* tfPassword;
    IBOutlet UIActivityIndicatorView* indicatorView;
    IBOutlet UIButton* btnLogin;
}


-(IBAction)login:(id)sender;


@end
