//
//  customTableViewCell.h
//  RPToDolist
//
//  Created by Student P_07 on 04/03/17.
//  Copyright © 2017 Rupali Pakale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelTaskName;
@property (strong, nonatomic) IBOutlet UILabel *labelTaskDate;
@property (strong, nonatomic) IBOutlet UILabel *labelTaskDetails;
-(void)loaddata:(NSDictionary *)dict;
@end
