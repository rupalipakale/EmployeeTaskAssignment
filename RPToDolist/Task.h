//
//  Task.h
//  RPToDolist
//
//  Created by Student P_07 on 05/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Task : NSManagedObject
@property int TaskID;
@property (nonatomic,strong)NSString *TaskName;
@property (nonatomic,strong)NSString *TaskDetail;
@property (nonatomic,strong)NSString *TaskDate;
@property NSInteger employeeID;
@end
