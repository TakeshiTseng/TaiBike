//
//  ModiflyEquipmentViewController.m
//  TaiBike
//
//  Created by elmer on 2014/6/1.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "ModiflyEquipmentViewController.h"
#import "EquipmentViewController.h"
#import "EquipmentModel.h"

@implementation ModiflyEquipmentViewController{
    int ID;
    IBOutlet UISegmentedControl *segment;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Mode:%@",self.mode);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addbtn:(id)sender
{
    EquipmentModel *model = [[EquipmentModel alloc]init];
    model.name = self.nameTextField.text;
    
    int i = [segment selectedSegmentIndex];
    double g = [self.gramTextField.text doubleValue];
    if(i==0){
        g=g*1000;
    }
    model.gram = g;
    
    EquipmentViewController *equipmentview = [EquipmentViewController sharedInstance];
    [equipmentview addItem:model];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)segmentedValueChange:(id)sender {
    int i = [segment selectedSegmentIndex];
    double g = [self.gramTextField.text doubleValue];
    double num;
    NSString *text;
    
    switch (i) {
        case 0:
            num = g/1000;
            break;
        case 1:
            num = g*1000;
            break;
        default:
            num = 0;
            break;
    }
    text = [NSString stringWithFormat:@"%.2f",num];
    self.gramTextField.text=text;
}

-(IBAction)cancelbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
