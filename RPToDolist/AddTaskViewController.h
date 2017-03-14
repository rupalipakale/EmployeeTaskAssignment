//
//  AddTaskViewController.h
//  RPToDolist
//
//  Created by Student P_07 on 04/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
@interface AddTaskViewController : UIViewController<UITextFieldDelegate>


@property BOOL isAddSelect;
@property (strong, nonatomic) NSArray *arrUpdate;
@property NSInteger index;
@property NSInteger employeeId;
@property NSInteger taskId;
@property (strong, nonatomic) NSString *stringTaskName;
@property (strong, nonatomic) NSString *stringTaskDetail;

@property (strong, nonatomic) NSString *stringTaskDate;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *txtAssignDate;
@property (strong, nonatomic) IBOutlet UITextField *txtTaskDetail;
@property (strong, nonatomic) IBOutlet UITextField *txtTaskName;
- (IBAction)btnCancelClick:(id)sender;
- (IBAction)btnSaveClick:(id)sender;
- (IBAction)segmentValueChanged:(id)sender;
- (IBAction)datePickerValueChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnSave;
@property (strong, nonatomic) IBOutlet UISegmentedControl *employeeSegment;

@end
