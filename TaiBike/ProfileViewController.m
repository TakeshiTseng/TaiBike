//
//  ProfileViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *loadRootPath = [NSSearchPathForDirectoriesInDomains
                              (NSDocumentDirectory,NSUserDomainMask, YES)
                              objectAtIndex:0];
    NSString *loadPath = [loadRootPath stringByAppendingPathComponent:@"user.plist"];
    
    NSMutableDictionary* dict = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:loadPath ];
    
    NSString* authKey = [ dict objectForKey:@"authKey" ];
    NSLog(@"%@", authKey);
    
    userInfo = [self getUserProfileWithAuthKey:authKey];
    
    NSString* account = [userInfo objectForKey:@"account"];
    NSString* name = [userInfo objectForKey:@"name"];
    NSArray* ridePlans = [userInfo objectForKey:@"ridePlans"];

    
    [lbAccount setText:[NSString stringWithFormat:@"帳號：%@", account]];
    [lbName setText:[NSString stringWithFormat:@"姓名：%@", name]];
    [lbNumPlans setText:[NSString stringWithFormat:@"騎乘計畫數：%d", [ridePlans count]]];
    
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSDictionary*)getUserProfileWithAuthKey:(NSString*)authKey {
        NSString* url = [NSString stringWithFormat:@"http://bike.takeshi.tw/api/user/info?authKey=%@", authKey];
        NSError *error;
        NSURLResponse *urlResponse = nil;
        NSURLRequest* request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
        NSData* requestData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableLeaves error:&error];
        return [res objectForKey:@"info"];
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
