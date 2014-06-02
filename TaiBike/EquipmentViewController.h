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
#import "ASOTwoStateButton.h"
#import "ASOBounceButtonViewDelegate.h"
#import "EquipmentBoundButtonView.h"

@interface EquipmentViewController : UIViewController<SlideNavigationControllerDelegate,ASOBounceButtonViewDelegate>

@property (strong, nonatomic) IBOutlet EquipmentTableView *tableView;

@property (strong, nonatomic) IBOutlet ASOTwoStateButton *menuButton;
@property (strong, nonatomic) EquipmentBoundButtonView *menuItemView;


+(EquipmentViewController*)sharedInstance;
-(void)addItem:(EquipmentModel*)model;

- (IBAction)menuButtonAction:(id)sender;

@end
