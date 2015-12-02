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
#import "UIScrollView+EmptyDataSet.h"
#import "Patient.h"
#import "DiagnosisPhoto.h"

@interface PhotoViewController()<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate,
FullImageContainerViewDelegate
>

@property (nonatomic, weak)   IBOutlet UICollectionView *photoCollectionView;
@property (nonatomic, strong) UIImage *pickedImage;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) Patient *patient;
@property (nonatomic, strong) NSMutableArray *diagnosisDataArray;
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
    //DZN
    self.photoCollectionView.emptyDataSetDelegate = self;
    self.photoCollectionView.emptyDataSetSource   = self;
    
  
    self.diagnosisDataArray = [[NSMutableArray alloc] init];
    
    self.fullImageView = [FullImageContainerView newView];
    self.fullImageView.frame = self.view.bounds;
    [self.view addSubview:self.fullImageView];
    self.fullImageView.delegate = self;
    self.fullImageView.alpha = kMinAlpha;
  
  self.patientId = 1234;
    
}

- (void)loadImages {
    [self refreshPhotoViewControllerView];
}


#pragma mark - camera and photo handling

- (void)showCamera {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showImagePickerController];
    }
    else {
        NSLog(@"camera not available");
        self.pickedImage = [UIImage imageNamed:@"icsLogo"];
        [self processPickedImage];
        
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
    
    
    if (self.pickedImage) {
        DiagnosisPhoto * diag = [[DiagnosisPhoto alloc] init];
        diag.dpImage = self.pickedImage;
        diag.dpSuspectStatus = NO;
        [self.diagnosisDataArray addObject:diag];
        [self saveImagesToFile];
        [self refreshPhotoViewControllerView];
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

    
    NSArray * saveArray = [self.diagnosisDataArray copy];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        NSString *fileName = [[SharedModel shared] filePathWithPatientID:self.patientId];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:saveArray];
        if([encodedObject writeToFile:fileName atomically:YES]) {
            NSLog(@"yay");
        }
        else {
            NSLog(@"nay");
        }
    });
}

- (void)retrieveImagesFromFile {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = self.view.center;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];

    NSString *fileName = [[SharedModel shared] filePathWithPatientID:self.patientId];
    NSData *encodedObject = [NSData dataWithContentsOfFile:fileName];
    self.diagnosisDataArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:encodedObject]];
  
    if(!self.diagnosisDataArray) {
        self.diagnosisDataArray = [NSMutableArray array];
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [activityIndicator stopAnimating];
        [self loadImages];
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
    return self.diagnosisDataArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = (PhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.imageView.image = [(DiagnosisPhoto*)self.diagnosisDataArray[indexPath.item] dpImage];
    cell.suspectedPhoto  = [(DiagnosisPhoto*)self.diagnosisDataArray[indexPath.item] dpSuspectStatus];
    [cell layoutSubviews];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [UIView animateWithDuration:kAnimationFactor
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [[self navigationController] setNavigationBarHidden:YES animated:YES];
						 [self.tabBarController.tabBar setHidden:YES];
                         [self.fullImageView setupFullImageContainerWithDiagnosisPicture:(DiagnosisPhoto*)self.diagnosisDataArray[indexPath.item]];
                         self.fullImageView.containerTag = indexPath.item;
                         self.fullImageView.alpha = kMaxAlpha;
                     } completion:nil];
}

#pragma mark - FullImageContainerViewDelegate

- (void)fullView:(FullImageContainerView *)fullContainerView didDeletePhotoWithAnimation:(BOOL)deleteAnimation {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
	[self.tabBarController.tabBar setHidden:NO];

    DiagnosisPhoto * phot = self.diagnosisDataArray[fullContainerView.containerTag];
    [self.diagnosisDataArray removeObject:phot];
    [self saveImagesToFile];
    [self refreshPhotoViewControllerView];
    
}

