//
//  TableView.m
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "EquipmentTableView.h"
#import "EquipmentCell.h"
#import "EquipmentViewController.h"
#import "ModifyEquipmentViewController.h"

@implementation EquipmentTableView{
    NSMutableArray* groupNames;
}

int mode =1;

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


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellId";
    EquipmentCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[EquipmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    EquipmentModel *model = [self.data objectAtIndex:row];
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
    [info setObject:@"modifly" forKey:@"mode"];
    [info setObject:model forKey:@"model"];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ModifyEquipmentViewController *vc;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ModifyEquipment"];
    [vc setInfo:info];
    [[EquipmentViewController sharedInstance].navigationController pushViewController:vc animated:YES];
}

@end
