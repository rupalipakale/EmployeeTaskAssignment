//
//  ViewController.m
//  RPToDolist
//
//  Created by Student P_07 on 04/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "ViewController.h"
#import "customTableViewCell.h"
#import "AppDelegate.h"
#import "AddTaskViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSManagedObjectContext *context;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    employeeID=1;
    
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    context=appDelegate.persistentContainer.viewContext;
    [self setTitleOfView];
}

-(void)setTitleOfView
{
    self.title=[NSString stringWithFormat:@"%@ Tasks",[_employeeSegment titleForSegmentAtIndex:_employeeSegment.selectedSegmentIndex]];
}

-(void)viewWillAppear:(BOOL)animated{
    [self getData];

}
-(void)getData
{
    NSFetchRequest *fetch=[[NSFetchRequest alloc]initWithEntityName:@"EmployeeTask"];
    NSPredicate *prediCate=[NSPredicate predicateWithFormat:@"employeeid == %ld",employeeID];
    [fetch setPredicate:prediCate];
    NSError *error;
    TaskArray=[context executeFetchRequest:fetch error:&error];
    if(error)
        NSLog(@"%@",error.localizedDescription);
    if(TaskArray.count)
        [_tableTasklist reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TaskArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    customTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"customCell"];
    if(cell==nil)
    {
        cell=[[customTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
    }
    [cell loaddata:[TaskArray objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _isAddClicked=NO;
    selectedIndex=indexPath;
    [self performSegueWithIdentifier:@"AddSegue" sender:nil];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2) {
        cell.backgroundColor = [UIColor whiteColor];
    } else {
        cell.backgroundColor = [UIColor lightGrayColor];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddSegue"])
    {
        
        AddTaskViewController *addTaskVC=[segue destinationViewController];
        if(_isAddClicked)
        {
            addTaskVC.isAddSelect=YES;
        }
        else
        {
            addTaskVC.index=selectedIndex.row;
            addTaskVC.arrUpdate=TaskArray;
            addTaskVC.isAddSelect=NO;
            addTaskVC.taskId=[[[TaskArray objectAtIndex:selectedIndex.row] valueForKey:@"id"] integerValue];
            addTaskVC.employeeId=[[[TaskArray objectAtIndex:selectedIndex.row] valueForKey:@"employeeid"] integerValue];
            addTaskVC.stringTaskName=[[TaskArray objectAtIndex:selectedIndex.row] valueForKey:@"taskname"];
            addTaskVC.stringTaskDetail=[[TaskArray objectAtIndex:selectedIndex.row] valueForKey:@"taskdetails"];
            addTaskVC.stringTaskDate=[[TaskArray objectAtIndex:selectedIndex.row] valueForKey:@"assignmentdate"];
            

        }
    }
    
        
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld",(long)indexPath.row);
        
        NSManagedObject *obj =[TaskArray objectAtIndex:indexPath.row];
        [context deleteObject:obj];
        NSError *error;
        [context save:nil];
        if (error != nil) {
            [self showAlertwithTitle:@"Error" andMsg:error.localizedDescription];
            NSLog(@"%@",error.localizedDescription);
        }
        else
        {
            [self showAlertwithTitle:@"Success" andMsg:@"Task Deleted Successfully"];
        }
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        array = [TaskArray mutableCopy];
        [array removeObjectAtIndex:indexPath.row];
        TaskArray = [array copy];
        [_tableTasklist reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (IBAction)addTask:(id)sender {
    _isAddClicked=YES;
    [self performSegueWithIdentifier:@"AddSegue" sender:nil];
}

- (IBAction)segmentValueChanged:(id)sender {
    UISegmentedControl *segcontrol=(UISegmentedControl *)sender;
    if(segcontrol.selectedSegmentIndex==0)
        employeeID=1;
    
    else if (segcontrol.selectedSegmentIndex==1)
        employeeID=2;
    else
        employeeID=3;
    
    [self getData];
    [self setTitleOfView];

}

@end
