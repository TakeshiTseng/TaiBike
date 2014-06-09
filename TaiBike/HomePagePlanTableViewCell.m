//
//  HomePagePlanTableViewCell.m
//  TaiBike
//
//  Created by elmer on 2014/6/8.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "HomePagePlanTableViewCell.h"

@implementation HomePagePlanTableViewCell{
    NSString *_mode;
    NSDictionary *_info;
    UILabel *nameLabel, *timeLabel, *arrivalTimeLabel;
    UIImageView *image;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initViews];
    }
    return self;
}

-(void)_initViews
{
    nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:timeLabel];
    
    arrivalTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    arrivalTimeLabel.font = [UIFont systemFontOfSize:12];
    arrivalTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:arrivalTimeLabel];
    
    image = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:image];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    if ([_mode isEqualToString:@"point"]) {
        [self pointLayout];
    }else if([_mode isEqualToString:@"line"]){
        [self lineLayout];
    }
}

-(void)pointLayout
{
    image.frame = CGRectMake(30, 0, 30, 30);
    [image setImage:[UIImage imageNamed:@"circle_blue.png"]];
    
    nameLabel.frame = CGRectMake(100, 5, 60, 20);
    nameLabel.text = [_info objectForKey:@"name"];
}

-(void)lineLayout
{
    image.frame = CGRectMake(30, 0, 30, 30);
    [image setImage:[UIImage imageNamed:@"arrow.png"]];
}

/*
 Info - NSDirectory
 [Mode] key:"mode" - NSString ,value:{point, line}
 [Model] key:"model" - point dinrectory
 */
-(void)setInfo:(id)info
{
    NSString *mode = [(NSDictionary*)info objectForKey:@"mode"];
    if ([mode isEqualToString:@"line"]) {
        _mode = @"line";
    }else{
        _mode = @"point";
        _info = (NSDictionary*)[(NSDictionary*)info objectForKey:@"model"];
    }
}

@end
