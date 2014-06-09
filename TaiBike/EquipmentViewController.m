//
//  EqupmentViewController.m
//  TaiBike
//
//  Created by Takeshi on 2014/5/27.
//  Copyright (c) 2014年 Takeshi. All rights reserved.
//

#import "EquipmentViewController.h"
#import "ITTSegement.h"
#import "ModifyEquipmentViewController.h"
#import "RecommendedEquipmentViewController.h"
#import "ProfileViewController.h"

@interface EquipmentViewController (){
    IBOutlet UILabel *gramLabel, *unitLabel;
    IBOutlet UISegmentedControl *viewSegmentedControl;
}

@property (weak, nonatomic) IBOutlet UIView *innerView;

@end

@implementation EquipmentViewController

NSMutableDictionary *equipmentDictionary;
int IDCount=0;
static EquipmentViewController *g_instance = nil;
NSMutableArray *_data=nil;
NSMutableArray *indexs;

+ (EquipmentViewController *)sharedInstance
{
    @synchronized(self) {
        if ( g_instance == nil ) {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            g_instance = [mainStoryboard instantiateViewControllerWithIdentifier: @"Equpment"];
            g_instance.current = g_instance;
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
    
    [self initBoundButton];
    
    [self loadEquipmentPlist];
    [self loadParameterFromEquipmentPlist];
    
    _data = [self loadDataFromEquipmentPlist];
    
    self.tableView.data = _data;
    
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    //    NSArray *items = @[@"ID", @"名稱", @"重量"];
    NSArray *items = @[@"重量計算", @"名稱", @"重量"];
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
        case 2://clear
            [self clearbtn:nil];
            break;
        case 1://sync
            [self syncEquipment];
            break;
        default:
            break;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
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
        data = [data sortedArrayUsingSelector:@selector(compareSelect:)];
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
    NSLog(@"%@",equipmentDictionary);
    
    for (int i = 0; i<length; i++) {
        NSString *key = [indexs objectAtIndex:i];
        
        NSMutableDictionary *item = (NSMutableDictionary*)[equipmentDictionary objectForKey:key];
        NSString *name = [item objectForKey:@"name"];
        NSString *description = [item objectForKey:@"description"];
        int gram = [[item objectForKey:@"weight"]intValue];
        BOOL isSelect = [(NSString*)[item objectForKey:@"select"] isEqualToString:@"YES"];
        BOOL isSync = [(NSString*)[item objectForKey:@"sync"] isEqualToString:@"YES"];
        NSMutableArray *weather = [item objectForKey:@"weather"];
        
        EquipmentModel *model = [[EquipmentModel alloc]init];
        model.equipmentID = key;
        model.name = name;
        model.description = description;
        model.gram = gram;
        model.isSelsct = isSelect;
        model.isSync = isSync;
        model.weather = weather;
        
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
    NSMutableArray *delIndexs = [NSMutableArray array];
    [equipmentDictionary setObject:indexs forKey:@"indexs"];
    [equipmentDictionary setObject:delIndexs forKey:@"delIndexs"];
    [equipmentDictionary setObject:@"0" forKey:@"length"];
    [equipmentDictionary setObject:@"0" forKey:@"IDCount"];
    
    [self storeEquipmentPlist];
}

-(IBAction)clearbtn:(id)sender
{
    [self initEquiomentPlist];
    indexs = [[NSMutableArray alloc]init];
    [_data removeAllObjects];
    self.tableView.data =_data;
    [self.tableView reloadData];
    [self calculateWeight];
}

-(IBAction)addbtn:(id)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ModifyEquipmentViewController *vc;
    
    vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"ModifyEquipment"];
    NSMutableDictionary* info = [[NSMutableDictionary alloc] init];
    [info setObject:@"new" forKey:@"mode"];
    [vc setInfo:info];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)addItem:(EquipmentModel*) model
{
    model.equipmentID = [NSString stringWithFormat:@"%i",++IDCount];
    model.isSync = NO;
    [indexs addObject:[NSString stringWithFormat:@"%i",IDCount]];
    [self addItemToEquipmentPlist:model];
    [(NSMutableArray*)self.tableView.data addObject:model];
    _data = (NSMutableArray*)self.tableView.data;
    [self.tableView reloadData];
}

-(void)addItemToEquipmentPlist:(EquipmentModel*)model
{
    NSString *IDCountString =[NSString stringWithFormat:@"%i",IDCount];
    NSMutableDictionary* data = [[NSMutableDictionary alloc]init];
    [data setObject:model.name forKey:@"name"];
    [data setObject:model.description forKey:@"description"];
    [data setObject:[NSString stringWithFormat:@"%i",model.gram] forKey:@"weight"];
    [data setObject:model.weather forKey:@"weather"];
    if(model.isSelsct){
        [data setObject:@"YES" forKey:@"select"];
    }else{
        [data setObject:@"NO" forKey:@"select"];
    }

    if (model.isSync) {
        [data setObject:@"YES" forKey:@"sync"];
    }else{
        [data setObject:@"NO" forKey:@"sync"];
    }
    
    NSString *length =[NSString stringWithFormat:@"%i",[indexs count]];
    [equipmentDictionary setObject:data forKey:model.equipmentID];
    [equipmentDictionary setObject:indexs forKey:@"indexs"];
    [equipmentDictionary setObject:length forKey:@"length"];
    [equipmentDictionary setObject:IDCountString forKey:@"IDCount"];
    
    [self storeEquipmentPlist];
}

-(void)modiflyItem:(EquipmentModel*) model
{
    model.isSync = NO;
    [self addItemToEquipmentPlist:model];
    NSInteger row = [self.tableView.data indexOfObject:model];
    [(NSMutableArray*)self.tableView.data removeObjectAtIndex:row];
    [(NSMutableArray*)self.tableView.data insertObject:model atIndex:row];
    _data = (NSMutableArray*)self.tableView.data;
    [self.tableView reloadData];
}

- (void)removeItem:(EquipmentModel*) model
{
    if (model.isSync) {
        NSMutableArray* del = [equipmentDictionary objectForKey:@"delIndexs"];
        [del addObject:model.equipmentID];
        [equipmentDictionary setObject:del forKey:@"delIndexs"];
    }
    
    [indexs removeObject:model.equipmentID];
    [self removeItemToEquipmentPlist:model];
    
    NSInteger row = [self.tableView.data indexOfObject:model];
    [(NSMutableArray*)self.tableView.data removeObjectAtIndex:row];
    _data = (NSMutableArray*)self.tableView.data;
    [self.tableView reloadData];
    [self calculateWeight];
}

- (void)removeItemToEquipmentPlist:(EquipmentModel*) model
{
    NSString *indexString =model.equipmentID;
    [equipmentDictionary removeObjectForKey:indexString];
    
    NSString *length =[NSString stringWithFormat:@"%i",[indexs count]];
    [equipmentDictionary setObject:indexs forKey:@"indexs"];
    [equipmentDictionary setObject:length forKey:@"length"];
    
    [self storeEquipmentPlist];
}

- (void)syncEquipment
{
    //upload
    NSMutableArray *syncmodels = [[NSMutableArray alloc]init];
    for (EquipmentModel *model in _data) {
        if (!model.isSync) {
            [syncmodels addObject:model];
        }
    }
    
    //download
    NSString *loadRootPath = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString *loadPath = [loadRootPath stringByAppendingPathComponent:@"user.plist"];
    NSMutableDictionary* dict = [ [ NSMutableDictionary alloc ] initWithContentsOfFile:loadPath ];
    NSString* authKey = [ dict objectForKey:@"authKey" ];
    
    NSArray *equipments = [EquipmentViewController getUserEquipmentsWithAuthKey:authKey];
    for (NSDictionary *data in equipments) {
        EquipmentModel *model = [[EquipmentModel alloc]init];
        model.equipmentID = [data objectForKey:@"_id"];
        NSLog(@"%i",(int)[indexs indexOfObject:model.equipmentID]);
        if ((int)[indexs indexOfObject:model.equipmentID]!=NSNotFound) {
            continue;
        }
        
        model.name = [data objectForKey:@"name"];
        model.description = [data objectForKey:@"description"];
        model.gram = [(NSString*)[data objectForKey:@"weight"]intValue];
        model.weather =(NSMutableArray*)[data objectForKey:@"weather"];
        model.isSync = YES;
        model.isSelsct = NO;
        
        [indexs addObject:model.equipmentID];
        [self addItemToEquipmentPlist:model];
        [(NSMutableArray*)self.tableView.data addObject:model];
    }
    _data = (NSMutableArray*)self.tableView.data;
    [self.tableView reloadData];
}

-(void)calculateWeight
{
    float total = 0;
    for (EquipmentModel *modle in _data) {
        if(modle.isSelsct){
            total+=modle.gram;
        }
    };
    
    if(total >=1000){
        total=total/1000;
        unitLabel.text = @"公斤";
    }else{
        unitLabel.text = @"公克";
    }
    
    gramLabel.text = [NSString stringWithFormat:@"%.1f",total];
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
                                   self.menuItemView.menuItem2,self.menuItemView.menuItem3,
                                   nil]; // Add all of the defined 'menu item button' to 'menu item view'
    [self.menuItemView addBounceButtons:arrMenuItemButtons];
    
    // Set the bouncing distance, speed and fade-out effect duration here. Refer to the ASOBounceButtonView public properties
    [self.menuItemView setBouncingDistance:[NSNumber numberWithFloat:0.7f]];
    
    // Set as delegate of 'menu item view'
    [self.menuItemView setDelegate:self];
}

