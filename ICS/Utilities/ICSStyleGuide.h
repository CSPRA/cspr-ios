//  Copyright (c) 2015 Meraki. All rights reserved.
//
//  ICSStyleGuide.h
//  ICS
//
//  Created by Harshita
//  Copyright (c) 2015 Meraki. All rights reserved.
//

#define large_font_size     18
#define regular_font_size   16
#define title_font_size     20
#define medium_font_size    14
#define small_font_size     11
#define subtitle_font_size  9

@import Foundation;
@import UIKit;

/**
 *  List of all fonts and colours used in the app
 */

@interface ICSStyleGuide : NSObject

// Fonts

+ (UIFont *)subLabelFont;
+ (UIFont *)subLabelBoldFont;
+ (UIFont *)boldButtonFont;

+ (UIFont *)mediumTextFont;
+ (UIFont *)mediumTextBoldFont;

+ (UIFont *)smallTextBoldFont;
+ (UIFont *)subtitleFont;
+ (UIFont *)topViewTextBoldFont;
+ (UIFont *)smallTextFont;

+ (UIFont *)titleTextFont;
+ (UIFont *)titleBoldTextFont;
+ (UIFont *)regularTextBoldFont;
+ (UIFont *)pickerViewFont;
+ (UIFont *)regularTextFont;

// Colors
+ (UIColor *)ICSBackground;
+ (UIColor *)ICSRed;
+ (UIColor *)ICSBlue;

+ (UIColor *) backgroundGrey;

+ (UIColor *) tableGrey;
+ (UIColor *) mediumGray;
+ (UIColor *) frameGrey;
+ (UIColor *) charcoalColour;
@end