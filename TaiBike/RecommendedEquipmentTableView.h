//
//  RecommendedEquipmentTableView.h
//  TaiBike
//
//  Created by elmer on 2014/6/7.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendedEquipmentTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)NSMutableArray *data;
@property(nonatomic, retain)NSMutableArray* groupNames;

@end
