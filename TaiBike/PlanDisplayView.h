//
//  HomePagePlanTableView.h
//  TaiBike
//
//  Created by elmer on 2014/6/8.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanDisplayView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, retain)NSMutableArray *data;

@end