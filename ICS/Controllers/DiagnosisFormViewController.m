//
//  PatientEatingHabitsViewController.m
//  ICS
//
//  Created by aam-fueled on 14/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "DiagnosisFormViewController.h"
#import "ICSCustomRowDescriptor.h"
#import "XLForm.h"
#import "UIView+ICSAdditions.h"
#import "Question.h"
#import "Form.h"

static NSString * const kQuestionTypeSingleChoice = @"single choice";
static NSString * const kQuestionTypeText = @"text";
static NSString * const kQuestionTypeBoolean = @"boolean";
static NSString * const kQuestionTypeMultipleChoice = @"multiple choice";
static NSString * const kQuestionTypeNumber = @"number";
static NSString *const kEatingHabits = @"Eating Habits";
static NSString *const kConsumeCigarettes = @"Consume Cigarettes";
static NSString *const kConsumeAlcohal = @"ConsumeAlcohal";
static NSString *const kConsumePanMasala = @"Consume Pan Masala";
static NSString *const kAddOtherAdiction = @"Add Other Adiction";
static NSString *const kMedicalHistory = @"Medical History";


NSString *const kTag1 = @"tag1";
NSString *const kTag2 = @"tag2";
NSString *const kTag3 = @"tag3";
@interface DiagnosisFormViewController ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *sectionsArray;
@property (nonatomic, strong) NSDictionary *resultDict;
@property (nonatomic, strong) NSMutableArray *questionsArray;
@end

@implementation DiagnosisFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.view ICSViewBackgroungColor];
  self.tableView.backgroundColor = [UIColor clearColor];
  NSArray *savedQuestionstList = [kSharedModel fetchObjectsWithEntityName:kQuestionEntityName];
  [savedQuestionstList enumerateObjectsUsingBlock:^(Question *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    NSLog(@"id=%@",obj.title);
  }];
  self.sectionsArray = savedQuestionstList;
  self.questionsArray = [[NSMutableArray alloc] init];
// [self fetchDiagnosisQuestions];
  [self fetchingDataFromJsonFile];
  [self setupForm];
  self.navigationItem.title = @"Questions";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -API call
- (void)fetchDiagnosisQuestions {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [kDataSource fetchDiagnosisQuestions: _icsForm.formId
                                 token: _token
                       completionBlock:^(BOOL success, NSDictionary *result, NSError *error) {
                         if (success) {
                           self.sectionsArray = [result objectForKey:@"sections"];
                           [self setupForm];

                         }else if (error){
                           
                         }
                         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                       }];
}

#pragma mark - initialization
- (XLFormDescriptor*)initializeFormSection:(XLFormDescriptor*)form
  {
    XLFormSectionDescriptor * smokingSection;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    smokingSection = [XLFormSectionDescriptor formSection];
    [form addFormSection:smokingSection];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTag1 rowType:XLFormRowDescriptorTypeBooleanSwitch title:kConsumeCigarettes];
    row.value = @0;
    [smokingSection addFormRow:row];
    
   XLFormSectionDescriptor *smokingQuestionsSection = [self initializeSmokingQuestionSection:[self.questionsArray objectAtIndex:0]];
    smokingQuestionsSection.hidden = [NSString stringWithFormat:@"$%@==0", kTag1];
    [form addFormSection:smokingQuestionsSection afterSection:smokingSection];
    
    XLFormSectionDescriptor *eatingHabitSection = [XLFormSectionDescriptor formSection];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kTag2 rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Eating Habit"];
    row.value = @0;
    [eatingHabitSection addFormRow:row];
    [form addFormSection:eatingHabitSection afterSection:smokingQuestionsSection];
    return form;
  }




#pragma mark - OfflineData
- (void)fetchingDataFromJsonFile {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QuestionsJasonData" ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:filePath];
  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
  self.sectionsArray = [json valueForKey:@"sections"];
}

- (void)setupForm {
  
  XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
  
  [self.sectionsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    NSArray *questions = [obj valueForKey:@"questions"];
    [self.questionsArray addObject:questions];
  }];
  form = [self initializeFormSection:form];
  self.form = form;
}

- (XLFormSectionDescriptor*)initializeSmokingQuestionSection:(NSArray*)questions {
  __block XLFormSectionDescriptor * section = [XLFormSectionDescriptor formSection];
  __block XLFormRowDescriptor * row;

  [questions enumerateObjectsUsingBlock:^(NSDictionary *question, NSUInteger idx, BOOL * _Nonnull stop) {
    row = [self formRowDescriptor:row withQuestionType:question[kQuestionType]];
    row.title = [question objectForKey:@"title"];
    [section addFormRow:row];
  }];
  return section;
}

- (XLFormRowDescriptor*)formRowDescriptor:(XLFormRowDescriptor*)row withQuestionType:(NSString*)questionType {
  if ([questionType isEqualToString:kQuestionTypeSingleChoice]) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeSingleChoice rowType:XLFormRowDescriptorTypeBooleanCheck];
  }
  else if ([questionType isEqualToString:kQuestionTypeText]) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeText rowType:XLFormRowDescriptorTypeTextView];
  }
  else if ([questionType isEqualToString:kQuestionTypeNumber]) {
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeNumber rowType:XLFormRowDescriptorTypeNumber];
  }
//  else if (questionType == kQuestionTypeMultipleChoice) {
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeMultipleChoice rowType:XLFormRowDescriptorTypeMultipleSelector title:kQuestionTypeMultipleChoice];
//  }
  else if ([questionType isEqualToString:kQuestionTypeBoolean]) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeBoolean rowType:XLFormRowDescriptorTypeBooleanSwitch];
  }
  return row;
}

@end
