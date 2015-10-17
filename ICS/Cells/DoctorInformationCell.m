
//
//  DoctorInformationCell.m
//  ICS
//
//  Created by aam-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "DoctorInformationCell.h"
#import "Doctor.h"

NSString * const XLFormRowDescriptorTypeRate = @"XLFormRowDescriptorTypeRate";

@interface DoctorInformationCell ()
@property (nonatomic, strong) Doctor *doctor;
@end

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
  self.ratingView.value = self.doctor.ratingValue;
  self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",_doctor.firstName,_doctor.lastName];
  self.docInfoLabel.text = [NSString stringWithFormat:@"%@, %@",_doctor.specialization,_doctor.address];
  
  [self.ratingView setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
}

- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller {
  [super formDescriptorCellDidSelectedWithFormController:controller];
}

#pragma mark - Events

-(void)rateChanged:(RatingView *)ratingView
{
  _doctor.ratingValue = [NSNumber numberWithInt:ratingView.value].floatValue;

}

#pragma mark - IBActions

- (IBAction)assignButtonTapped:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(didAssignedDoctor:)]) {
    [self.delegate didAssignedDoctor:self];
  }
}

@end
