//
//  EquipmentBoundButtonView.m
//  TaiBike
//
//  Created by elmer on 2014/6/2.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "EquipmentBoundButtonView.h"
#import "EquipmentViewController.h"

@implementation EquipmentBoundButtonView{
    IBOutlet ASOTwoStateButton *menuButton; 
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction) backgroundTap:(id)sender
{
    EquipmentViewController *equipmentview = [EquipmentViewController sharedInstance];
    [equipmentview menuButtonAction:equipmentview.menuButton];
    [equipmentview.menuButton startAnimatingButton:equipmentview.menuButton];
}

@end
