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
#import "HomePagePlanTableView.h"

@interface HomeViewController ()

@end

@implementation HomeViewController{
    IBOutlet UILabel *messageLabel;
    IBOutlet UIView *planView;
    IBOutlet HomePagePlanTableView *planTableView;
    
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
    
    //水平線
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(20, planView.frame.origin.y-1, self.view.frame.size.width-40, 1.0)];
    horizontalLine.backgroundColor = [UIColor blackColor];
    [self.view addSubview:horizontalLine];
    
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
    NSMutableArray* data = [self loadPoint];
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

- (NSMutableArray*)loadPoint
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    NSMutableArray* points = planModel.points;
    
    for (NSMutableDictionary* point in points) {
        [data addObject:point];
    }
    
    NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];
	[rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
	[rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    int size = data.count-1;
    size = size<0?0:size;
    for(int i=0;i<size;i++){
        for (int ii=i+1; ii<size+1; ii++) {
            NSLog(@"%i , %i",i,ii);
            	// Convert the RFC 3339 date time string to an NSDate.
            NSDate *a = [rfc3339DateFormatter dateFromString:[(NSDictionary*)[data objectAtIndex:i] objectForKey:@"time"]];
            NSDate *b = [rfc3339DateFormatter dateFromString:[(NSDictionary*)[data objectAtIndex:ii] objectForKey:@"time"]];
            
            NSLog(@"%@",a);
            NSLog(@"%@",b);
            
            if ([a compare:b] == NSOrderedDescending) {
                NSLog(@"Y");
                NSObject *dataA = [data objectAtIndex:i];
                NSObject *dataB = [data objectAtIndex:ii];
                [data removeObjectAtIndex:i];
                [data insertObject:dataB atIndex:i];
                [data removeObjectAtIndex:ii];
                [data insertObject:dataA atIndex:ii];
            }
        }
    }
    
    return data;
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
