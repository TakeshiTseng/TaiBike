//
//  TableView.h
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EquipmentTableView : UITableView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)NSArray *data;

@end
