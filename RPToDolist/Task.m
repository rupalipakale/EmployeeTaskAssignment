//
//  Task.m
//  RPToDolist
//
//  Created by Student P_07 on 05/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "Task.h"

@implementation Task

@synthesize  TaskDate,TaskID,TaskName,TaskDetail,employeeID;

-(instancetype)init
{
    self = [super init];
    if(self)
    {
    TaskID=0;
    TaskDate=@"";
    TaskDetail=@"";
    employeeID=0;
    }
    return self;
}
@end
