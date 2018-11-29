//
//  Medicine+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Medicine+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Medicine (CoreDataProperties)

+ (NSFetchRequest<Medicine *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *diseasename;
@property (nullable, nonatomic, copy) NSString *dosage;
@property (nullable, nonatomic, copy) NSString *enddate;
@property (nullable, nonatomic, copy) NSNumber *firstTabIfSelected;
@property (nullable, nonatomic, copy) NSNumber *fourthTabIfSelected;
@property (nullable, nonatomic, copy) NSString *fromdate;
@property (nullable, nonatomic, copy) NSString *medicinename;
@property (nullable, nonatomic, copy) NSNumber *medID;
@property (nullable, nonatomic, copy) NSNumber *secondTabIfSelected;
@property (nullable, nonatomic, copy) NSNumber *thirdTabIfSelected;

@end

NS_ASSUME_NONNULL_END
