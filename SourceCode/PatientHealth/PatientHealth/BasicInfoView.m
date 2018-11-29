//
//  BasicInfoView.m
//  PatientHealth
//

#import "BasicInfoView.h"
#import "Header.h"
#import "Connection.h"
#import "CustomPicker.h"
@interface BasicInfoView(){
    UITextField *activeTextField;
    
}

@end


@implementation BasicInfoView
CGFloat animatedDistance;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.9;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 271;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self registerForKeyboardNotifications];
     }
    
    return self;
}

-(void)setupView{
    [self setTextFieldBorder:_txtFieldUsername];
    
//    _btnMale.layer.cornerRadius = CORNER_RADIUS;
//    _btnFemale.layer.cornerRadius = CORNER_RADIUS;
//    
//    _btnMale.layer.borderWidth = 5.0f;
//    _btnFemale.layer.borderWidth = 5.0f;
//    
//    _btnMale.layer.borderColor = [UIColor whiteColor].CGColor;
//    _btnFemale.layer.borderColor = [UIColor whiteColor].CGColor;
//    _strGender = @"Male";
    _strSmoking = @"No";
    
    _txtFieldSetPassword.secureTextEntry = YES;
    _txtFieldConfirmPassword.secureTextEntry = YES;
    
    NSLog(@"Scrollview content size =  %@",NSStringFromCGSize(_scrollView.contentSize));
    
}


- (void)registerForKeyboardNotifications
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [_scrollView setContentSize: CGSizeMake(self.frame.size.width, self.frame.size.height)];
     
     
    
}


// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    
    NSLog(@"_scrollView contentSize : %@",NSStringFromCGSize(_scrollView.contentSize));
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeTextField.frame.origin) ) {
        CGRect bkgndRect = activeTextField.superview.frame;
        bkgndRect.size.height += kbSize.height;
        [activeTextField.superview setFrame:bkgndRect];
        [_scrollView setContentOffset:CGPointMake(0.0, activeTextField.frame.origin.y-kbSize.height + 20) animated:YES];
    }
    
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
    [_scrollView setContentOffset:CGPointMake(0.0, 0) animated:YES];
}

#pragma mark - UITextfieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
    [self.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
    [self.window convertRect:self.bounds fromView:self];
    CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
    midline - viewRect.origin.y
    - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
    (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
    * viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
    if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
    
    CGRect viewFrame = self.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self setFrame:viewFrame];
    
    [UIView commitAnimations];

    //activeTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
   // activeTextField = nil;
    
    CGRect viewFrame = self.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self setFrame:viewFrame];
    
    [UIView commitAnimations];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        //[textField resignFirstResponder];
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}

#pragma mark - Actions
- (IBAction)btnCheckSmokingAction:(id)sender{
    [self setInputString:_btnCheckSmoking :_strSmoking];
//    [self initPicker];
}

- (IBAction)btnDrinkingAction:(id)sender {
    [self setInputString:_btnCheckDrinking :_strDrinking];
}

- (IBAction)btnDiabetiesAction:(id)sender {
    [self setInputString:_btnCheckDiabeties :_strDiabeties];
}

- (IBAction)btnBPAction:(id)sender {
    [self setInputString:_btnBloodPressure :_strBloodPressure];
}

- (IBAction)btnAsthmaAction:(id)sender {
    [self setInputString:_btnAsthma :_strAsthma];
}

- (IBAction)btnSaveAction:(id)sender {
}

- (IBAction)btnNextAction:(id)sender {
}

- (IBAction)btnHeartCondtnAction:(id)sender {
    [self setInputString:_btnHeartCondtn :_strHeartCondition];
}

-(void)setInputString:(UIButton*)currBtn :(NSString*)currStr {
    
    if(currBtn.isSelected == NO){
        [currBtn setSelected:YES];
        currStr = @"Yes";
        [currBtn setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateSelected];
    }else{
        [currBtn setSelected:NO];
        currStr = @"No";
        [currBtn setImage:[UIImage imageNamed:@"Uncheck.png"] forState:UIControlStateNormal];
    }
}

-(void)setTextFieldBorder:(UITextField *)textField{
    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor whiteColor]CGColor];
    textField.layer.borderWidth= 1.0f;
}

@end
