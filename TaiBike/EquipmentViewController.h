//
//  EqupmentViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationContorllerAnimator.h"
#import "EquipmentModel.h"
#import "EquipmentTableView.h"

@interface EquipmentViewController : UIViewController<SlideNavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet EquipmentTableView *tableView;

+(EquipmentViewController*)sharedInstance;
-(void)addItem:(EquipmentModel*)model;

@end
