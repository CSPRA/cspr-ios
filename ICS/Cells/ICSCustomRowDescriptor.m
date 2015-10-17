//
//  ICSCustomRowDescriptor.m
//  ICS
//
//  Created by aam-fueled on 14/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSCustomRowDescriptor.h"
#import "XLForm.h"

static NSString * const kQuestionTypeSingleChoice = @"single choice";
static NSString * const kQuestionTypeText = @"text";
static NSString * const kQuestionTypeBoolean = @"boolean";
static NSString * const kQuestionTypeMultipleChoice = @"multiple choice";
static NSString * const kQuestionTypeNumber = @"number";

@implementation ICSCustomRowDescriptor

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self =[super initWithCoder:aDecoder];
  return self;
}

- (void)configure {
  [super configure];
  
  if (kQuestionTypeSingleChoice) {
    self.rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeSingleChoice rowType:XLFormRowDescriptorTypeBooleanCheck title:kQuestionTypeSingleChoice];
  }
  else if (kQuestionTypeText) {
    self.rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeText rowType:XLFormRowDescriptorTypeTextView title:kQuestionTypeText];
  }
  else if (kQuestionTypeNumber) {
    
    self.rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeNumber rowType:XLFormRowDescriptorTypeNumber title:kQuestionTypeNumber];
  }
  else if (kQuestionTypeMultipleChoice) {
    self.rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeMultipleChoice rowType:XLFormRowDescriptorTypeMultipleSelector title:kQuestionTypeMultipleChoice];
  }
  else if (kQuestionTypeBoolean) {
    self.rowDescriptor = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeBoolean rowType:XLFormRowDescriptorTypeBooleanSwitch title:kQuestionTypeBoolean];
  }
}


@end
