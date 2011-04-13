//
//  BuildsController.h
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "NSArray+Build.h"
#import "NSArray+Blocks.h"
#import "Build.h"


@interface BuildsController : UITableViewController <ASIHTTPRequestDelegate>
{
  NSArray *_builds;
}

- (id)initWithStyle:(UITableViewStyle)style address:(NSString *)address;
- (id)initWithStyle:(UITableViewStyle)style defaults:(NSUserDefaults *)defaults;
- (void)refresh;
- (void)settings;

@property (nonatomic, copy) NSArray *builds;

@end
