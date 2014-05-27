//
//  RegisterViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController {
    IBOutlet UITextField* tfAccount;
    IBOutlet UITextField* tfPwd;
    IBOutlet UITextField* tfPwdAgain;
    IBOutlet UIButton* btnRegister;
    IBOutlet UIActivityIndicatorView* indicatorView;
    
}

-(IBAction)regist:(id)sender;

@end

