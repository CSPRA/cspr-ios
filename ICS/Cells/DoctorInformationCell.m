
//
//  DoctorInformationCell.m
//  ICS
//
//  Created by aam-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "DoctorInformationCell.h"

NSString * const XLFormRowDescriptorTypeRate = @"XLFormRowDescriptorTypeRate";

@implementation DoctorInformationCell

- (void)awakeFromNib {
  [super awakeFromNib];
}

+ (void)load {
  [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([DoctorInformationCell class])
                                                            forKey:XLFormRowDescriptorTypeRate];  
}

#pragma mark - Layout cell methods
- (void)configure
{
  [super configure];
  
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self.ratingView addTarget:self action:@selector(rateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)update
{
  [super update];
  self.doctor = [self.rowDescriptor.value objectForKey:@"doctorInfo"];
  self.delegate = [self.rowDescriptor.value objectForKey:@"delegateInfo"];
  self.ratingView.value = self.doctor.doctorRatingValue.intValue;
  self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",_doctor.firstName,_doctor.lastName];
  self.docInfoLabel.text = [NSString stringWithFormat:@"%@, %@",_doctor.specialization,_doctor.location];
  
  [self.ratingView setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
}

- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
  [super formDescriptorCellDidSelectedWithFormController:controller];
}

#pragma mark - Events

-(void)rateChanged:(RatingView *)ratingView
{
//  _doctor.ratingValue = [NSNumber numberWithInt:ratingView.value].floatValue;
  float ratingValue = [NSNumber numberWithInt:ratingView.value].floatValue;
  Volunteer *volunteer = [Volunteer fetchVolunteer];
  NSDictionary *params = @{
                           kUserId      : volunteer.volunteerId,
                           kRatingValue : @(ratingValue)
                           };
  [kDataSource giveDoctorRating:volunteer.token parameters:params completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
    if (success) {
      NSString *message = [NSString stringWithFormat:@"Doctor's rating updated to %d",_doctor.doctorRatingValue.intValue];
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
    }else if (error){
      NSString *message = @"Failed to update doctor's rating.";
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
    }
    self.ratingView.value = self.doctor.doctorRatingValue.intValue;
  }];

}

#pragma mark - IBActions

- (IBAction)assignButtonTapped:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(didAssignedDoctor:)]) {
    [self.delegate didAssignedDoctor:self];
  }
}

@end
