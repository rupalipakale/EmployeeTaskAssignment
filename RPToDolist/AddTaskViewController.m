//
//  AddTaskViewController.m
//  RPToDolist
//
//  Created by Student P_07 on 04/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "AddTaskViewController.h"
#import "AppDelegate.h"
#import "Task.h"

@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
{
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=appDelegate.persistentContainer.viewContext;

    
    [_txtTaskName becomeFirstResponder];
    self.title=@"Assign Task";
    
    if(!_isAddSelect)
      [self setUpDesign];
    else
        _employeeId=1;
}

-(void)setUpDesign
{
    [_btnSave setTitle:@"Update"];
    _btnSave.tag=2;
    
    self.txtTaskName.text=self.stringTaskName;
    self.txtTaskDetail.text=self.stringTaskDetail;
    self.txtAssignDate.text=self.stringTaskDate;
    [self setSegmentvalueWithEmployeeID:_employeeId];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnCancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSaveClick:(id)sender {
    UIButton *btnSave=(UIButton *)sender;
    if([self checkEmpty])
    {
    NSEntityDescription *employeeEntity=[NSEntityDescription entityForName:@"EmployeeTask" inManagedObjectContext:context];
    Task *objTask=[[Task alloc]initWithEntity:employeeEntity insertIntoManagedObjectContext:context];
    NSString *message;
    if(btnSave.tag==0)
    {
       message=@"Record Saved Successfully";
       int TaskID=arc4random();
       [objTask setValue:[NSNumber numberWithInt:TaskID] forKey:@"id"];
       
    }
    else
    {
        message=@"Record Updated Successfully";
        NSLog(@"%ld",_taskId);
        NSArray *recordArray=[self fetchRecordWithTaskID];
        if(recordArray.count>0)
        {
            objTask=[recordArray objectAtIndex:0];
            
            [objTask setValue:[NSNumber numberWithInteger:_taskId] forKey:@"id"];
            
        }
    }
    [objTask setValue:[NSNumber numberWithInteger:_employeeId] forKey:@"employeeid"];
    [objTask setValue:_txtTaskName.text forKey:@"taskname"];
    [objTask setValue:_txtTaskDetail.text forKey:@"taskdetails"];
    [objTask setValue:_txtAssignDate.text forKey:@"assignmentdate"];
    
    NSError *error;
    [context save:&error];
    if(error)
    {
        NSLog(@"%@",error);
        [self showAlertwithTitle:@"Error" andMsg:error.localizedDescription];
    }
    else
    {
        [self showAlertwithTitle:@"Success" andMsg:message];
        [self clearFields];
        [self.navigationController popViewControllerAnimated:YES];
    }
      }
}
-(NSArray *)fetchRecordWithTaskID
{
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:@"EmployeeTask"];
    NSPredicate *prediCate=[NSPredicate predicateWithFormat:@"id == %ld",_taskId];
    [fetch setPredicate:prediCate];
    NSError *error;
    NSArray *recordArray=[context executeFetchRequest:fetch error:&error];
    if(error)
        NSLog(@"%@",error.localizedDescription);
    return recordArray;
}

-(void)setSegmentvalueWithEmployeeID:(NSInteger)empID
{
    _employeeId=empID;
    if(empID==1)
        _employeeSegment.selectedSegmentIndex=0;
    
    else if (empID==2)
        _employeeSegment.selectedSegmentIndex=1;
    else
        _employeeSegment.selectedSegmentIndex=2;
}

-(void)showAlertwithTitle:(NSString *)title andMsg:(NSString *)message
{
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)segmentValueChanged:(id)sender {
    UISegmentedControl *segcontrol=(UISegmentedControl *)sender;
    
    if(segcontrol.selectedSegmentIndex==0)
        _employeeId=1;
    
    else if (segcontrol.selectedSegmentIndex==1)
        _employeeId=2;
    else
        _employeeId=3;
}

- (IBAction)datePickerValueChanged:(id)sender {
    UIDatePicker *datePicker=(UIDatePicker *)sender;
    NSLog(@"%@",datePicker.date);
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    self.txtAssignDate.text=[dateFormatter stringFromDate:datePicker.date];
    datePicker.hidden=YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==_txtAssignDate)
    {
        _datePicker.hidden=NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==_txtTaskName)
    {
        [_txtTaskName resignFirstResponder];
        [_txtTaskDetail becomeFirstResponder];
    }
    else
    {
        [_txtTaskDetail resignFirstResponder];
        [_txtAssignDate becomeFirstResponder];
    }
    return YES;
}

-(BOOL)checkEmpty
{
   if([_txtTaskName.text isEqualToString:@""])
   {
       [self showAlertwithTitle:@"Error" andMsg:@"Please enter task Name."];
       return  NO;
   }
   else if([_txtTaskDetail.text isEqualToString:@""])
   {
       [self showAlertwithTitle:@"Error" andMsg:@"Please enter task detail."];
       return  NO;
   }
   else if([_txtAssignDate.text isEqualToString:@""])
   {
        [self showAlertwithTitle:@"Error" andMsg:@"Please enter task date."];
        return  NO;
    }
    else
    {
      return YES;
    }
}

-(void)clearFields
{
    _txtTaskName.text=@"";
    _txtTaskDetail.text=@"";
    _txtAssignDate.text=@"";
    [_txtTaskName becomeFirstResponder];
}
@end
