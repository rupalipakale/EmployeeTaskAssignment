//
//  ViewController.h
//  RPToDolist
//
//  Created by Student P_07 on 04/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger employeeID;
    NSArray *TaskArray;
    NSIndexPath *selectedIndex;
    
}
@property BOOL isAddClicked;
@property (strong, nonatomic) IBOutlet UISegmentedControl *employeeSegment;
@property (strong, nonatomic) IBOutlet UITableView *tableTasklist;

- (IBAction)addTask:(id)sender;
- (IBAction)segmentValueChanged:(id)sender;
@end

