//
//  EquipmentCell.m
//  TaiBike
//
//  Created by elmer on 2014/6/1.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "RecommendedEquipmentCell.h"
#import "EquipmentViewController.h"
#import "ModifyEquipmentViewController.h"

@implementation RecommendedEquipmentCell
{
    UILabel *idLabel, *nameLabel, *gramLabel, *msgLabel;
    UIButton *addbtn;
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
    
    addbtn = [[UIButton alloc]init];
    [self addSubview:addbtn];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.font = [UIFont systemFontOfSize:18];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:nameLabel];
    
    msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    msgLabel.font = [UIFont systemFontOfSize:14];
    msgLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:msgLabel];
    
    
    
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
    nameLabel.frame = CGRectMake(10, 5, 250, 20);
    nameLabel.text = [NSString stringWithFormat:@"%@", _model.name];
    //msg
    msgLabel.frame = CGRectMake(30, 25, 220, 30);
    msgLabel.text = [NSString stringWithFormat:@"%@",_model.msg];
    msgLabel.numberOfLines = 3;
    
    
    //2
    gramLabel.frame = CGRectMake(2*width+50, 15, 50, 30);
    if(_model.gram>=1000){
        float g = _model.gram/1000.0;
        gramLabel.text = [NSString stringWithFormat:@"%.2f kg", g];
    }else{
        gramLabel.text = [NSString stringWithFormat:@"%i g", _model.gram];
    }
}

@end