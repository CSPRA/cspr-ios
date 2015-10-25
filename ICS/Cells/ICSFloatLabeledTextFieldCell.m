//
//  ICSFloatLabeledTextFieldCell.m
//  ICS
//
//  Created by Aqsa on 25/10/15.
//  Copyright © 2015 Meraki. All rights reserved.
//

#import "ICSFloatLabeledTextFieldCell.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import <XLForm/NSObject+XLFormAdditions.h>
#import "UIView+XLFormAdditions.h"


NSString *const XLFormRowDescriptorTypeFloatLabeledTextField = @"XLFormRowDescriptorTypeFloatLabeledTextField";
const static CGFloat kHMargin = 15.0f;
const static CGFloat kVMargin = 8.0f;
const static CGFloat kFloatingLabelFontSize = 11.0f;

@interface ICSFloatLabeledTextFieldCell ()<UITextFieldDelegate>
@property (nonatomic) JVFloatLabeledTextField * floatLabeledTextField;
@end

@implementation ICSFloatLabeledTextFieldCell

+(void)load
{
  [XLFormViewController.cellClassesForRowDescriptorTypes setObject:[ICSFloatLabeledTextFieldCell class] forKey:XLFormRowDescriptorTypeFloatLabeledTextField];
}

-(JVFloatLabeledTextField *)floatLabeledTextField
{
  if (_floatLabeledTextField) return _floatLabeledTextField;
  
  _floatLabeledTextField = [JVFloatLabeledTextField autolayoutView];
  _floatLabeledTextField.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  _floatLabeledTextField.floatingLabel.font = [UIFont boldSystemFontOfSize:kFloatingLabelFontSize];
  
  _floatLabeledTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
  return _floatLabeledTextField;
}

#pragma mark - XLFormDescriptorCell

-(void)configure
{
  [super configure];
  [self setSelectionStyle:UITableViewCellSelectionStyleNone];
  [self.contentView addSubview:self.floatLabeledTextField];
  [self.floatLabeledTextField setDelegate:self];
  [self.contentView addConstraints:[self layoutConstraints]];
}

-(void)update
{
  [super update];
  
  self.floatLabeledTextField.attributedPlaceholder =
  [[NSAttributedString alloc] initWithString:self.rowDescriptor.title
                                  attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
  
  self.floatLabeledTextField.text = self.rowDescriptor.value ? [self.rowDescriptor.value displayText] : self.rowDescriptor.noValueDisplayText;
  [self.floatLabeledTextField setEnabled:!self.rowDescriptor.isDisabled];
  
  self.floatLabeledTextField.floatingLabelTextColor = [UIColor lightGrayColor];
  
  [self.floatLabeledTextField setAlpha:((self.rowDescriptor.isDisabled) ? .6 : 1)];
}

-(BOOL)formDescriptorCellCanBecomeFirstResponder
{
  return !self.rowDescriptor.isDisabled;
}

-(BOOL)formDescriptorCellBecomeFirstResponder
{
  return [self.floatLabeledTextField becomeFirstResponder];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
  return [self.formViewController textFieldShouldClear:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  return [self.formViewController textFieldShouldReturn:textField];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
  return [self.formViewController textFieldShouldBeginEditing:textField];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  return [self.formViewController textFieldShouldEndEditing:textField];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
  return [self.formViewController textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  [self.formViewController textFieldDidBeginEditing:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  [self textFieldDidChange:textField];
  [self.formViewController textFieldDidEndEditing:textField];
}

-(void)setReturnKeyType:(UIReturnKeyType)returnKeyType
{
  self.floatLabeledTextField.returnKeyType = returnKeyType;
}

-(UIReturnKeyType)returnKeyType
{
  return self.floatLabeledTextField.returnKeyType;
}

+(CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor {
  return 55;
}



-(NSArray *)layoutConstraints
{
  NSMutableArray * result = [[NSMutableArray alloc] init];
  
  NSDictionary * views = @{@"floatLabeledTextField": self.floatLabeledTextField};
  NSDictionary *metrics = @{@"hMargin":@(kHMargin),
                            @"vMargin":@(kVMargin)};
  
  [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(hMargin)-[floatLabeledTextField]-(hMargin)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
  [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(vMargin)-[floatLabeledTextField]-(vMargin)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
  return result;
}

#pragma mark - Helpers

- (void)textFieldDidChange:(UITextField *)textField
{
  if (self.floatLabeledTextField == textField) {
    if ([self.floatLabeledTextField.text length] > 0) {
      self.rowDescriptor.value = self.floatLabeledTextField.text;
    } else {
      self.rowDescriptor.value = nil;
    }
  }
}



@end
