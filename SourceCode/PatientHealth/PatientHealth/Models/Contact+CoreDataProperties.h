//
//  Contact+CoreDataProperties.h
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "Contact+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Contact (CoreDataProperties)

+ (NSFetchRequest<Contact *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *number;

@end

NS_ASSUME_NONNULL_END
