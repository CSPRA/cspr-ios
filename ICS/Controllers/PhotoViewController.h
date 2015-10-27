//
//  PhotoViewController.h
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (strong, nonatomic) IBOutlet UIButton * markHealthyButton;
@property (strong, nonatomic) IBOutlet UIButton * getMoreDetailsButton;
@property (strong, nonatomic) IBOutlet UIView   * actionView;
@end
