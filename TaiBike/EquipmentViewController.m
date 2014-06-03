//
//  EqupmentViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "EquipmentViewController.h"
#import "ITTSegement.h"
#import "ModiflyEquipmentViewController.h"

@interface EquipmentViewController (){
    IBOutlet UILabel *gramLabel, *unitLabel;
}
@property (weak, nonatomic) IBOutlet UIView *innerView;


@end

@implementation EquipmentViewController

NSMutableDictionary *equipmentDictionary;
int IDCount=0;
static EquipmentViewController *g_instance = nil;
NSMutableArray *data=nil;
NSMutableArray *indexs;

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
    g_instance =self;
    
    [self initBoundButton];
    
    [self loadEquipmentPlist];
    [self loadParameterFromEquipmentPlist];
    
    data = [self loadDataFromEquipmentPlist];
    
    self.tableView.data = data;
    
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    //    NSArray *items = @[@"ID", @"名稱", @"重量"];
    NSArray *items = @[@"攜帶", @"名稱", @"重量"];
    ITTSegement *segment = [[ITTSegement alloc] initWithItems:items];
    segment.frame = CGRectMake(0, 0, 320, 40);
    segment.selectedIndex = 0;
    [segment addTarget:self action:@selector(sgAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.innerView addSubview:segment];
    
    [self calculateWeight];
}

- (void)viewDidAppear:(BOOL)animated
{
    // Tell 'menu button' position to 'menu item view'
    [self.menuItemView setAnimationStartFromHere:self.menuButton.frame];
}

- (IBAction)menuButtonAction:(id)sender
{
    if ([sender isOn]) {
        // Show 'menu item view' and expand its 'menu item button'
        [self.menuButton addCustomView:self.menuItemView];
        [self.menuItemView expandWithAnimationStyle:ASOAnimationStyleExpand];
    }
    else {
        // Collapse all 'menu item button' and remove 'menu item view'
        [self.menuItemView collapseWithAnimationStyle:ASOAnimationStyleExpand];
        [self.menuButton removeCustomView:self.menuItemView interval:[self.menuItemView.collapsedViewDuration doubleValue]];
    }
}

#pragma mark - Menu item view delegate method

- (void)didSelectBounceButtonAtIndex:(NSUInteger)index
{
    // Collapse all 'menu item button' and remove 'menu item view' once a menu item is selected
    [self.menuButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // Set your custom action for each selected 'menu item button' here
    
    switch (index) {
        case 0://add
            [self addbtn:nil];
            break;
        case 1://clear
            [self clearbtn:nil];
            break;
        default:
            break;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:
(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    // Update 'menu button' position to 'menu item view' everytime there is a change in device orientation
    [self.menuItemView setAnimationStartFromHere:self.menuButton.frame];
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
    
    self.tableView.data = [[NSMutableArray alloc]initWithArray:data];
    [self.tableView reloadData];
}

-(NSMutableArray*)loadDataFromEquipmentPlist
{
    NSMutableArray *data = [NSMutableArray array];
    indexs =(NSMutableArray*)[equipmentDictionary objectForKey:@"indexs"];
    int length =[(NSString*) [equipmentDictionary objectForKey:@"length"]intValue];
    
    
    for (int i = 0; i<length; i++) {
        NSString *key = [indexs objectAtIndex:i];
        
        NSMutableDictionary *item = (NSMutableDictionary*)[equipmentDictionary objectForKey:key];
        int ID = [key intValue];
        NSString *name = [item objectForKey:@"name"];
        int gram = [[item objectForKey:@"gram"]intValue];
        
        EquipmentModel *model = [[EquipmentModel alloc]init];
        model.equipmentID=ID;
        model.name=name;
        model.gram=gram;
        
        [data addObject:model];
    }
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
    [data removeAllObjects];
    self.tableView.data =data;
    [self.tableView reloadData];
    [self calculateWeight];
}

-(IBAction)addbtn:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ModiflyEquipmentViewController *vc;
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ModiflyEquipment"];
    [vc setMode:@"new"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addItem:(EquipmentModel*) model
{
    model.equipmentID = ++IDCount;
    [self addItemToEquipmentPlist:model];
    [(NSMutableArray*)self.tableView.data addObject:model];
    data = (NSMutableArray*)self.tableView.data;
    [self.tableView reloadData];
    [self calculateWeight];
}

-(void)addItemToEquipmentPlist:(EquipmentModel*)model
{
    NSString *indexString =[NSString stringWithFormat:@"%i",model.equipmentID];
    NSString *IDCountString =[NSString stringWithFormat:@"%i",IDCount];
    NSMutableDictionary* data = [[NSMutableDictionary alloc]init];
    [data setObject:model.name forKey:@"name"];
    [data setObject:[NSString stringWithFormat:@"%i",model.gram] forKey:@"gram"];
    
    [indexs addObject:indexString];
    NSString *length =[NSString stringWithFormat:@"%i",[indexs count]];
    [equipmentDictionary setObject:data forKey:indexString];
    [equipmentDictionary setObject:indexs forKey:@"indexs"];
    [equipmentDictionary setObject:length forKey:@"length"];
    [equipmentDictionary setObject:IDCountString forKey:@"IDCount"];
    
    [self storeEquipmentPlist];
}

-(void)calculateWeight
{
    int total = 0;
    for (EquipmentModel *modle in data) {
        total+=modle.gram;
    }
    gramLabel.text = [NSString stringWithFormat:@"%i",total];
    
    if(total >=1000){
        unitLabel.text = @"公斤";
    }else{
        unitLabel.text = @"公克";
    }
}

- (void)initBoundButton
{
    // Set the 'menu button'
    [self.menuButton initAnimationWithFadeEffectEnabled:YES]; // Set to 'NO' to disable Fade effect between its two-state transition
    
    // Get the 'menu item view' from storyboard
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *menuItemsVC = (UIViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"EquipmentBoundButtonView"];
    self.menuItemView = (EquipmentBoundButtonView *)menuItemsVC.view;
    
    NSArray *arrMenuItemButtons = [[NSArray alloc] initWithObjects:self.menuItemView.menuItem1,
                                   self.menuItemView.menuItem2,
                                   nil]; // Add all of the defined 'menu item button' to 'menu item view'
    [self.menuItemView addBounceButtons:arrMenuItemButtons];
    
    // Set the bouncing distance, speed and fade-out effect duration here. Refer to the ASOBounceButtonView public properties
    [self.menuItemView setBouncingDistance:[NSNumber numberWithFloat:0.7f]];
    
    // Set as delegate of 'menu item view'
    [self.menuItemView setDelegate:self];
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
