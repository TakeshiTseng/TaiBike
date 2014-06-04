//
//  EquipmentCell.m
//  TaiBike
//
//  Created by elmer on 2014/6/1.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "EquipmentCell.h"
#import "EquipmentViewController.h"

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
    [carrySwitch setOn:_model.isSelsct];
    [carrySwitch addTarget:self action:@selector(selectCarry) forControlEvents:UIControlEventTouchUpInside];
    
    //2
    nameLabel.frame = CGRectMake(width+10, 5, width-20, 30);
    nameLabel.text = [NSString stringWithFormat:@"%@", _model.name];
    
    gramLabel.frame = CGRectMake(2*width+10, 5, width-20, 30);
    if(_model.gram>=1000){
        float g = _model.gram/1000.0;
        gramLabel.text = [NSString stringWithFormat:@"%.2f kg", g];
    }else{
        gramLabel.text = [NSString stringWithFormat:@"%i g", _model.gram];
    }
}

- (void)selectCarry
{
    _model.isSelsct = !_model.isSelsct;
    [[EquipmentViewController sharedInstance] modiflyItem:_model];
    [carrySwitch setOn:_model.isSelsct];
}

@end