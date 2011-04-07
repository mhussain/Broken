//
//  BrokenBuildController.m
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "BrokenBuildController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@implementation BrokenBuildController

@synthesize build = _build;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
{
	return [self initWithNibName:nibNameOrNil bundle:nibBundleOrNil brokenBuild:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil brokenBuild:(Build *)build;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
    if (self) {
      _build = [build retain];
      [self setTitle:[_build name]];
      
      NSString *url = [[build url] stringByAppendingString:@"/api/json"];
      
      ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
      //[request setDelegate:self];
      [request startSynchronous];
      
      if (![request error]) {
        [self getBuildDataFromRequest:request];
      }
      
      UIView *build_view = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
      
			//UILabel *description = [[[UILabel alloc] initWithFrame:CGRectMake(10., 10., 200., 30.)] autorelease];
      UITextView *description = [[[UITextView alloc] initWithFrame:CGRectMake(10., 10., 300., 80.)] autorelease];
      [description setTextAlignment:UITextAlignmentLeft];
      [description setUserInteractionEnabled:NO];
      [description setFont:[UIFont systemFontOfSize:16.]];

      [description setBackgroundColor:[UIColor colorWithHex:0xEEE9E9]];
      [description setText:[_build description]];
  
      [build_view addSubview:description];
      [build_view setBackgroundColor:[UIColor colorWithHex:0xCDC9C9]];
      
      [self setView:build_view];

    }
  
    return self;
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request;
{
  
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
  
}

- (void)getBuildDataFromRequest:(ASIHTTPRequest *)request;
{
  NSString *json_string = [request responseString];
  
  SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
  
  NSDictionary *build_data = [parser objectWithString:json_string error:nil];
	[_build setDescription:[build_data objectForKey:@"description"]];
  [_build setLastBuildURL:[[build_data objectForKey:@"lastBuild"] objectForKey:@"url"]];
}

- (void)dealloc
{
  [_build release];
  [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
