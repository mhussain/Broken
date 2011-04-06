//
//  JenkinsInstanceController.h
//  Broken
//
//  Created by Mujtaba Hussain on 6/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuildsController.h"

@interface JenkinsInstanceController : UIViewController 
{
  BuildsController *builds;   
}

@property (nonatomic, retain) UITextField *host;
@property (nonatomic, retain) UITextField *port;

- (void)connect;
-(NSString*)retrieveFromUserDefaults:(NSString *)key;
-(void)saveToUserDefaults:(NSString*)data forKey:(NSString *)key;

@end
