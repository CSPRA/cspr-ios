//
//  PatientEatingHabitsViewController.m
//  ICS
//
//  Created by aam-fueled on 14/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "PatientEatingHabitsViewController.h"
#import "ICSCustomRowDescriptor.h"
#import "XLForm.h"

static NSString * const kQuestionTypeSingleChoice = @"single choice";
static NSString * const kQuestionTypeText = @"text";
static NSString * const kQuestionTypeBoolean = @"boolean";
static NSString * const kQuestionTypeMultipleChoice = @"multiple choice";
static NSString * const kQuestionTypeNumber = @"number";

@interface PatientEatingHabitsViewController ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *questionsArray;

@end

@implementation PatientEatingHabitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.navigationItem.title = @"Questions";
  [self setupForm];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initializeDummyData {
  Question *q1= [[Question alloc] init];
  q1.questionType = @"number";
  
  Question *q2= [[Question alloc] init];
  q2.questionType = @"text";
  
  Question *q3= [[Question alloc] init];
  q3.questionType = @"boolean";
  
  Question *q4= [[Question alloc] init];
  q4.questionType = @"multiple choice";
  
  Question *q5= [[Question alloc] init];
  q5.questionType = @"single choice";
  
  NSMutableArray *quesArray = [[NSMutableArray alloc] initWithObjects:q1,q2,q3,q4,q5, nil];
  self.sections = quesArray;
}

- (void)setupForm {
//  [self initializeDummyData];

  XLFormSectionDescriptor *section = [XLFormSectionDescriptor formSectionWithTitle:@""];
  __block XLFormRowDescriptor *row;
  XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
  
  [self.sections enumerateObjectsUsingBlock:^(Question *question, NSUInteger idx, BOOL * _Nonnull stop) {
    row = [self formRowDescriptor:row withQuestionType:question.questionType];
    [section addFormRow:row];
  }];
  
  [form addFormSection:section];
  self.form = form;
}

- (XLFormRowDescriptor*)formRowDescriptor:(XLFormRowDescriptor*)row withQuestionType:(NSString*)questionType {
  if (questionType == kQuestionTypeSingleChoice) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeSingleChoice rowType:XLFormRowDescriptorTypeBooleanCheck title:kQuestionTypeSingleChoice];
  }
  else if (questionType == kQuestionTypeText) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeText rowType:XLFormRowDescriptorTypeTextView title:kQuestionTypeText];
  }
  else if (questionType == kQuestionTypeNumber) {
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeNumber rowType:XLFormRowDescriptorTypeNumber title:kQuestionTypeNumber];
  }
  else if (questionType == kQuestionTypeMultipleChoice) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeMultipleChoice rowType:XLFormRowDescriptorTypeMultipleSelector title:kQuestionTypeMultipleChoice];
  }
  else if (questionType == kQuestionTypeBoolean) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeBoolean rowType:XLFormRowDescriptorTypeBooleanSwitch title:kQuestionTypeBoolean];
  }
  return row;
}

@end
