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
#import <Firebase/Firebase.h>
#import "MarqueeLabel.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    IBOutlet MarqueeLabel *messageLabel;
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
    
    Firebase *f = [[Firebase alloc]initWithUrl:@"https://taibike.firebaseio.com/broadcast"];
    [f observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        NSMutableDictionary *s = snapshot.value;
        
        NSString *ststusstr = [s objectForKey:@"broadcast"];

        if ([ststusstr isEqualToString:@"yes"]) {
            [[f childByAppendingPath:@"broadcast"]setValue:@"no"];
            [self getServerBroadcastMessage:nil];
        }
    }];
    
    
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
    
    [messageLabel setRate:150];
    [messageLabel setFadeLength:10.0f];
    messageLabel.numberOfLines = 1;
    messageLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    messageLabel.textAlignment = NSTextAlignmentLeft;
    messageLabel.textColor = [UIColor colorWithRed:0.234 green:0.234 blue:0.234 alpha:1.000];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.000];
    messageLabel.marqueeType = MLContinuous;
    [self setMarguee:@"歡迎使用 TaiBike!"];
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

-(void)getServerBroadcastMessage:(NSTimer*)timer
{
    Firebase *f = [[Firebase alloc]initWithUrl:@"https://taibike.firebaseio.com/broadcast/msg"];
    [f observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self setMarguee:snapshot.value];
    }];
}

-(void)setMarguee:(NSString*)msg
{
    [messageLabel setText:msg];
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
