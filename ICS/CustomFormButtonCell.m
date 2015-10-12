//
//  CustomFormButtonCell.m
//  ICS
//
//  Created by aam-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "CustomFormButtonCell.h"

NSString *const kAssignDoctorButtonTitle = @"Assign Doctor";

@implementation CustomFormButtonCell

- (void)awakeFromNib {
  [super awakeFromNib];
}

- (void)initialSetup {
  switch (self.buttonType) {
    case kButtonTypeAddRow:
      self.buttonImageView.image = [UIImage imageNamed:@"addIcon"];
      break;
    case kButtonTypeAssignDoctor:
      self.buttonImageView.image = [UIImage imageNamed:@"image2"];
      break;
    case kButtonTypeRating:
      
      break;
    default:
      break;
  }
}

@end
