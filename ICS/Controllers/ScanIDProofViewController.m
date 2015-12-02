//
//  ScanIDProofViewController.m
//  ICS
//
//  Created by Harshita on 27/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ScanIDProofViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanIDProofViewController ()
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (strong, nonatomic) IBOutlet UIImageView *imageToRecognize;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indy;
@property (weak, nonatomic) IBOutlet UILabel * processedTextLabel;
@end

/**
 *  Super helpful code from:
 *  https://github.com/gali8/Tesseract-OCR-iOS
 */

@implementation ScanIDProofViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self recognizeImageWithTesseract:self.imageToOCR];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tess

-(void)recognizeImageWithTesseract:(UIImage *)image
{
    [self.indy startAnimating];
    
    // Preprocess the image so Tesseract's recognition will be more accurate
    UIImage *bwImage = [image g8_blackAndWhite];
    
    // Display the preprocessed image to be recognized in the view
    self.imageToRecognize.image = bwImage;
    
    // Create a new `G8RecognitionOperation` to perform the OCR asynchronously
    // It is assumed that there is a .traineddata file for the language pack
    // you want Tesseract to use in the "tessdata" folder in the root of the
    // project AND that the "tessdata" folder is a referenced folder and NOT
    // a symbolic group in your project
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] initWithLanguage:@"eng"];
    
    // Use the original Tesseract engine mode in performing the recognition
    // (see G8Constants.h) for other engine mode options
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    
    // Let Tesseract automatically segment the page into blocks of text
    // based on its analysis (see G8Constants.h) for other page segmentation
    // mode options
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    
    // Optionally limit the time Tesseract should spend performing the
    // recognition
    //operation.tesseract.maximumRecognitionTime = 1.0;
    
    // Set the delegate for the recognition to be this class
    // (see `progressImageRecognitionForTesseract` and
    // `shouldCancelImageRecognitionForTesseract` methods below)
    operation.delegate = self;
    
    // Optionally limit Tesseract's recognition to the following whitelist
    // and blacklist of characters
    //operation.tesseract.charWhitelist = @"01234";
    //operation.tesseract.charBlacklist = @"56789";
    
    // Set the image on which Tesseract should perform recognition
    operation.tesseract.image = bwImage;
    
    // Optionally limit the region in the image on which Tesseract should
    // perform recognition to a rectangle
//    operation.tesseract.rect = CGRectMake(20, 20, 100, 100);
    
    // Specify the function block that should be executed when Tesseract
    // finishes performing recognition on the image
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {

        [self.indy stopAnimating];
        
        // Fetch the recognized text
        NSString *recognizedText = tesseract.recognizedText;
        
        NSLog(@"%@", recognizedText);
        
        
        self.processedTextLabel.text = recognizedText;
        
        // Spawn an alert with the recognized text
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"OCR Result"
                                                        message:recognizedText
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    };
    
    // Finally, add the recognition operation to the queue
    [self.operationQueue addOperation:operation];
}

/**
 *  This function is part of Tesseract's delegate. It will be called
 *  periodically as the recognition happens so you can observe the progress.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 */
- (void)progressImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    NSLog(@"progress: %lu", (unsigned long)tesseract.progress);
}

/**
 *  This function is part of Tesseract's delegate. It will be called
 *  periodically as the recognition happens so you can cancel the recogntion
 *  prematurely if necessary.
 *
 *  @param tesseract The `G8Tesseract` object performing the recognition.
 *
 *  @return Whether or not to cancel the recognition.
 */
- (BOOL)shouldCancelImageRecognitionForTesseract:(G8Tesseract *)tesseract {
    return NO;  // return YES, if you need to cancel recognition prematurely
}


#pragma mark - 
- (IBAction)proceedFurther:(id)sender {
	UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	UITabBarController *tbc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"tabBarViewControllerIdentifier"];
	[self.navigationController pushViewController:tbc animated:YES];
}

- (IBAction)gotoBasicRegistration:(id)sender {
    [self.navigationController popToViewController:[self.navigationController viewControllers][[self.navigationController viewControllers].count - 3] animated:YES];
}

@end
