//
//  ICSStyleGuide.m
//  ICS
//
//  Created by Harshita
//  Copyright (c) 2015 Meraki. All rights reserved.
//

#import "ICSStyleGuide.h"

@implementation ICSStyleGuide

#pragma mark - Fonts

+ (UIFont *)largePostTitleFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:32.0];
}

+ (NSDictionary *)largePostTitleAttributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 35;
    paragraphStyle.maximumLineHeight = 35;
    return @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName : [self largePostTitleFont]};
}

+(UIFont*) boldButtonFont{
    return [UIFont boldSystemFontOfSize:medium_font_size];
}

+ (UIFont *)subLabelFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:subtitle_font_size];
}

+ (UIFont *)subLabelBoldFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:subtitle_font_size];
}

+ (UIFont *)mediumTextBoldFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:medium_font_size];
}

+ (UIFont *)regularTextBoldFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:regular_font_size];
}

+ (UIFont *)topViewTextBoldFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:large_font_size];
}

+ (UIFont *)mediumTextFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:medium_font_size];
}

+ (UIFont *)regularTextFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:15];//regular_font_size];
}

+ (UIFont *)smallTextBoldFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:small_font_size];
}

+ (UIFont *)smallTextFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:small_font_size];
}

+ (UIFont *)titleTextFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:title_font_size];
}

+ (UIFont *)titleBoldTextFont {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:title_font_size];
}

+ (UIFont *)subtitleFont {
    return [UIFont fontWithName:@"HelveticaNeue" size:subtitle_font_size];
}

+ (NSDictionary *)subtitleAttributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 14;
    paragraphStyle.maximumLineHeight = 14;
    return @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName : [self subtitleFont]};
}

+ (UIFont *)subtitleFontItalic {
    return [UIFont fontWithName:@"HelveticaNeue-Italic" size:subtitle_font_size];
}

+ (NSDictionary *)subtitleItalicAttributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 14;
    paragraphStyle.maximumLineHeight = 14;
    return @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName : [self subtitleFontItalic]};
}

+(UIFont *)pickerViewFont {
    return [UIFont fontWithName:@"STHeitiSC-Medium" size:large_font_size];
}

+ (UIFont *)regularTextFontBold {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:regular_font_size];
}

+ (NSDictionary *)regularTextAttributes {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 24;
    paragraphStyle.maximumLineHeight = 24;
    return @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName : [self regularTextFont]};
}

#pragma mark - Colors

+ (UIColor *) ICSBackground {
    return [UIColor colorWithRed:233/255.0f green:234/255.0f blue:237/255.0f alpha:1.0f];
}

+ (UIColor *)ICSRed {
    return [UIColor colorWithRed:168/255.0f green:47/255.0f blue:67/255.0f alpha:1.0f];
}

+ (UIColor *) backgroundGrey {
    return [UIColor colorWithRed:231/255.0f green:231/255.0f blue:231/255.0f alpha:1.0f];
}

+ (UIColor *) tableGrey {
    return [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
}

+ (UIColor *) charcoalColour {
    return [UIColor colorWithRed:29/255.0f green:28/255.0f blue:28/255.0f alpha:1.0f];
}

+ (UIColor *)mediumGray {
    return [UIColor colorWithRed:183/255.0f green:184/255.0f blue:184/255.0f alpha:1.0f];
}

+ (UIColor *) frameGrey {
    return [UIColor colorWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1.0f];
}


+ (UIColor *) ICSBlue {
    return [UIColor colorWithRed:58/255.0f green:135/255.0f blue:250/255.0f alpha:1.0f];
}

@end