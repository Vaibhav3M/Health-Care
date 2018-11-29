//
//  BPReport+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "BPReport+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface BPReport (CoreDataProperties)

+ (NSFetchRequest<BPReport *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSNumber *hyper;
@property (nullable, nonatomic, copy) NSNumber *hypo;
@property (nullable, nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
