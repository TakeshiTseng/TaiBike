//
//  LeftNavViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "LeftNavViewController.h"

@implementation LeftNavViewController {
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftNavCell"];
	
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeftNavCell"];
    }
    
	switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"首頁";
			break;
			
		case 1:
			cell.textLabel.text = @"我的資料";
			break;
			
		case 2:
			cell.textLabel.text = @"我的裝備";
			break;
        case 3:
			cell.textLabel.text = @"路線記錄";
			break;
			
		case 4:
			cell.textLabel.text = @"登出";
			break;
	}
	
	return cell;
}



@end
