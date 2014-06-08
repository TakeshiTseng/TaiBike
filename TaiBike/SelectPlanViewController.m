//
//  SelectPlanViewController.m
//  TaiBike
//
//  Created by elmer on 2014/6/9.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "SelectPlanViewController.h"
#import "PlanViewController.h"

@interface SelectPlanViewController ()

@end

@implementation SelectPlanViewController{
    IBOutlet UILabel *nameLabel;
    PlanModel *_model;
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

    [nameLabel setText:_model.name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setModel:(PlanModel*)model
{
    _model = model;
}

- (IBAction)start:(id)sender
{
    PlanViewController* planViewController = [PlanViewController sharedInstance];
    NSString *str = [NSString stringWithFormat:@"計劃：\"%@\" 執行中...",_model.name];
    [planViewController.planLabel setText:str];
    [PlanViewController sharedInstance].currentPlan = _model;
    [[PlanViewController sharedInstance].navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end