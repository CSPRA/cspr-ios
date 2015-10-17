//
//  PatientsDetailTableViewCell.h
//  ICS
//
//  Created by aqsa-fueled on 17/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PatientsDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *paitnetIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientFullNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *syncButton;

@end
