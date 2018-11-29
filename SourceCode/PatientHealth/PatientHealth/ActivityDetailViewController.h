#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CustomPicker.h"

@interface ActivityDetailViewController : UIViewController<CustomPickerDelegate>
{
    int i;
}
@property (weak, nonatomic) IBOutlet UITextField *sessionTextField;
@property (weak, nonatomic) IBOutlet UITextField *activityTextField;
@property (weak, nonatomic) IBOutlet UITextField *targetTextField;
@property (weak, nonatomic) IBOutlet UITextField *currentTextField;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
@property (strong) NSMutableArray *activitydataedit;
@property (weak, nonatomic) IBOutlet UILabel *targetActivitylbl;
@property (weak, nonatomic) IBOutlet UILabel *currentActivitylbl;
@property (weak, nonatomic) IBOutlet UITextField *startDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *endDateTextField;
@property(weak,nonatomic)CustomPicker *startDatePicker;
@property(weak,nonatomic)CustomPicker *endDatePicker;
@property(weak,nonatomic)CustomPicker *activityPicker;
@property(weak,nonatomic)CustomPicker *activitySessionPicker;
@property NSString *dateFromCalender;
@end
