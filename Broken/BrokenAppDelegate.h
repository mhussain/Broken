//
//  BrokenAppDelegate.h
//  Broken
//
//  Created by Mujtaba Hussain on 6/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JenkinsInstanceController.h"

@interface BrokenAppDelegate : NSObject <UIApplicationDelegate> {
	JenkinsInstanceController *jenkins_instance_controller;
  BuildsController *builds_controller;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

- (void)displaySplash;
- (void)delayedHideSplash:(UIView *)splash;

@end
