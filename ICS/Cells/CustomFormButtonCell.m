//
//  CustomFormButtonCell.m
//  ICS
//
//  Created by aqsa-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "CustomFormButtonCell.h"

NSString *const kAssignDoctorButtonTitle = @"Assign Doctor";
NSString *const XLFormRowDescriptorTypeCustomButton = @"XLFormRowDescriptorTypeCustomButton";

@implementation CustomFormButtonCell

+ (void)load {
  [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([CustomFormButtonCell class])
                                                            forKey:XLFormRowDescriptorTypeCustomButton];
  
}

- (void)awakeFromNib {
  [super awakeFromNib];
}

- (void)configure {
  [super configure];
}

- (void)update {
  [super update];
  [self initialSetup];
}

- (void)initialSetup {
  self.buttonType = (CustonFormButtonType)self.rowDescriptor.value;
  switch (self.buttonType) {
    case kButtonTypeAddRow:
      self.buttonImageView.image = [UIImage imageNamed:@"addIcon"];
      break;
    case kButtonTypeAssignDoctor:
      self.buttonImageView.image = [UIImage imageNamed:@"image2"];
      break;
    default:
      break;
  }
}

- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
  [super formDescriptorCellDidSelectedWithFormController:controller];
}

@end
