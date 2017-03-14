//
//  customTableViewCell.m
//  RPToDolist
//
//  Created by Student P_07 on 04/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import "customTableViewCell.h"

@implementation customTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loaddata:(NSDictionary *)dict
{
    _labelTaskName.text=[NSString stringWithFormat:@"Task: %@",[dict valueForKey:@"taskname"]];
    
    _labelTaskDetails.text=[NSString stringWithFormat:@"Task details: %@",[dict valueForKey:@"taskdetails"]];
    _labelTaskDate.text=[NSString stringWithFormat:@"Assigned date: %@",[dict valueForKey:@"assignmentdate"]];
}

@end
