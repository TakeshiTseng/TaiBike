//
//  PlanTableView.h
//  TaiBike
//
//  Created by elmer on 2014/6/10.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanTableView : UITableView<UITableViewDataSource, UITableViewDelegate>
    @property(strong, nonatomic) NSArray* ridePlans;

@end
