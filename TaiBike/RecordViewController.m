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

+(RecordViewController*)getInstance
{
    return instance;
}

#pragma mark - Navigation

-(void)startStandardUpdates
{
    if (locationManager == nil){
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
}

-(void)updateLoacationPlist:(NSTimer*) timer
{
    //    [locationManager startUpdatingLocation];
    NSLog(@"updateLoacation  running...");
    
    NSMutableDictionary *data= [[NSMutableDictionary alloc]init];
    
    NSString *number = [NSString stringWithFormat:@"%i",recordCount++];
    [data setObject:number forKey:@"count"];
    
    NSString *dateString = [self getTimeNSString];
    [data setObject:dateString forKey:@"time"];
    
    [data setObject:lat forKey:@"latitude"];
    [data setObject:longt forKey:@"longitude"];
    
    NSString *altStr = [NSString stringWithFormat:@"%f",altitude];
    [data setObject:altStr forKey:@"altitude"];
    NSString *speedStr = [NSString stringWithFormat:@"%f",speed];
    [data setObject:speedStr forKey:@"speed"];
    
    [locationRecord setObject:data forKey:number];
    
}

-(NSString*)getTimeNSString
{
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"locationManager running...");
    [self setLocationData:newLocation];
}

-(void)setLocationData:(CLLocation *)newLocation
{
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
           degrees, minutes, seconds];
    
    degrees = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
             degrees, minutes, seconds];
    
    altitude = newLocation.altitude;
    speed = newLocation.speed;
    
    [locationLabel setText:[NSString stringWithFormat:@"%@ , %@",lat,longt]];
    [hightLabel setText:[NSString stringWithFormat:@"%f",altitude]];
    [speedLabel setText:[NSString stringWithFormat:@"%f",speed]];
}

-(void)loadLocationPlist
{
    //先從取出開始
    
    //初始化路徑
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains
                          (NSDocumentDirectory,NSUserDomainMask, YES)
                          objectAtIndex:0];
    
    //取得 plist 檔路徑
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Location.plist"];
    
    //如果 Documents 文件夾中沒有 test.plist 的話，則從 project 目錄中载入 test.plist
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        //        plistPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"plist"];
        NSLog(@"Load 'Loaction.plist' fail.");
        [self resetbtn:nil];
    }else{
        
        //將取得的 plist 內容載入至剛才建立的 Dictionary 中
        plistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSLog(@"Load 'Loaction.plist' success.");
    }
}

-(void)storeLoctionPlist
{
    //取出剛才新增的 "PlayName"
    //    NSString *PlayName = [plistDictionary objectForKey:@"PlayName"];
    
    //再利用 NSLog 來查看剛才修改的 Dictionary
    //    NSLog(@"test plist:%@",plistDictionary);
    //    NSLog(@"PlayName:%@",PlayName);
    
    //取得儲存路徑
    NSString *SaveRootPath = [NSSearchPathForDirectoriesInDomains
                              (NSDocumentDirectory,NSUserDomainMask, YES)
                              objectAtIndex:0];
    NSString *SavePath = [SaveRootPath stringByAppendingPathComponent:@"Location.plist"];
    
    //將 Dictionary 儲存至指定的檔案
    [plistDictionary writeToFile:SavePath atomically:YES];
}

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
