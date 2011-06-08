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

@class OverlayView;

@interface BuildsController : UITableViewController <ASIHTTPRequestDelegate, UISearchBarDelegate>
{
  NSMutableArray *_builds;
  OverlayView *overlay_;
  UISearchBar *searchBar_;
}

- (id)initWithStyle:(UITableViewStyle)style address:(NSString *)address;
- (id)initWithStyle:(UITableViewStyle)style defaults:(NSUserDefaults *)defaults;
- (void)refresh;
- (void)settings;
- (NSMutableArray *)searchForBuild:(NSString *)buildName;

@property (nonatomic, copy) NSMutableArray *builds;
@property (nonatomic, retain) OverlayView *overlay;
@property (nonatomic, retain) UISearchBar *searchBar;

@end
