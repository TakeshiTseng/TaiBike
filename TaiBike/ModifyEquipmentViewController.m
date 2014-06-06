//
//  ModiflyEquipmentViewController.m
//  TaiBike
//
//  Created by elmer on 2014/6/1.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "ModifyEquipmentViewController.h"
#import "EquipmentViewController.h"
#import "EquipmentModel.h"

@implementation ModifyEquipmentViewController{
    
    IBOutlet UITextField *nameTextField, *gramTextField;
    IBOutlet UILabel *titleLabel;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UIButton *deleteButton;
    
    int ID;
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
        [titleLabel setText:@"修改裝備"];
        [nameTextField setText:model.name];
        [nameTextField setEnabled:NO];
        
        if(model.gram>=1000){
            [gramTextField setText:[NSString stringWithFormat:@"%.1lf",model.gram/1000.0]];
        }else{
            [segment setSelectedSegmentIndex:1];
            [gramTextField setText:[NSString stringWithFormat:@"%i",model.gram]];
        }
    }else{
        titleLabel.text = @"新增裝備";
        [deleteButton setHidden:YES];
    }
    [gramTextField setDelegate:self];
    [gramTextField setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
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
    double g = [gramTextField.text doubleValue];
    if(i==0){
        g=g*1000;
    }
    model.gram = g;
    
    if ([_mode isEqualToString:@"new"]) {
        model.name = nameTextField.text;
        [equipmentview addItem:model];
    }else{
        [equipmentview modiflyItem:model];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)segmentedValueChange:(id)sender {
    int i = [segment selectedSegmentIndex];
    double g = [gramTextField.text doubleValue];
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
    gramTextField.text=text;
}

-(IBAction)cancelbtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)deletebtn:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"刪除" message:@"請問確定要刪除嗎？" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            [self removeThisItem];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
}

-(void)removeThisItem
{
    EquipmentViewController *equipmentview = [EquipmentViewController sharedInstance];
    
    [equipmentview removeItem:model];
}

#define NUMBERSPERIOD @"0123456789."
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSPERIOD ] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"請输入数字" delegate:nil  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return basicTest;
}

- (IBAction) backgroundTap:(id)sender
{
	[nameTextField resignFirstResponder];
	[gramTextField resignFirstResponder];
}

@end
