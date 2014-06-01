//
//  ModiflyEquipmentViewController.h
//  TaiBike
//
//  Created by elmer on 2014/6/1.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModiflyEquipmentViewController : UIViewController

@property(strong, nonatomic) IBOutlet UITextField *nameTextField, *gramTextField;
@property(strong, nonatomic) NSString *mode;

-(IBAction)addbtn:(id)sender;
-(IBAction)cancelbtn:(id)sender;

@end
