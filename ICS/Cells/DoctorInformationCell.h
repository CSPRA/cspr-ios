//
//  RatingViewCell.h
//  ICS
//
//  Created by aam-fueled on 12/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "XLFormBaseCell.h"
#import "RatingView.h"
#import "DoctorDummyObject.h"

extern NSString * const XLFormRowDescriptorTypeRate;

@protocol DoctorInformationCellDelegate;

@interface DoctorInformationCell : XLFormBaseCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *docInfoLabel;
@property (weak, nonatomic) IBOutlet RatingView *ratingView;
@property (weak, nonatomic) IBOutlet UIButton *assignButton;
@property (strong, nonatomic) DoctorDummyObject *doctor;
@property (weak, nonatomic) id<DoctorInformationCellDelegate>delegate;

@end


@protocol DoctorInformationCellDelegate <NSObject>

- (void)didAssignedDoctor: (DoctorInformationCell*)cell;

@end