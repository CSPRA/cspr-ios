
//
//  RatingViewCell.m
//  ICS
//
//  Created by aam-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "RatingViewCell.h"
#import "Doctor.h"

NSString * const XLFormRowDescriptorTypeRate = @"XLFormRowDescriptorTypeRate";

@interface RatingViewCell ()
@property (nonatomic, strong) Doctor *doctor;
@end

@implementation RatingViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
}

+ (void)load {
  [XLFormViewController.cellClassesForRowDescriptorTypes setObject:NSStringFromClass([RatingViewCell class])
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
  self.ratingView.value = [self.doctor.doctorRatingValue floatValue];
  self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",_doctor.firstName,_doctor.lastName];
  self.docInfoLabel.text = [NSString stringWithFormat:@"%@, %@",_doctor.specialization,_doctor.location];
  
  [self.ratingView setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
}

#pragma mark - Events

-(void)rateChanged:(RatingView *)ratingView
{
  self.rowDescriptor.value = [NSNumber numberWithFloat:ratingView.value];
}

#pragma mark - IBActions

- (IBAction)assignButtonTapped:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(didAssignedDoctor:)]) {
    [self.delegate didAssignedDoctor:self];
  }
}

@end
