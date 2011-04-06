//
//  BuildsController.h
//  Broken
//
//  Created by Mujtaba Hussain on 6/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import <UIKit/UIKit.h>



@interface BuildsTableViewController : UITableViewController <ASIHTTPRequestDelegate>
{
  NSArray *builds_;
}

@property (nonatomic, copy) NSArray *builds;
- (NSString *)buildServer:(NSString *)file_name;

@end
