//
//  EquipmentModel.h
//  TaiBike
//
//  Created by elmer on 2014/6/1.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EquipmentModel : NSObject

@property(nonatomic, assign) int equipmentID;
@property(strong, nonatomic) NSString *name;
@property(nonatomic, assign) int gram;
@property(nonatomic, assign)BOOL isUp;

-(NSComparisonResult) compareID:(EquipmentModel*) model;
-(NSComparisonResult) compareName:(EquipmentModel*) model;
-(NSComparisonResult) comparegram:(EquipmentModel*) model;

@end
