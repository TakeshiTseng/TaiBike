//
//  RecommendedEquipmentViewController.m
//  TaiBike
//
//  Created by elmer on 2014/6/6.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "RecommendedEquipmentViewController.h"
#import "EquipmentViewController.h"
#import "ITTSegement.h"

@interface RecommendedEquipmentViewController ()

@property (weak, nonatomic) IBOutlet UIView *innerView;

@end

@implementation RecommendedEquipmentViewController

static RecommendedEquipmentViewController *g_instance = nil;
NSMutableDictionary *recommendedEquipmentDictionary;
NSMutableArray *recommendedata=nil;
NSMutableArray *groupName=nil;

+ (RecommendedEquipmentViewController *)sharedInstance
{
    @synchronized(self) {
        if ( g_instance == nil ) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            g_instance = [mainStoryboard instantiateViewControllerWithIdentifier: @"RecommendedEquipment"];
        }
    }
    return g_instance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_viewSegmentedControl setSelectedSegmentIndex:1];
    
    groupName = [[NSMutableArray alloc]initWithObjects:@"人身物品", @"配件物品", @"食物飲水", @"簡易工具", @"其他裝備", nil];
    [self loadRecommendedEquipmentPlist];
    recommendedata = [self loadDataFromRecommendedEquipmentPlist];
    
    NSMutableDictionary* info = [[NSMutableDictionary alloc] init];
    [info setObject:@"Recommended" forKey:@"mode"];
    [info setObject:groupName forKey:@"group name"];

    NSLog(@"1");
    self.tableView.data = recommendedata;
    self.tableView.groupNames = groupName;
    NSLog(@"%i",recommendedata.count);
    
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    //    NSArray *items = @[@"ID", @"名稱", @"重量"];
    NSArray *items = @[@"名稱", @"重量"];
    ITTSegement *segment = [[ITTSegement alloc] initWithItems:items];
    segment.frame = CGRectMake(0, 0, 320, 40);
    segment.selectedIndex = 0;
    [segment addTarget:self action:@selector(sgAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.innerView addSubview:segment];
}

#pragma mark - SlideNavigationController Methods -


- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadRecommendedEquipmentPlist
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains
                          (NSDocumentDirectory,NSUserDomainMask, YES)
                          objectAtIndex:0];
    
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Equipment.plist"];
    
    plistPath = [[NSBundle mainBundle] pathForResource:@"RecommendedEquipment" ofType:@"plist"];
    recommendedEquipmentDictionary = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    NSLog(@"load plist success");
}

- (NSMutableArray*)loadDataFromRecommendedEquipmentPlist
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    for (int i =0; i<5; i++) {
        NSString* key;
        switch (i) {
            case 0:
                key = @"personal item";
                break;
            case 1:
                key = @"accessories item";
                break;
            case 2:
                key = @"diet";
                break;
            case 3:
                key = @"tool";
                break;
            case 4:
                key = @"other";
                break;
        }
        
        NSMutableDictionary* group = (NSMutableDictionary*) [recommendedEquipmentDictionary objectForKey:key];
        int len = [(NSString*)[group objectForKey:@"default length"]intValue];
        NSMutableArray *groupData = [[NSMutableArray alloc]init];
        for (int c=1; c<=len; c++) {
            NSMutableDictionary *item = (NSMutableDictionary*)[group objectForKey:[NSString stringWithFormat:@"%i",c]];
            int ID = i;
            NSString *name = [item objectForKey:@"name"];
            NSString *msg = [item objectForKey:@"msg"];
            int gram = [[item objectForKey:@"gram"]intValue];
            
            EquipmentModel *model = [[EquipmentModel alloc]init];
            model.equipmentID=ID;
            model.name=name;
            model.msg=msg;
            model.gram=gram;
            [groupData addObject:model];
        }
        [data addObject:groupData];
    }
    NSLog(@"%i",[data count]);
    return data;
}

-(void)sgAction:(ITTSegement *)sg
{
    NSLog(@"%d %d", sg.selectedIndex, sg.currentState);
    
    NSMutableArray *data = self.tableView.data;
    
    
    
    for (int i=0;i<5;i++) {
        NSArray *group = [data objectAtIndex:i];
        
        for (EquipmentModel *model in group) {
            if (sg.currentState == UPStates) {
                model.isUp = YES;
            } else {
                model.isUp = NO;
            }
        }
        
        if (sg.selectedIndex == 1) {
            group = [group sortedArrayUsingSelector:@selector(compareName:)];
        } else {
            group = [group sortedArrayUsingSelector:@selector(comparegram:)];
        }
        [data removeObjectAtIndex:i];
        [data insertObject:group atIndex:i];
    }
    
    self.tableView.data = data;
    [self.tableView reloadData];
}


- (IBAction)segmentedValueChange:(id)sender {
    [[EquipmentViewController sharedInstance]segmentedValueChange:sender];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
