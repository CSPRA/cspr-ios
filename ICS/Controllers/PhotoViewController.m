//
//  PhotoViewController.m
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionViewCell.h"
#import "SharedModel.h"
#import "Patient.h"

@interface PhotoViewController()<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIImage *pickedImage;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) Patient *patient;
@end

@implementation PhotoViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self addCamera];
}

#pragma mark - camera and photo handling

- (void)addCamera {
  
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [self showImagePickerController];
  }
  else {
    NSLog(@"camera not available");
  }
}

- (void)showImagePickerController {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  imagePicker.delegate = self;
  imagePicker.editing = YES;
  [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - Resizing Image

- (UIImage*)scaleImageToFactor: (double)factor {
  CGImageRef ref  = self.pickedImage.CGImage;
  CGFloat width   = CGImageGetWidth(ref) * factor;
  CGFloat height  = CGImageGetHeight(ref) * factor;
  
  CGContextRef context = CGBitmapContextCreate(nil,width, height, CGImageGetBitsPerComponent(ref),
                    CGImageGetBytesPerRow(ref), CGImageGetColorSpace(ref), CGImageGetBitmapInfo(ref));
  
  CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), ref);
  UIImage *scaledImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
  return scaledImage;
}

- (void)processPickedImage {
  if (self.pickedImage) {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
      
      [self scaleImageToFactor:0.5];
      NSString *fileName = [[SharedModel shared] filePathWithPatientID:self.patient.patientId];
      [UIImagePNGRepresentation(self.pickedImage) writeToFile:fileName atomically:YES];
      
    });
  }
}


#pragma mark - UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  
  self.mediaURL = [info objectForKeyedSubscript:UIImagePickerControllerMediaURL];
  self.pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  [self dismissViewControllerAnimated:YES completion:^{
    [self processPickedImage];
  }];
}


@end
