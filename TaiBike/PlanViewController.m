//
//  PlanViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/28.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "PlanViewController.h"
#import "SelectPlanViewController.h"

@interface PlanViewController ()

@end

@implementation PlanViewController



PlanViewController *g_instance = nil;

+ (PlanViewController *)sharedInstance
{
    @synchronized(self) {
        if ( g_instance == nil ) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            g_instance = [mainStoryboard instantiateViewControllerWithIdentifier: @"Plan"];
        }
    }
    return g_instance;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    g_instance = self;
    
    NSString* authKey = [ProfileViewController getAuthKey];
    NSLog(@"authKey : %@", authKey);
    
    NSDictionary* userInfo = [ProfileViewController getUserProfileWithAuthKey:authKey];

    ridePlans = [userInfo objectForKey:@"ridePlans"];
    NSLog(@"%d", [ridePlans count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SlideNavigationController Methods -

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [ridePlans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* plan = [ridePlans objectAtIndex:indexPath.row];
    NSLog(@"plan : %@", plan);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cells"];
    }
    
    NSString* name = [plan objectForKey:@"name"];
    NSLog(@"%@", name);
    
    cell.textLabel.text = name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    PlanModel *model = [[PlanModel alloc]init];
    NSDictionary *plan = [ridePlans objectAtIndex:row];
    
    model.name = (NSString*)[plan objectForKey:@"name"];

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    SelectPlanViewController *vc;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"SelectPlan"];
    [vc setModel:model];
    [self.navigationController pushViewController:vc animated:YES];
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
