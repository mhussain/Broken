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
      
      UITextView *description = [[[UITextView alloc] initWithFrame:CGRectMake(10., 10., 300., 80.)] autorelease];
      
      [description setTextAlignment:UITextAlignmentLeft];
      [description setUserInteractionEnabled:NO];
      [description setFont:[UIFont systemFontOfSize:16.]];

      [description setBackgroundColor:[UIColor colorWithHex:0xEEE9E9]];
      [description setText:[_build description]];
  
      [build_view addSubview:description];
      //[build_view setBackgroundColor:[UIColor colorWithHex:0xCDC9C9]];
      [build_view setBackgroundColor:[UIColor clearColor]];
      
      UILabel *commit_id = [[[UILabel alloc] initWithFrame:CGRectMake(10., 100., 300., 30.)] autorelease];
      [commit_id setText:[@" ID: " stringByAppendingString:[_build commitID]]];
      [commit_id setFont:[UIFont systemFontOfSize:12.]];
      [commit_id setBackgroundColor:[UIColor colorWithHex:0xEEE9E9]];

      UILabel *culprit = [[[UILabel alloc] initWithFrame:CGRectMake(10., 140, 300., 30.)] autorelease];
      [culprit setText:[@" Who: " stringByAppendingString:[_build culprit]]];
      [culprit setFont:[UIFont systemFontOfSize:12.]];
      [culprit setBackgroundColor:[UIColor colorWithHex:0xEEE9E9]];

      UILabel *comment = [[[UILabel alloc] initWithFrame:CGRectMake(10., 190, 300., 30.)] autorelease];
      [comment setText:[@" Why: " stringByAppendingString:[_build comment]]];
      [comment setFont:[UIFont systemFontOfSize:12.]];
      [comment setBackgroundColor:[UIColor colorWithHex:0xEEE9E9]];

      UILabel *brokenWhen = [[[UILabel alloc] initWithFrame:CGRectMake(10., 240, 300., 30.)] autorelease];
      [brokenWhen setText:[@" When: " stringByAppendingString:[_build brokenWhen]]];
      [brokenWhen setFont:[UIFont systemFontOfSize:12.]];
      [brokenWhen setBackgroundColor:[UIColor colorWithHex:0xEEE9E9]];

      [build_view addSubview:commit_id];
      [build_view addSubview:culprit];
      [build_view addSubview:comment];
      [build_view addSubview:brokenWhen];

      
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
 
  
  NSString *last_build_url = [[_build lastBuildURL] stringByAppendingString:@"/api/json"];
  //NSString *last_build_url = [NSString stringWithString:@"http://ci.dev.int.realestate.com.au:8080/job/accpac/21/api/json"];
  
  ASIHTTPRequest *local_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:last_build_url]];
  
  [local_request startSynchronous];
  
  if (![local_request error]) 
  { 
    [self getLastBuildDataFromResult:local_request];
  }
  

}

- (void)getLastBuildDataFromResult:(ASIHTTPRequest *)request;
{
  NSString *json_string = [request responseString];
  SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
  
  NSDictionary *build_data = [parser objectWithString:json_string error:nil];

  NSDictionary *changeSet = [build_data objectForKey:@"changeSet"];
  NSArray *items = [changeSet objectForKey:@"items"];
  
  if ([items count] == 0) 
  {
    return ;
  }
  
  NSDictionary *first_item = [items objectAtIndex:0];
  
  NSString *full_name = [[first_item objectForKey:@"author"] objectForKey:@"fullName"];

  [_build setCommitID:[first_item objectForKey:@"id"]];
  [_build setBrokenWhen:[first_item objectForKey:@"date"]];
  [_build setComment:[first_item objectForKey:@"comment"]];
  [_build setCulprit:full_name];
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
