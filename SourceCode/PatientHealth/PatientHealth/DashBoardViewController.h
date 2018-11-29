//
//  DashBoardViewController.h
//  PatientHealth
//

#import <UIKit/UIKit.h>
@class NavigationBarButton;
@interface DashBoardViewController : UIViewController


- (IBAction)calenderViewButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (copy, nonatomic) NSString *strAddMoreView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *onSegmentClick;
- (IBAction)onSegmentClick:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControlDashboard;
- (IBAction)onAddButtonClick:(id)sender;
-(void)init;

@end
