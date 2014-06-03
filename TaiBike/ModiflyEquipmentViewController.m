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
    NSString *_mode;
    EquipmentModel* model;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];NSLog(@"init");
    if (self) {
        // Custom initialization
        NSLog(@"init");
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"init");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Mode:%@",_mode);
    
    if ([_mode isEqualToString:@"modifly"]) {
        [self.titleLabel setText:@"修改裝備"];
        [self.nameTextField setText:model.name];
        [self.nameTextField setEnabled:NO];
        
        if(model.gram>=1000){
            [self.gramTextField setText:[NSString stringWithFormat:@"%.1lf",model.gram/1000.0]];
        }else{
            [segment setSelectedSegmentIndex:1];
            [self.gramTextField setText:[NSString stringWithFormat:@"%i",model.gram]];
        }
    }else{
        self.titleLabel.text = @"新增裝備";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Info - NSMutableDirectory
 [Mode] key:"mode" - NSString ,value:{new, modifly}
 [Model] key:"model" - EquipmentModel
 */
- (void)setInfo:(id)sender
{
    NSMutableDictionary *info = (NSMutableDictionary*)sender;
    
    NSString *mode = [info objectForKey:@"mode"];
    _mode = mode;
    
    if ([mode isEqualToString:@"modifly"]) {
        _mode = mode;
        model = (EquipmentModel*)[info objectForKey:@"model"];
    }else{
        model = [[EquipmentModel alloc]init];
    }
}

-(IBAction)donebtn:(id)sender
{
    EquipmentViewController *equipmentview = [EquipmentViewController sharedInstance];
    
    int i = [segment selectedSegmentIndex];
    double g = [self.gramTextField.text doubleValue];
    if(i==0){
        g=g*1000;
    }
    model.gram = g;
    
    if ([_mode isEqualToString:@"new"]) {
        model.name = self.nameTextField.text;
        [equipmentview addItem:model];
    }else{
        [equipmentview modiflyItem:model];
    }
    
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
