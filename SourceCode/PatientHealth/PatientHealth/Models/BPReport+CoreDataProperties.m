//
//  BPReport+CoreDataProperties.m
//  PatientHealth
//
//  Created by VM on 28/11/16.
//  Copyright © 2016 Vaibhav. All rights reserved.
//

#import "BPReport+CoreDataProperties.h"

@implementation BPReport (CoreDataProperties)

+ (NSFetchRequest<BPReport *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"BPReport"];
}

@dynamic date;
@dynamic hyper;
@dynamic hypo;
@dynamic userId;

@end
