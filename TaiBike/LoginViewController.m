//
//  LoginViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [msg setText:@""];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if([textField isEqual:tfAccount]) {
        [tfPassword becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
        [self login:nil];
    }
    

    return YES;
}

- (IBAction)login:(id)sender {
    [btnLogin setEnabled:NO];
    [indicatorView startAnimating];
    
    // process login
    
    NSString* account = [tfAccount text];
    NSString* password = [tfPassword text];
    NSString* url = [NSString stringWithFormat:@"http://bike.takeshi.tw/api/auth/login?account=%@&password=%@", account, password];
    NSError *error;
    NSURLResponse *urlResponse = nil;
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSData* requestData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableLeaves error:&error];

    NSNumber* err = [res objectForKey:@"error"];
    
    NSLog(@"%d", [err intValue]);
    
    if([err intValue] == 1) {
        [msg setText:@"帳號或是密碼錯誤"];
    } else {
        NSString* authKey = [res objectForKey:@"authKey"];
        NSLog(@"%@", authKey);
        [self performSegueWithIdentifier:@"Login" sender:self];
    }
    [btnLogin setEnabled:YES];
    [indicatorView stopAnimating];
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
