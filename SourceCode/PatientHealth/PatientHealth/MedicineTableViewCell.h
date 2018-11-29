//
//  MedicineTableViewCell.h
//  PatientHealth
//
//  Created by VM  on 02/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KNCirclePercentView.h"
#import "Medicine+CoreDataClass.h"
@class MedicineTableViewCell;
@protocol MedicineTableViewCellProtocol <NSObject>
-(void)didPressedTabButtonOnCell:(MedicineTableViewCell *)cell tabButton:(UIButton *)button medicine:(Medicine *)medicine;
//-(void)fillPercentageInProgress:(MedicineTableViewCell *)cell progressBar:(KNCirclePercentView *)progressbar;
@end

@interface MedicineTableViewCell : UITableViewCell
+ (NSString *)reuseIdentifier;

-(void)setDosage:(NSArray*)dosageAry forMedicine:(Medicine*)medicine forIndexPath:(NSIndexPath*)indexPath;

@property (weak, nonatomic) IBOutlet UILabel *dosageNaturelbl;
@property (weak,nonatomic) id<MedicineTableViewCellProtocol> delegate;
@property (weak, nonatomic) IBOutlet UILabel *tabletNamelbl;
@property (weak, nonatomic) IBOutlet UILabel *diseaseNamelbl;
@property (weak, nonatomic) IBOutlet KNCirclePercentView *progressBarView;
@property (weak, nonatomic) IBOutlet UILabel *dosagelbl;
@property (weak, nonatomic) IBOutlet UILabel *consumedlbl;
@property (weak, nonatomic) IBOutlet UILabel *consumednamelbl;
@property (weak, nonatomic) IBOutlet UILabel *dosagenamelbl;
@property (strong, nonatomic) Medicine *medicine;
@end