- (void)fullView:(FullImageContainerView *)fullContainerView didCloseWithSuspectStatus:(BOOL)suspectStatus {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
	[self.tabBarController.tabBar setHidden:NO];
    DiagnosisPhoto * phot = self.diagnosisDataArray[fullContainerView.containerTag];
    phot.dpSuspectStatus = suspectStatus;
    [self.diagnosisDataArray replaceObjectAtIndex:fullContainerView.containerTag withObject:phot];
    [self saveImagesToFile];
    [self refreshPhotoViewControllerView];
}

- (void)didTappedCrossButton:(FullImageContainerView *)fullView {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
	[self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - IBActions

- (IBAction)takePhotoTapped:(id)sender {
    [self showCamera];
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No pictures";
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"Click 'Take Photo' to add your first picture for diagnosing the patient.";
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:170/255.0 green:171/255.0 blue:179/255.0 alpha:1.0],
                                 NSParagraphStyleAttributeName: paragraphStyle};
    
    return [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"emptyCV"];
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 9.0;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    return nil;
}

#pragma mark -

-(void)refreshPhotoViewControllerView {
    [self.photoCollectionView reloadData];
    [self updateGradientForActionView];
    [self setupSecondaryLevelOfButtons:(self.diagnosisDataArray.count != 0)];
}

-(void)setupSecondaryLevelOfButtons:(BOOL)viewStatus {
    
    if(self.actionView.alpha == viewStatus) {
        return;
    }
    
    self.actionView.alpha = (viewStatus) ? kMaxAlpha : kMinAlpha;
    self.actionView.backgroundColor = [UIColor greenColor];
    

    
    CGRect finalFrame = viewStatus ? CGRectOffset(self.takePhotoButton.frame, 0, -CGRectGetHeight(self.takePhotoButton.frame)) : self.takePhotoButton.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.actionView.frame = finalFrame;
    }];
}

- (void)updateGradientForActionView {
    UIColor *healthyColor = [UIColor orangeColor];
    UIColor *suspectColor = [UIColor redColor];
    CAGradientLayer *maskLayer = [CAGradientLayer layer];
    maskLayer.opacity = kMaxAlpha;//k0.8;
    maskLayer.colors = [NSArray arrayWithObjects:(id)suspectColor.CGColor,
                        (id)healthyColor.CGColor, nil];
    
    // Hoizontal - commenting these two lines will make the gradient veritcal
    maskLayer.startPoint = CGPointMake(0.0, 0.5);
    maskLayer.endPoint = CGPointMake(1.0, 0.5);
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:
                               @"(%K = %@)", @"dpSuspectStatus", @(YES)];
    NSArray * response = [self.diagnosisDataArray filteredArrayUsingPredicate:predicate];
        NSLog(@"%@", response);
    
    float percentOfSuspects = (float)response.count/(float)self.diagnosisDataArray.count;
    NSNumber *healthyStart = [NSNumber numberWithFloat:0.0];
    NSNumber *healthyEnd = [NSNumber numberWithFloat:percentOfSuspects];
    maskLayer.locations = @[healthyStart, healthyEnd];
    
    maskLayer.bounds = self.actionView.bounds;
    maskLayer.anchorPoint = CGPointZero;
    [self.actionView.layer insertSublayer:maskLayer atIndex:0];
//    [self.actionView.layer addSublayer:maskLayer];
}

#pragma mark - 

- (IBAction)endDiagnosisButtonTapped:(id)sender {
  NSString *patientID = [NSString stringWithFormat:@"%li",(long)self.patientId];
    [[ICSDataManager sharedManager] endDiagnosisForPatientID:patientID withData:@{} withCompletion:^(id response, BOOL success) {
        [self.navigationController popViewControllerAnimated:YES];
    }];

}

- (IBAction)extendDiagnosisButtonTapped:(id)sender {
    UIViewController *patientHabitsVC = [self.storyboard instantiateViewControllerWithIdentifier:kDiagnosisFormVCIdentifier];
    [self.navigationController pushViewController:patientHabitsVC animated:YES];
}

@end
