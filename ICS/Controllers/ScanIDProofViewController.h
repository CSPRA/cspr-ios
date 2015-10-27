//
//  ScanIDProofViewController.h
//  ICS
//
//  Created by Harshita on 27/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR/TesseractOCR.h>

@interface ScanIDProofViewController : UIViewController<G8TesseractDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImage *imageToOCR;
@end
