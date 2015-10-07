//
//  PhotoViewController.m
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionViewCell.h"


@interface PhotoViewController()<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) UIImage *pickedImage;
@property (nonatomic, strong) NSURL *mediaURL;
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

#pragma mark - UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  
  self.mediaURL = [info objectForKeyedSubscript:UIImagePickerControllerMediaURL];
  self.pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  [self dismissViewControllerAnimated:YES completion:^{
    [self processPickedImage];
  }];
}

- (void)processPickedImage {
  
}


@end
