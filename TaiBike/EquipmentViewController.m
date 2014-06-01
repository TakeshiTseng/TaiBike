//
//  EqupmentViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "EquipmentViewController.h"
#import "ITTSegement.h"
#import "EquipmentTableView.h"
#import "EquipmentModel.h"

@interface EquipmentViewController ()
@property (weak, nonatomic) IBOutlet UIView *innerView;
@property (weak, nonatomic) IBOutlet EquipmentTableView *tableView;

@end

@implementation EquipmentViewController

NSMutableDictionary *equipmentDictionary;
int IDCount=0;
static EquipmentViewController *g_instance = nil;
NSMutableArray *data=nil;

+ (EquipmentViewController *)sharedInstance
{
    @synchronized(self) {
        if ( g_instance == nil ) {
            g_instance = [[self alloc] init];
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
    
    [self loadEquipmentPlist];
    [self loadParameterFromEquipmentPlist];
    
    data = [self loadDataFromEquipmentPlist];
    
    self.tableView.data = data;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    NSArray *items = @[@"ID", @"名稱", @"重量"];
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

-(void)sgAction:(ITTSegement *)sg
{
    NSLog(@"%d %d", sg.selectedIndex, sg.currentState);
    
    NSArray *data = self.tableView.data;
    
    for (EquipmentModel *model in data) {
        if (sg.currentState == UPStates) {
            model.isUp = YES;
        } else {
            model.isUp = NO;
        }
    }
    
    if (sg.selectedIndex == 0) {
        data = [data sortedArrayUsingSelector:@selector(compareID:)];
    } else if (sg.selectedIndex == 1) {
        data = [data sortedArrayUsingSelector:@selector(compareName:)];
    } else {
        data = [data sortedArrayUsingSelector:@selector(comparegram:)];
    }
    
    self.tableView.data = data;
    [self.tableView reloadData];
}

-(NSMutableArray*)loadDataFromEquipmentPlist
{
    NSMutableArray *data = [NSMutableArray array];
    NSArray *indexs =(NSArray*)[equipmentDictionary objectForKey:@"indexs"];
    NSString *length =(NSString*) [equipmentDictionary objectForKey:@"length"];
    
    NSLog(@"%@",indexs);
    NSLog(@"%@",[NSString stringWithFormat:@"%i",[indexs count]]);
    
//    for (int i = 0; i < 20; i++) {
//        int num1 = rand()%100 * i;
//        int num2 = 100 - rand()%5 * i;
//        int num3 = rand()%50;
//        ITTModel *model = [[ITTModel alloc] init];
//        model.number1 = num1;
//        model.number2 = num2;
//        model.number3 = num3;
//        [data addObject:model];
//    }
    EquipmentModel *model = [[EquipmentModel alloc]init];
    model.equipmentID = 1;
    model.name = @"水";
    model.gram = 1800;
    [data addObject:model];
    return data;
}

-(void)loadParameterFromEquipmentPlist
{
    IDCount = [[equipmentDictionary objectForKey:@"IDCount"]integerValue];
}

-(void)loadEquipmentPlist
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains
                          (NSDocumentDirectory,NSUserDomainMask, YES)
                          objectAtIndex:0];
    
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Equipment.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        NSLog(@"Initialization equipment list.");
        [self initEquiomentPlist];
    }else{
        equipmentDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    NSLog(@"%@",equipmentDictionary);
}

-(void)storeEquipmentPlist
{
    NSString *SaveRootPath = [NSSearchPathForDirectoriesInDomains
                              (NSDocumentDirectory,NSUserDomainMask, YES)
                              objectAtIndex:0];
    NSString *SavePath = [SaveRootPath stringByAppendingPathComponent:@"Equipment.plist"];
    
    [equipmentDictionary writeToFile:SavePath atomically:YES];
}

-(void)initEquiomentPlist
{
    equipmentDictionary = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *indexs = [NSMutableArray array];
    [equipmentDictionary setObject:indexs forKey:@"indexs"];
    [equipmentDictionary setObject:@"0" forKey:@"length"];
    [equipmentDictionary setObject:@"0" forKey:@"IDCount"];
    
    [self storeEquipmentPlist];
}

-(IBAction)clearbtn:(id)sender
{
    [self initEquiomentPlist];
}

-(IBAction)delete:(id)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *SaveRootPath = [NSSearchPathForDirectoriesInDomains
                              (NSDocumentDirectory,NSUserDomainMask, YES)
                              objectAtIndex:0];
    NSString *SavePath = [SaveRootPath stringByAppendingPathComponent:@"Equipment.plist"];
    [fileManager removeItemAtPath:SavePath error:nil];
}

-(IBAction)addTest:(id)sender
{
    EquipmentModel *model = [[EquipmentModel alloc]init];
    model.name = @"水";
    model.gram = 1000;
    [data addObject:model];
    self.tableView.data=data;
    NSLog(@"%@",data);
    [self.tableView reloadData];
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
