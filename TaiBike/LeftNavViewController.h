//
//  LeftNavViewController.h
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SlideNavigationController.h"
@interface LeftNavViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

}


@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
