//
//  ConnectionController.m
//  Broken
//
//  Created by Mujtaba Hussain on 15/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "ConnectionController.h"


@implementation ConnectionController

@synthesize shouldAutoRotate = shouldAutoRotate_;
@synthesize tableViewStyle = tableViewStyle_;

- (void)loadView {
	[super loadView];
  
	UITableView *formTableView = [[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:self.tableViewStyle] autorelease];
	[formTableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
	
	[self setTableView:formTableView];
	[self setView:formTableView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return self.shouldAutoRotate;
}

@end
