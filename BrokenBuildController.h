//
//  BrokenBuildController.h
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Build.h"
#import "ASIHTTPRequest.h"
#import "UIColor+Hex.h"

@interface BrokenBuildController : UIViewController {
  Build *_build;   
}

static const NSString *kDefaultInfo = @"This build was pushed by the server. No commit data to report";

@property (nonatomic, retain) Build *build;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil brokenBuild:(Build *)build;
- (void)getBuildDataFromRequest	:(ASIHTTPRequest *)request;
- (void)getLastBuildDataFromResult:(ASIHTTPRequest *)request;
- (void) styleLabel:(UILabel *)label;
@end
