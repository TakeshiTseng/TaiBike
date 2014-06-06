//
//  RecommendedEquipmentViewController.h
//  TaiBike
//
//  Created by elmer on 2014/6/6.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationContorllerAnimator.h"
#import "RecommendedEquipmentTableView.h"

@interface RecommendedEquipmentViewController : UIViewController<SlideNavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *viewSegmentedControl;
@property (strong, nonatomic) IBOutlet RecommendedEquipmentTableView *tableView;

+(RecommendedEquipmentViewController*)sharedInstance;

@end
