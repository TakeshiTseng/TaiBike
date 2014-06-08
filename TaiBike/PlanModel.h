//
//  PlanModel.h
//  TaiBike
//
//  Created by elmer on 2014/6/9.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlanModel : NSObject

@property(strong, nonatomic) NSString *ID;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) NSString *description;
@property(strong, nonatomic) NSString *timeStart;
@property(strong, nonatomic) NSString *timeEnd;
@property(strong, nonatomic) NSMutableArray *points;
@property(strong, nonatomic) NSMutableArray *records;
@property(strong, nonatomic) NSMutableArray *equipments;

@end
