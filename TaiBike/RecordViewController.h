//
//  RecordViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SlideNavigationContorllerAnimator.h"

@interface RecordViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate,SlideNavigationControllerDelegate>{
    IBOutlet UILabel* locationLabel;
    IBOutlet UILabel* hightLabel;
    IBOutlet UILabel* speedLabel;
    IBOutlet UIButton *recordbutton;
}

@property(strong,nonatomic) NSString *r_lat,*r_longt;
@property CLLocationDistance r_altitude;
@property CLLocationSpeed r_speed;

+(RecordViewController*)getInstance;
-(void)startStandardUpdates;
-(void)setLocationData:(CLLocation*) newLocation;

-(IBAction)recordbtn:(id)sender;
-(IBAction)printbtn:(id)sender;
-(IBAction)resetbtn:(id)sender;


@end
