//
//  CholestrolReport+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 11/30/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "CholestrolReport+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CholestrolReport (CoreDataProperties)

+ (NSFetchRequest<CholestrolReport *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSNumber *ldl;
@property (nullable, nonatomic, copy) NSNumber *hdl;
@property (nullable, nonatomic, copy) NSNumber *tdl;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *unit;

@end

NS_ASSUME_NONNULL_END
