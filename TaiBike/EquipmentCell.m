//
//  EquipmentCell.m
//  TaiBike
//
//  Created by elmer on 2014/6/1.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "EquipmentCell.h"

@implementation EquipmentCell
{
    UILabel *idLabel, *nameLabel, *gramLabel;
    UISwitch *carrySwitch;
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
    //    idLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    //    idLabel.font = [UIFont systemFontOfSize:12];
    //    idLabel.textAlignment = NSTextAlignmentCenter;
    //    [self addSubview: idLabel];
    
    carrySwitch = [[UISwitch alloc]init];
    [self addSubview:carrySwitch];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    
    gramLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    gramLabel.font = [UIFont systemFontOfSize:12];
    gramLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:gramLabel];
}

-(void)setModel:(EquipmentModel *)model
{
    _model = model;
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    float width = self.bounds.size.width/3;
    
    //    idLabel.frame = CGRectMake(10, 5, width-20, 30);
    //    idLabel.text = [NSString stringWithFormat:@"%d", _model.equipmentID];
    
    //1
    carrySwitch.frame = CGRectMake(10, 5, width-20, 30);
    
    //2
    nameLabel.frame = CGRectMake(width+10, 5, width-20, 30);
    nameLabel.text = [NSString stringWithFormat:@"%@", _model.name];
    
    //3
    gramLabel.frame = CGRectMake(2*width+10, 5, width-20, 30);
    gramLabel.text = [NSString stringWithFormat:@"%i", _model.gram];
}

@end