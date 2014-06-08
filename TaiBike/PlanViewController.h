//
//  PlanViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/28.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SlideNavigationController.h"

@interface PlanViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate, SlideNavigationControllerDelegate>{
    IBOutlet UILabel* locationLabel;
    IBOutlet UILabel* hightLabel;
    IBOutlet UILabel* speedLabel;
    IBOutlet UIButton *recordbutton;
}

@property(strong,nonatomic) NSString *lat,*longt;
@property CLLocationDistance altitude;
@property CLLocationSpeed speed;

+(PlanViewController*)sharedInstance;
-(void)startStandardUpdates;
-(void)setLocationData:(CLLocation*) newLocation;

-(IBAction)recordbtn:(id)sender;
-(IBAction)printbtn:(id)sender;
-(IBAction)resetbtn:(id)sender;

@end
