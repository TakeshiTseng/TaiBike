//
//  LeftNavViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "LeftNavViewController.h"
#import "Source/SlideNavigationController.h";
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
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
	UIViewController *vc;
    
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
			break;
		case 2:
			break;
        case 3:
			break;
        case 4:
            [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
			[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
			return;
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
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
