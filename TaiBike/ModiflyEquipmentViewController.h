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
@property(strong, nonatomic) IBOutlet UILabel *titleLabel;

-(IBAction)donebtn:(id)sender;
-(IBAction)cancelbtn:(id)sender;
-(IBAction)setInfo:(id)sender;

@end