+ (NSArray*)getUserEquipmentsWithAuthKey:(NSString*)authKey {
    NSString* url = [NSString stringWithFormat:@"https://taibike.tw/api/user/info?authKey=%@", authKey];
    NSError *error;
    NSURLResponse *urlResponse = nil;
    NSURLRequest* request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:url]];
    NSData* requestData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingMutableLeaves error:&error];
    return [[res objectForKey:@"info"]objectForKey:@"equipments"];
}

- (IBAction)segmentedValueChange:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl*)sender;
    NSInteger i = [segmentedControl selectedSegmentIndex];
    UIViewController *vc;
    
    switch (i) {
        default:
        case 0:
            vc = [EquipmentViewController sharedInstance];
            _current = vc;
            break;
        case 1:
            vc = [RecommendedEquipmentViewController sharedInstance];
            _current = vc;
            break;
    }
    [self performSelectorOnMainThread:@selector(refreshSegmentedControl:) withObject:[[NSNumber alloc]initWithInt:i] waitUntilDone:YES];
    
    //    [self setNeedsStatusBarAppearanceUpdate];
    //    [[RecommendedEquipmentViewController sharedInstance].view setNeedsDisplay];
    
    SlideNavigationController *navigationController = [SlideNavigationController sharedInstance];
    [navigationController popToRootAndSwitchToViewController:vc withSlideOutAnimation:NO andCompletion:nil];
}

-(void)refreshSegmentedControl:(id)index
{
    NSNumber *number = (NSNumber*)index;
    int i = [number intValue];
    [viewSegmentedControl setSelectedSegmentIndex:i];
    [[RecommendedEquipmentViewController sharedInstance].viewSegmentedControl setSelectedSegmentIndex:i];
}

@end
