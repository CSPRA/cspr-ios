//
//  PhotoCollectionViewCell.h
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiagnosisPhoto.h"

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (assign, nonatomic, getter = isSuspectedPhoto) BOOL suspectedPhoto;

@end
