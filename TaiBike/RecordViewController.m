//
//  RecordViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

@synthesize lat,longt,speed,altitude;

// 建立一個CLLocationCoordinate2D
CLLocationCoordinate2D mylocation,userLocation;
CLLocationManager *locationManager;
float user_NS,user_WE;
NSTimer* timer;
//建立一個 Dictionary
NSMutableDictionary *plistDictionary;
NSMutableDictionary *locationRecord;
bool recordflag = NO;
int recordIndex=0,recordCount;

RecordViewController *instance = nil;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setLat:@"0"];
    [self setLongt:@"0"];
    
    instance = self;
    
    [self loadLocationPlist];
    
    NSString *length = [plistDictionary valueForKey:@"length"];
    recordIndex = [length intValue];
    
    [self startStandardUpdates];
    //timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateLoacation:) userInfo:nil repeats:YES]; //持續更新資料庫中使用者位置
    
    //map_view.delegate = self;
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}
/*
#pragma mark - Navigation

-(IBAction)recordbtn:(id)sender
{
    if (recordflag) {
        recordflag=NO;
        [timer invalidate];
        
        [recordbutton setTitle:@"開始記錄" forState:UIControlStateNormal];
        NSString *length = [NSString stringWithFormat:@"%i",recordCount-1];
        [locationRecord setObject:length forKey:@"length"];
        
        NSString *index = [NSString stringWithFormat:@"%i",recordIndex];
        [plistDictionary setObject:locationRecord forKey:index];
        [plistDictionary setObject:index forKey:@"length"];
        locationRecord =nil;
        [self storeLoctionPlist];
    }else{
        recordflag=YES;
        
        [recordbutton setTitle:@"停止記錄" forState:UIControlStateNormal];
        recordCount=1;
        locationRecord = [[NSMutableDictionary alloc]init];
        
        NSString *index = [NSString stringWithFormat:@"%i",++recordIndex];
        [locationRecord setObject:index forKey:@"index"];
        [locationRecord setObject:[self getTimeNSString] forKey:@"stert_time"];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLoacationPlist:) userInfo:nil repeats:YES];
    }
}

-(IBAction)printbtn:(id)sender
{
    //利用 NSLog 來查看剛才取得的 plist 檔的內容
    NSLog(@"Location.plist:%@",plistDictionary);
}

-(IBAction)resetbtn:(id)sender
{
    plistDictionary = [[NSMutableDictionary alloc] init];
    NSLog(@"Create a new 'Loaction.plist' file.");
    [plistDictionary setObject:@"0" forKey:@"length"];
    [self storeLoctionPlist];
}


@end
