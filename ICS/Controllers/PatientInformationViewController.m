//
//  PatientInformationViewController.m
//  ICS
//
//  Created by aam-fueled on 09/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PatientInformationViewController.h"

@implementation PatientInformationViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  [self setupForm];
  return self;
}


- (void)setupForm {
  XLFormDescriptor *form = [XLFormDescriptor formDescriptorWithTitle:@"Patient Information"];
  XLFormSectionDescriptor *section;
  XLFormRowDescriptor *row;
  
  self.form = form;
}

@end
