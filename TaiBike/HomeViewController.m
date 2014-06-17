//
//  HomeViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "HomeViewController.h"
#import "SlideNavigationController.h"
#import "PlanViewController.h"
#import "PlanDisplayView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    IBOutlet UILabel *messageLabel;
    IBOutlet UIView *planView;
    IBOutlet PlanDisplayView *planTableView;
    IBOutlet UIWebView *webView;
    PlanModel *planModel;
}

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
    NSURL *url = [NSURL URLWithString:@"https://taibike.tw/weather"];//地圖網址
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];//向網頁發request
    [webView loadRequest:requestObj];//將respond讀入頁面
    
    //水平線
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(20, planView.frame.origin.y-1, self.view.frame.size.width-40, 1.0)];
    horizontalLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:horizontalLine];
    
    planTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel * planName = [[UILabel alloc]init];
    [planName setText:@"目前尚無任何計劃執行中"];
    planName.frame = CGRectMake(10, 5, 300, 20);
    planName.font = [UIFont systemFontOfSize:15];
    planName.textAlignment = NSTextAlignmentCenter;
    
    if([PlanViewController sharedInstance].currentPlan != nil){
        planModel = [PlanViewController sharedInstance].currentPlan;
        NSString* str = [NSString stringWithFormat:@"[%@] 進行中...",planModel.name];
        [planName setText:str];
    }
    [planView addSubview:planName];
    NSMutableArray* data = [PlanViewController getPointWithPlanModel:planModel];
    planTableView.data = data;
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
