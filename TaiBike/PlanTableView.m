//
//  PlanTableView.m
//  TaiBike
//
//  Created by elmer on 2014/6/10.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "PlanTableView.h"
#import "PlanModel.h"
#import "SelectPlanViewController.h"
#import "PlanViewController.h"

@implementation PlanTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

-(void)_initView
{
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_ridePlans count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* plan = [_ridePlans objectAtIndex:indexPath.row];
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
    NSDictionary *plan = [_ridePlans objectAtIndex:row];
    
    model.name = (NSString*)[plan objectForKey:@"name"];
    model.points = (NSMutableArray*)[plan objectForKey:@"points"];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    SelectPlanViewController *vc;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"SelectPlan"];
    [vc setModel:model];
    [[PlanViewController sharedInstance].navigationController pushViewController:vc animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
