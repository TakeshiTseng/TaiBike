//
//  PlanViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/28.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "ProfileViewController.h"
@interface PlanViewController : UIViewController<SlideNavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSArray* ridePlans;
    
}

@end
