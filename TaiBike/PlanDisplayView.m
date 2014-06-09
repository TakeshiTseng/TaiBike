//
//  HomePagePlanTableView.m
//  TaiBike
//
//  Created by elmer on 2014/6/8.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "PlanDisplayView.h"
#import "PlanDisplayViewCell.h"
#import "PlanViewController.h"

@implementation PlanDisplayView

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
    int count = _data.count*2-1;
    return count<0?0:count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlanDisplayViewCell *c = [[PlanDisplayViewCell alloc]init];
    NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
    if (indexPath.row%2 == 0) {
        NSDictionary* point = _data[indexPath.row/2];
        [info setObject:@"point" forKey:@"mode"];
        [info setObject:point forKey:@"model"];
    }else{
        [info setObject:@"line" forKey:@"mode"];
        NSDictionary* pointA = _data[indexPath.row/2];
        NSDictionary* pointB = _data[indexPath.row/2+1];
        NSDate *dateA = [PlanViewController dateForRFC3339DateTimeString:(NSString*)[pointA objectForKey:@"time"]];
        NSDate *dateB = [PlanViewController dateForRFC3339DateTimeString:(NSString*)[pointB objectForKey:@"time"]];
        NSTimeInterval timeDifference = [dateB timeIntervalSinceDate:dateA];
        [info setObject:[NSString stringWithFormat:@"%.0f",timeDifference] forKey:@"Tdifference"];
    }
    [c setInfo:info];
    return c;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
