//
//  EquipmentModel.m
//  TaiBike
//
//  Created by elmer on 2014/6/1.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "EquipmentModel.h"

@implementation EquipmentModel

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSComparisonResult)compareSelect:(EquipmentModel *)model
{
    
    if (self.isUp ? (self.isSelsct > model.isSelsct) : (self.isSelsct < model.isSelsct)) {
        
        return NSOrderedDescending; // 降序
    } else if (self.isSelsct == model.isSelsct) {
        
        return NSOrderedSame; // 同序
    }else {
        
        return NSOrderedAscending; // 升序
    }
}


- (NSComparisonResult)compareID:(EquipmentModel *)model
{
    
    if (self.isUp ? (self.equipmentID > model.equipmentID) : (self.equipmentID < model.equipmentID)) {
        
        return NSOrderedDescending; // 降序
    } else if (self.equipmentID == model.equipmentID) {
        
        return NSOrderedSame; // 同序
    }else {
        
        return NSOrderedAscending; // 升序
    }
}

-(NSComparisonResult)compareName:(EquipmentModel *)model
{
    if (self.isUp ? (self.name > model.name) : (self.name < model.name)) {
        
        return NSOrderedDescending;
    } else if (self.name == model.name) {
        
        return NSOrderedSame;
    }else {
        return NSOrderedAscending;
    }
}

-(NSComparisonResult)comparegram:(EquipmentModel *)model
{
    if (self.isUp ? (self.gram > model.gram) : (self.gram < model.gram)) {
        
        return NSOrderedDescending;
    } else if (self.gram == model.gram) {
        
        return NSOrderedSame;
    }else {
        return NSOrderedAscending;
    }
}

@end
