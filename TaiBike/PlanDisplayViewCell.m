//
//  HomePagePlanTableViewCell.m
//  TaiBike
//
//  Created by elmer on 2014/6/8.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "PlanDisplayViewCell.h"

@implementation PlanDisplayViewCell{
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
    NSDictionary* point = (NSDictionary*)[_info objectForKey:@"model"];
    image.frame = CGRectMake(10, 0, 36, 36);
    [image setImage:[UIImage imageNamed:@"circle_blue.png"]];
    
    nameLabel.frame = CGRectMake(50, 3, 110, 30);
    nameLabel.text = [point objectForKey:@"name"];
    nameLabel.numberOfLines = 2;
    
    timeLabel.frame = CGRectMake(180, 3, 120, 30);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy'/'M'/'d' 'H':'mm"];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *timestr = [NSString stringWithFormat:@"預計抵達時間\n%@",[dateFormatter stringFromDate:[self dateForRFC3339DateTimeString:(NSString*)[point objectForKey:@"time"]]]];
    timeLabel.text = timestr;
    timeLabel.numberOfLines = 2;
    timeLabel.textColor = [UIColor blueColor];
}

-(void)lineLayout
{
    image.frame = CGRectMake(23, 5, 10, 26);
    [image setImage:[UIImage imageNamed:@"arrow.png"]];
    
    int tDifference = [(NSString*)[_info objectForKey:@"Tdifference"]integerValue]/60;
    tDifference = tDifference<1?1:tDifference;
    timeLabel.frame = CGRectMake(50, 3, 120, 30);
    
    NSString *timestr;
    if(tDifference>60){
        timestr = [NSString stringWithFormat:@"%i 小時 %i 分鐘",tDifference/60,tDifference%60];
    }else{
        timestr = [NSString stringWithFormat:@"%i 分鐘",tDifference];
    }
    
    timestr = [NSString stringWithFormat:@"時間差 : %@",timestr];
    timeLabel.text = timestr;
    timeLabel.textColor = [UIColor greenColor];
}

/*
 Info - NSDirectory
 [Mode] key:"mode" - NSString ,value:{point, line}
 [Model] key:"model" - point dinrectory
 [Time difference] key:"Tdifference" - NSDate
 */
-(void)setInfo:(id)info
{
    NSString *mode = [(NSDictionary*)info objectForKey:@"mode"];
    if ([mode isEqualToString:@"line"]) {
        _mode = @"line";
    }else{
        _mode = @"point";
    }
    _info = (NSDictionary*)info;
}

- (NSDate *)dateForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString {
    
	NSDateFormatter *rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    
	[rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
	[rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
	// Convert the RFC 3339 date time string to an NSDate.
	NSDate *result = [rfc3339DateFormatter dateFromString:rfc3339DateTimeString];
	return result;
}

@end
