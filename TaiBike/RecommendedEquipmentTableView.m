//
//  TableView.m
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "RecommendedEquipmentTableView.h"
#import "RecommendedEquipmentCell.h"
#import "ModifyEquipmentViewController.h"
#import "RecommendedEquipmentViewController.h"

@implementation RecommendedEquipmentTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initView];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self _initView];
}

-(void)_initView
{
    self.dataSource = self;
    self.delegate = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _groupNames.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_groupNames objectAtIndex:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSMutableArray*)[_data objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    RecommendedEquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[RecommendedEquipmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }

    cell.model = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EquipmentModel *model = [self.data[indexPath.section]objectAtIndex:indexPath.row];
    NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
    [info setObject:@"Recommended" forKey:@"mode"];
    [info setObject:model forKey:@"model"];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ModifyEquipmentViewController *vc;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ModifyEquipment"];
    [vc setInfo:info];
    [[RecommendedEquipmentViewController sharedInstance].navigationController pushViewController:vc animated:YES];
}

@end
