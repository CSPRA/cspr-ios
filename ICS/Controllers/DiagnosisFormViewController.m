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
static NSString *const kDoctorBasicInfo = @"Doctor Basic Info";
static NSString *const kAssignDoctor = @"Assign Doctor";
static NSString * const kCustomRowFirstRatingTag = @"CustomRowFirstRatingTag";
static NSString * const kCustomRowSecondRatingTag = @"CustomRowSecondRatingTag";
NSString *const kPred = @"pred";
NSString *const kPredDep = @"preddep";
NSString *const kPredDep2 = @"preddep2";
NSString *const khiderow = @"tag1";
NSString *const khidesection = @"tag2";
NSString *const ktext = @"tag3";
@interface DiagnosisFormViewController ()

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) NSArray *sectionsArray;
@property (nonatomic, strong) NSDictionary *resultDict;
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
// [self fetchDiagnosisQuestions];
  [self fetchingDataFromJsonFile];
  self.navigationItem.title = @"Questions";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -API call
- (void)fetchDiagnosisQuestions {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [kDataSource fetchDiagnosisQuestions:_formId
                                 token:_token
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
- (XLFormDescriptor*)initializeFormSection:(NSString*)title withQuestions:(NSArray*)questions inForm:(XLFormDescriptor*)form
  {
    XLFormSectionDescriptor * smokingSection;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptor];
    
    smokingSection = [XLFormSectionDescriptor formSection];
    [form addFormSection:smokingSection];
   
    row = [XLFormRowDescriptor formRowDescriptorWithTag:khidesection rowType:XLFormRowDescriptorTypeBooleanSwitch title:title];
    row.value = @0;
    [smokingSection addFormRow:row];
   XLFormSectionDescriptor *smokingQuestionsSection = [self initializeSmokingQuestionSection:questions];
    smokingQuestionsSection.hidden = [NSString stringWithFormat:@"$%@==0", khidesection];
    [form addFormSection:smokingQuestionsSection afterSection:smokingSection];
    
    XLFormSectionDescriptor *s1 = [XLFormSectionDescriptor formSection];
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kPred rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"s1 section"];
    row.value = @0;
    [s1 addFormRow:row];
    [form addFormSection:s1 afterSection:smokingQuestionsSection];
    XLFormSectionDescriptor *s1Extend = [self initializeSmokingQuestionSection:questions];
    s1Extend.hidden = [NSString stringWithFormat:@"$%@==0", kPred];
    [form addFormSection:s1Extend afterSection:s1];
    
    XLFormSectionDescriptor *s2 = [XLFormSectionDescriptor formSection];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"tagi" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"s2"];
    row.value = @0;
    [s2 addFormRow:row];
    [form addFormSection:s2 afterSection:s1Extend];

    return form;
  }




#pragma mark - OfflineData
- (void)fetchingDataFromJsonFile {
//  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QuestionsJasonData" ofType:@"json"];
//  NSData *data = [NSData dataWithContentsOfFile:filePath];
//  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//  return [json valueForKey:@"sections"];
  

  NSManagedObjectModel *objectModel = [[NSManagedObjectModel alloc]
                                       initWithContentsOfURL:kModelURL];
  NSString *storePath = [NSString stringWithFormat:@"%@",[RKObjectManager sharedManager].managedObjectStore];
  
//  NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"RKSeedDatabase" ofType:@"sqlite"];

  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QuestionsJasonData" ofType:@"json"];
  NSError *error;
  RKEntityMapping *mapping = [Question restkitObjectMappingForStore:[RKObjectManager sharedManager].managedObjectStore];
  
  RKManagedObjectImporter *importer =
  [[RKManagedObjectImporter alloc] initWithManagedObjectModel:objectModel
                                                    storePath:storePath];
  
  [importer importObjectsFromItemAtPath:filePath withMapping:mapping keyPath:nil error:&error];
//  [kSharedModel saveContext];

}

- (void)setupForm {
  __block XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
  NSArray *sectionTitle = @[kConsumeCigarettes, kConsumePanMasala, kConsumeAlcohal, kConsumePanMasala];
  NSDictionary *obj = [self.sectionsArray objectAtIndex:0];
//  form = [self initializeFormSection:[sectionTitle objectAtIndex:0] withQuestions:questions inForm:form];
//
//  
//  
//  [self.sectionsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//    NSArray *questions = [obj valueForKey:@"questions"];
//    form = [self initializeFormSection:[sectionTitle objectAtIndex:idx] withQuestions:questions inForm:form];
//    
////    [self initializeSmokingQuestionSection:questions];
//  }];
  self.form = form;
}

- (XLFormSectionDescriptor*)initializeSmokingQuestionSection:(NSArray*)questions {
  __block XLFormSectionDescriptor * section = [XLFormSectionDescriptor formSection];
  __block XLFormRowDescriptor * row;

  [questions enumerateObjectsUsingBlock:^(NSDictionary *question, NSUInteger idx, BOOL * _Nonnull stop) {
    row = [self formRowDescriptor:row withQuestionType:question[kQuestionType]];
    [section addFormRow:row];
  }];
  return section;
}

- (XLFormRowDescriptor*)formRowDescriptor:(XLFormRowDescriptor*)row withQuestionType:(NSString*)questionType {
  if ([questionType isEqualToString:kQuestionTypeSingleChoice]) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeSingleChoice rowType:XLFormRowDescriptorTypeBooleanCheck title:kQuestionTypeSingleChoice];
  }
  else if ([questionType isEqualToString:kQuestionTypeText]) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeText rowType:XLFormRowDescriptorTypeTextView title:kQuestionTypeText];
  }
  else if ([questionType isEqualToString:kQuestionTypeNumber]) {
    
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeNumber rowType:XLFormRowDescriptorTypeNumber title:kQuestionTypeNumber];
  }
//  else if (questionType == kQuestionTypeMultipleChoice) {
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeMultipleChoice rowType:XLFormRowDescriptorTypeMultipleSelector title:kQuestionTypeMultipleChoice];
//  }
  else if ([questionType isEqualToString:kQuestionTypeBoolean]) {
    row = [XLFormRowDescriptor formRowDescriptorWithTag:kQuestionTypeBoolean rowType:XLFormRowDescriptorTypeBooleanSwitch title:kQuestionTypeBoolean];
  }
  return row;
}

@end
