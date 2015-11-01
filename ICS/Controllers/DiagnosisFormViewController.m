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
 [self fetchingDataFromJsonFile];
  
//  [self initialSetup];
  self.navigationItem.title = @"Questions";
  [self setupForm];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialSetup {
  [self.sectionsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    Question *question = [Question new];
    question.questionId = obj[kQuestionsId];
//    
  }];
  NSArray *sections = [kSharedModel fetchObjectsWithEntityName:kQuestionEntityName];
  
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
    
//    
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:khidesection rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"s2 section"];
//    row.value = @0;
//    [smokingSection addFormRow:row];
   
    
    
    XLFormSectionDescriptor *s2 = [XLFormSectionDescriptor formSection];

    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"tagi" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"s2"];
    row.value = @0;
    [s2 addFormRow:row];
    [form addFormSection:s2 afterSection:s1Extend];

    
//    section = [XLFormSectionDescriptor formSectionWithTitle:@"B Section"];
//    section.footerTitle = @"BasicPredicateViewController";
//    section.hidden = [NSString stringWithFormat:@"$%@==0", khidesection];
//    [form addFormSection:section];
//    
//    row = [XLFormRowDescriptor formRowDescriptorWithTag:ktext rowType:XLFormRowDescriptorTypeText title:@""];
//    [row.cellConfigAtConfigure setObject:@"Gonna disappear soon!!" forKey:@"textField.placeholder"];
//    [section addFormRow:row];
    return form;
  }



- (void)initializeForm {
  XLFormDescriptor *form = [[XLFormDescriptor alloc] init];
  NSMutableArray *questionsArray = [[NSMutableArray alloc] init];
  [self.sections enumerateObjectsUsingBlock:^(NSArray *questions, NSUInteger idx, BOOL * _Nonnull stop) {
    XLFormSectionDescriptor *section = [[XLFormSectionDescriptor alloc] init];
    section.title = kConsumeCigarettes;
  }];
  
}

#pragma mark - OfflineData
- (void)fetchingDataFromJsonFile {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QuestionsJasonData" ofType:@"json"];
//  NSData *data = [NSData dataWithContentsOfFile:filePath];
//  NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
//  return [json valueForKey:@"sections"];
  
  NSString *seedStorePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"RKSeedDatabase.sqlite"];
  NSManagedObjectModel *objectModel = [[NSManagedObjectModel alloc]
                                       initWithContentsOfURL:kModelURL];
  RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:objectModel];

//  NSString *storePath = [RKApplicationDataDirectory()
//                         stringByAppendingPathComponent:kDataStoreFileName];
  
  [self offlineData:filePath objectModel:objectModel store:managedObjectStore];
  

}
- (void)offlineData:(NSString*)seedPath objectModel:(NSManagedObjectModel*)model store:(RKManagedObjectStore*)store {
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"QuestionsJasonData" ofType:@"json"];
  NSError *error;
  RKEntityMapping *mapping = [Question restkitObjectMappingForStore:store];
  
  RKManagedObjectImporter *importer =
  [[RKManagedObjectImporter alloc] initWithManagedObjectModel:model
                                                    storePath:seedPath];
  [importer importObjectsFromItemAtPath:filePath
                            withMapping:mapping
                                keyPath:nil
                                  error:&error];
  BOOL success = [importer finishImporting:&error];
  if (success) {
    [kSharedModel saveContext];
    [importer logSeedingInfo];
  } else {
    RKLogError(@"Failed to finish import and save seed database due to error: %@", error);
  }
}

- (void)setupForm {
  __block XLFormDescriptor *form = [XLFormDescriptor formDescriptor];
  NSArray *sectionTitle = @[kConsumeCigarettes, kConsumePanMasala, kConsumeAlcohal, kConsumePanMasala];
  NSDictionary *obj = [self.sectionsArray objectAtIndex:0];
  NSArray *questions = [obj valueForKey:@"questions"];
  form = [self initializeFormSection:[sectionTitle objectAtIndex:0] withQuestions:questions inForm:form];
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
