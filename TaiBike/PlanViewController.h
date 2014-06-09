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
#import "ProfileViewController.h"
#import "PlanModel.h"

@interface PlanViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,SlideNavigationControllerDelegate> {
    NSArray* ridePlans;
}

@property(strong, nonatomic) PlanModel *currentPlan;
@property(strong, nonatomic) IBOutlet UILabel *planLabel;

@property(strong,nonatomic) NSString *lat,*longt;
@property CLLocationDistance altitude;
@property CLLocationSpeed speed;

- (void)changeToPlanTableView;
- (void)changeToPlanDisplayView;
-(void)setLocationData:(CLLocation*) newLocation;
-(void)recordbtn:(id)sender;

+(PlanViewController*)sharedInstance;
+ (NSMutableArray*)getPointWithPlanModel:(PlanModel*)model;

@end
