//
//  HomePagePlanTableView.m
//  TaiBike
//
//  Created by elmer on 2014/6/8.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "HomePagePlanTableView.h"
#import "HomePagePlanTableViewCell.h"

@implementation HomePagePlanTableView

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
    HomePagePlanTableViewCell *c = [[HomePagePlanTableViewCell alloc]init];
    NSMutableDictionary *info = [[NSMutableDictionary alloc]init];
    if (indexPath.row%2 == 0) {
        NSDictionary* point = _data[indexPath.row/2];
        [info setObject:@"point" forKey:@"mode"];
        [info setObject:point forKey:@"model"];
    }else{
        [info setObject:@"line" forKey:@"mode"];
    }
    [c setInfo:info];
    return c;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
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
