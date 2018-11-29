//
//  DashBoardViewController.m
//  PatientHealth
//

#import "DashBoardViewController.h"
#import "ActivityDashboardView.h"
#import "MedicineDashboardView.h"
#import "FoodDashboardView.h"
#import "SlideNavigationController.h"
#import "AddActivityViewController.h"
#import "ActivityListViewController.h"
#import "MedicineListViewController.h"

@interface DashBoardViewController ()
@property (nonatomic ,weak) ActivityDashboardView *dashboardActivity;
@property (nonatomic ,weak) MedicineDashboardView *dashboardMedicine;
@property (nonatomic ,weak) FoodDashboardView *dashboardFood;

@end

@implementation DashBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self init];
}

-(void)init{
    self.navigationItem.title = @"Dashboard";
    self.segmentControlDashboard.tintColor = [UIColor whiteColor];
    [self setCustomNavigationBackButton];
    self.segmentControlDashboard.selectedSegmentIndex = 0;
    //self.strAddMoreView=@"Activity";
    [self removeAllSubviews];
}

-(void)viewDidAppear:(BOOL)animated{
    self.strAddMoreView=@"Activity";
    [super viewDidAppear:animated];
    [self loadActivityDashboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadActivityDashboard{
    _dashboardActivity = [[[NSBundle mainBundle] loadNibNamed:@"ActivityDashboard" owner:self options:nil] lastObject];
    
    [self removeViewsIfAdded];
    [_containerView addSubview:_dashboardActivity];
    [self setConstraints:_dashboardActivity];
    //[self setDataForActivityView];
}

-(void)loadMedicineDashboard{
    _dashboardMedicine = [[[NSBundle mainBundle] loadNibNamed:@"MedicineDashboard" owner:self options:nil] lastObject];
    
    [self removeViewsIfAdded];
    [_containerView addSubview:_dashboardMedicine];
    [self setConstraints:_dashboardMedicine];
    //[self setDataForMedicineView];
}

-(void)loadFoodDashboard{
    _dashboardFood = [[[NSBundle mainBundle] loadNibNamed:@"FoodDashboard" owner:self options:nil] lastObject];
    
    [self removeViewsIfAdded];
    [_containerView addSubview:_dashboardFood];
    [self setConstraints:_dashboardFood];
}

-(void)setConstraints:(UIView *)viewName{
    viewName.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeTop multiplier:1 constant:0];//300
    
    //NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeWidth multiplier:1 constant:400];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
   // NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeHeight multiplier:1 constant:420];
    
     NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]; //420
    
//    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:viewName attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_containerView attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [_containerView addConstraints:@[leadingConstraint,topConstraint,widthConstraint,heightConstraint]];
    
    NSLog(@"ContainerView : %@ and %@ : %@",NSStringFromCGSize(_containerView.frame.size),viewName,NSStringFromCGSize(viewName.frame.size));
    
}

- (IBAction)onSegmentClick:(id)sender {
    NSInteger selectedSegment = [sender selectedSegmentIndex];
    if (selectedSegment == 0) {
        [self loadActivityDashboard];
        self.strAddMoreView=@"Activity";
    }else if (selectedSegment == 1){
        [self loadMedicineDashboard];
       self.strAddMoreView=@"Medicine";
     }else if (selectedSegment == 2){
        [self loadFoodDashboard];
        self.strAddMoreView=@"Food";
    }
}

- (void)setCustomNavigationBackButton
{
    UIImage *temp = [[UIImage imageNamed:@"Menu-icon"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:temp style:UIBarButtonItemStylePlain target:self action:@selector(sideDrawerAction)];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    self.navigationItem.leftBarButtonItem.width= -16;
}

-(void)sideDrawerAction{
    static Menu menu = MenuLeft;
    
    [[SlideNavigationController sharedInstance] openMenu:menu withCompletion:nil];
    
    menu = MenuLeft;
    
}


- (IBAction)onAddButtonClick:(id)sender {
    if ([self.strAddMoreView isEqualToString:@"Activity"])
    {
           [self performSegueWithIdentifier:@"addActivitySegue" sender:self];
    }
    if ([self.strAddMoreView isEqualToString:@"Medicine"])
    {
          [self performSegueWithIdentifier:@"addMedicineSegue" sender:self];
    }
    if ([self.strAddMoreView isEqualToString:@"Food"])
    {
        [self performSegueWithIdentifier:@"addFoodSegue" sender:self];
    }
    
}

//-(void) setDataForActivityView{
//    self.dashboardActivity.lblCurrentWeight.text = [self appendUnitText:[[NSUserDefaults standardUserDefaults] stringForKey:@"CurrentWeight"] :@"Kg"];
//    self.dashboardActivity.lblTargetWeight.text = [self appendUnitText:[[NSUserDefaults standardUserDefaults] stringForKey:@"TargetWeight"]: @"Kg"];
//    self.dashboardActivity.lblCurrentRunning.text = [self appendUnitText:[[NSUserDefaults standardUserDefaults] stringForKey:@"CurrentRunning"] :@"Km"];
//    self.dashboardActivity.lblTagetRunning.text = [self appendUnitText:[[NSUserDefaults standardUserDefaults] stringForKey:@"TagetRunning"] :@"Km"];
//    self.dashboardActivity.lblCurrentSteps.text = [self appendUnitText:[[NSUserDefaults standardUserDefaults] stringForKey:@"CurrentSteps"] :@"Steps"];
//    self.dashboardActivity.lblTargetSteps.text = [self appendUnitText:[[NSUserDefaults standardUserDefaults] stringForKey:@"TargetSteps"] :@"Steps"];
//}
//
//-(void) setDataForMedicineView{
//    self.dashboardMedicine.lblMorningConsumed.text = [[NSUserDefaults standardUserDefaults]stringForKey:@"MorningConsumed"];
//}

-(NSMutableString *)appendUnitText:(NSString *)valueString :(NSString *)unitString{
    NSMutableString *aMutStr = [[NSMutableString alloc] init];
    if(valueString != nil && unitString != nil){
    [aMutStr setString:valueString];
    [aMutStr appendString:unitString];
    }else{
        NSLog(@"No data passed");
    }
    return aMutStr;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self removeAllSubviews];
}

-(void) removeAllSubviews{
    [_dashboardActivity removeFromSuperview];
    [_dashboardFood removeFromSuperview];
    [_dashboardMedicine removeFromSuperview];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    AddActivityViewController *addActivityViewController = segue.destinationViewController;
//    addActivityViewController.data = self.strAddMoreView;
//}

-(void) removeViewsIfAdded{
    [_dashboardActivity removeFromSuperview];
    [_dashboardFood removeFromSuperview];
    [_dashboardMedicine removeFromSuperview];
}
- (IBAction)calenderViewButton:(id)sender {
}
@end
