//
//  WalkthroughViewController.m
//  ICS
//
//  Created by Harshita on 27/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "ICSStyleGuide.h"

@interface WalkthroughViewController () {
    NSArray * wtTextArray;
}
@property (nonatomic, strong) UIScrollView * wtScrollView;
@property (nonatomic, strong) UIButton * gotItButton;
@end

@implementation WalkthroughViewController
@synthesize gotItButton;
@synthesize wtScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    wtTextArray = @[
                  @"You can use this app to register and diagnose patients",
                  @"Once inside an event, you can check your assigned patients. Once assigned, proceed to start diagnosis",
                  @"Fill in patient information, personal and/or Medical history",
                  @"Click images of patient, mark the image if it could be a possible suspect",
//                  @"After marking images, app will help you to decide if diagnosis should end or not",
                  @"Tabs will help you fill in required details of a patient.",
                  @"When data has been recorded, assign the patient to a doctor.",
                  @"On the home screen, Quick Registration is linked to OCR. It helps you to quickly take first-level information of the patient with help of government ID Cards.",
                  ];

    self.view.backgroundColor = [ICSStyleGuide ICSOrange];
    
    UIImageView * wtMainScreen = [[UIImageView alloc] initWithFrame:self.view.frame];
    wtMainScreen.image = [UIImage imageNamed:@"bgCloud"];
    wtMainScreen.contentMode = UIViewContentModeScaleAspectFit;
    wtMainScreen.backgroundColor = [UIColor clearColor];
    [self.view addSubview:wtMainScreen];
    
    wtScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    wtScrollView.backgroundColor = [UIColor clearColor];
    wtScrollView.showsHorizontalScrollIndicator = NO;
    wtScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:wtScrollView];
    
    CGFloat x_point = 0;
    
    for(int i = 0; i < wtTextArray.count; i++ ) {
        UIView * wtView = [[UIView alloc] initWithFrame:CGRectMake(x_point, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        UIImageView * wtScreen = [[UIImageView alloc] initWithFrame:CGRectInset(self.view.frame, 60, 20)];
        wtScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"wt%d", i+1]];
        wtScreen.contentMode = UIViewContentModeScaleAspectFit;
        wtScreen.backgroundColor = [UIColor clearColor];
        
        UILabel * wtTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(self.view.bounds)-40, 120)];
        wtTitle.text = wtTextArray[i];
        wtTitle.textColor = [UIColor whiteColor];
        wtTitle.numberOfLines = 0;
        wtTitle.textAlignment = NSTextAlignmentCenter;
        [wtView addSubview:wtScreen];
        [wtView addSubview:wtTitle];
        [wtScrollView addSubview:wtView];
        
        x_point += CGRectGetWidth(self.view.frame);
    }
    
    wtScrollView.bounces = NO;
    wtScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds)*wtTextArray.count, CGRectGetHeight(self.view.bounds));
    wtScrollView.contentOffset = CGPointZero;
    wtScrollView.pagingEnabled = YES;
    
    gotItButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)-50, CGRectGetWidth(self.view.frame), 50)];
    [gotItButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gotItButton setTitleColor:[ICSStyleGuide ICSRed] forState:UIControlStateHighlighted];
    [gotItButton setTitle:@"Got It" forState:UIControlStateNormal];
    [gotItButton addTarget:self action:@selector(dismissWalkthrough) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gotItButton];

}


-(void)dismissWalkthrough {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end