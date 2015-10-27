//
//  PhotoViewController.m
//  ICS
//
//  Created by aam-fueled on 07/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PhotoViewController.h"
#import "PhotoCollectionViewCell.h"
#import "FullImageContainerView.h"
#import "SharedModel.h"
#import "Patient.h"


@interface PhotoViewController()<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
FullImageContainerViewDelegate
>

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic, strong) UIImage *pickedImage;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) Patient *patient;
@property (nonatomic, strong) NSMutableArray *imageDataArray;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) FullImageContainerView *fullImageView;
@property (nonatomic, assign) NSInteger patientId;

@end

@implementation PhotoViewController

#pragma mark - View Cycle

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.title = @"Diagnosis Photos";
  [self initialSetup];
}

#pragma mark - Private Methdos

- (void)initialSetup {
//  self.patient = [[Patient alloc] init];
  self.images = [[NSMutableArray alloc] init];
  
  
  self.fullImageView = [FullImageContainerView newView];
  [self.view addSubview:self.fullImageView];
  self.fullImageView.delegate = self;
  self.fullImageView.alpha = kMinAlpha;
  
  // dummy id for test.
//  self.patient.patientId = 1234;
  self.patientId = 1234;
  [self retrieveImagesFromFile];
}

- (void)loadImages {
  
  [self.imageDataArray enumerateObjectsUsingBlock:^(NSData *imageData, NSUInteger idx, BOOL * _Nonnull stop) {
    UIImage *image = [UIImage imageWithData:imageData];
    [self.images addObject:image];
  }];
  [self.photoCollectionView reloadData];
}


#pragma mark - camera and photo handling

- (void)showCamera {
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    [self showImagePickerController];
  }
  else {
    NSLog(@"camera not available");
  }
}

- (void)showImagePickerController {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
  imagePicker.delegate = self;
  imagePicker.editing = YES;
  [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)processPickedImage {
  [self.images addObject:self.pickedImage];
  [self.photoCollectionView reloadData];
  
  if (self.pickedImage) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      
      self.pickedImage = [self scaleImageToFactor:0.5];
      NSData *imageData = UIImagePNGRepresentation(self.pickedImage);
      if (!self.imageDataArray) {
        self.imageDataArray = [[NSMutableArray alloc] init];
      }
      [self.imageDataArray addObject:imageData];
      [self saveImagesToFile];
    });
  }
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

#pragma mark - Saving and Retrieving images from Documents directory.

- (void)saveImagesToFile {
  NSString *fileName = [[SharedModel shared] filePathWithPatientID:self.patientId];
  [self.imageDataArray writeToFile:fileName atomically:YES];
}

- (void)retrieveImagesFromFile {
  UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  activityIndicator.center = self.view.center;
  [self.view addSubview:activityIndicator];
  [activityIndicator startAnimating];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
    
    NSString *fileName = [[SharedModel shared] filePathWithPatientID:self.patientId];
    self.imageDataArray = [[NSMutableArray alloc] initWithContentsOfFile:fileName];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [activityIndicator stopAnimating];
      [self loadImages];
    });
  });
}

#pragma mark - UIImagePickerControllerDelegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
  
  self.mediaURL = [info objectForKeyedSubscript:UIImagePickerControllerMediaURL];
  self.pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
  [self processPickedImage];
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionView DataSource and Delegate Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.images.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
  cell.imageView.image = [self.images objectAtIndex:indexPath.row];
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
  [UIView animateWithDuration:kAnimationFactor
                        delay:0.0
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     [[self navigationController] setNavigationBarHidden:YES animated:YES];
                     self.fullImageView.imageView.image = [self.images objectAtIndex:indexPath.row];
                     self.fullImageView.alpha = kMaxAlpha;
                   } completion:nil];
}

#pragma mark - FullImageContainerViewDelegate
- (void)didTappedCrossButton:(FullImageContainerView *)fullView {
  [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma mark - IBActions

- (IBAction)takePhotoTapped:(id)sender {
  [self showCamera];
}

@end
