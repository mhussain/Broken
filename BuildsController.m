//
//  BuildsController.m
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "BuildsController.h"
#import "BrokenBuildController.h"

#import "JenkinsInstanceController.h"

#import "OverlayView.h"

@implementation BuildsController

-(id)initWithStyle:(UITableViewStyle)style;
{
  return [self initWithStyle:style address:nil];
}

- (id) initWithStyle:(UITableViewStyle)style defaults:(NSUserDefaults *)defaults;
{
  NSString *host = [defaults objectForKey:@"host"];
  NSString *port = [defaults objectForKey:@"port"];
  
  NSString *address = [NSString stringWithFormat:@"%@:%@/api/json", host, port];
  return [self initWithStyle:style address:address];
}

- (id)initWithStyle:(UITableViewStyle)style address:(NSString *)address;
{
  self = [super initWithStyle:style];
   
  if (self) {
    
    [[self tableView] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] 
                                                   initWithTitle:@"Settings" 
                                                   style:UIButtonTypeRoundedRect
                                                   target:self 
                                                   action:@selector(settings)] autorelease] animated:YES];
    
    [[self navigationItem] setLeftBarButtonItem:[[[UIBarButtonItem alloc] 
                                                   initWithTitle:@"Refresh" 
                                                   style:UIButtonTypeRoundedRect
                                                   target:self 
                                                   action:@selector(refresh)] autorelease] animated:YES];
    
  
    [self setTitle:@"Builds"];
    [[self navigationController] setNavigationBarHidden:YES];
        
    searchBar_ = [[[UISearchBar alloc] initWithFrame:CGRectMake(2., 5., 12., 15.)] autorelease];
    [searchBar_ setDelegate:self];
    
    [searchBar_ setShowsCancelButton:YES animated:YES];
    [searchBar_ setBarStyle:UIBarStyleBlackTranslucent];
    
    [searchBar_ setPlaceholder:@"Search for a build"];
    [searchBar_ setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [searchBar_ respondsToSelector:@selector(searchBarTapped)];
    [searchBar_ sizeToFit];
    
    CGRect overlayFrame = CGRectMake(0., [searchBar_ frame].size.height, [[self tableView] bounds].size.width, [[self tableView] bounds].size.height);
    
    OverlayView *overlayView = [[[OverlayView alloc] initWithFrame:overlayFrame] autorelease];
    [overlayView addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                               action:@selector(tappedOverlay)] autorelease]];
    [self setOverlay:overlayView];

    
    [[self tableView] setTableHeaderView:searchBar_]; 
    
    UIBarButtonItem *brokenBuilds = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks 
                                                                                   target:self 
                                                                                   action:@selector(displayBrokenBuilds)] autorelease];
    UIBarButtonItem *passingBuilds = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                                    target:self 
                                                                                    action:@selector(displayPassingBuilds)] autorelease];
    
    CGFloat filterToolbarYOrigin = [[self view] frame].size.height - [searchBar_ frame].size.height - 10;
    UIView *filterToolbarView = [[[UIView alloc] initWithFrame:CGRectMake(0., filterToolbarYOrigin,
                                                                      [[self tableView] bounds].size.width, 
                                                                      [searchBar_ frame].size.height)] autorelease];
    UIToolbar *filterToolbar = [[[UIToolbar alloc] initWithFrame:CGRectZero] autorelease];
    [filterToolbar setItems:[NSArray arrayWithObjects:brokenBuilds,passingBuilds, nil] animated:YES];
    [filterToolbar setBarStyle:UIBarStyleBlackTranslucent];
    [filterToolbarView addSubview:filterToolbar];
    [filterToolbarView sizeToFit];
    [filterToolbarView layoutSubviews];
    
    [[self navigationController] setToolbarHidden:NO animated:NO];
    //[[self view] addSubview:filterToolbarView];
    [[self view] layoutSubviews];

    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:address]];
    [request setDelegate:self];
    [request startAsynchronous];

  }
  
  return self;
}

- (void)dealloc;
{
  [searchBar_ dealloc];
  [_builds dealloc];
  [overlay_ dealloc];
  [super dealloc];
}

@synthesize builds = _builds;
@synthesize overlay = overlay_;
@synthesize searchBar = searchBar_;

#pragma mark - NavBarButtons

- (void)refresh;
{
  NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
  NSString *address = [NSString stringWithFormat:@"%@:%@/api/json",
                        [settings objectForKey:@"host"],
                        [settings objectForKey:@"port"]];
  
  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:address]];
  [request setDelegate:self];
  [request startAsynchronous];
}


- (void)settings;
{
  JenkinsInstanceController *settings = [[[JenkinsInstanceController alloc] initWithNibName:nil bundle:nil] autorelease];
  [[self navigationController] pushViewController:settings animated:YES];
}

- (void)tappedOverlay;
{
  [[self overlay] removeFromSuperview];
  [[self searchBar] resignFirstResponder];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request;
{
  
}

- (void)requestFinished:(ASIHTTPRequest *)request;
{
  NSString *json_string = [request responseString];
  
  SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
  
  NSDictionary *object = [parser objectWithString:json_string error:nil];
  NSArray *builds = [[object objectForKey:@"jobs"] asBuilds];
  
  [self setBuilds:(NSMutableArray *)builds];
  [[self tableView] reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
  NSLog(@"Error Fetching Data %@",[error description]);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  [[self navigationItem] setRightBarButtonItem:[[[UIBarButtonItem alloc] 
                                                 initWithTitle:@"Settings" 
                                                 style:UIButtonTypeRoundedRect
                                                 target:self 
                                                 action:@selector(settings)] autorelease] animated:YES];
  
  [super viewDidLoad];
  [[self navigationItem] setHidesBackButton:YES];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
  //return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [[self builds] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                   reuseIdentifier:CellIdentifier] autorelease];
  }
  
  
  Build *build = [[self builds] objectAtIndex:[indexPath row]];
  [[cell textLabel] setText:[build name]];
  [[cell textLabel] setTextColor:[build currentState]];
  
  if ([build isBroken]) {
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  }
  else if([build isStable]) {
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
  }
  else {
    UIActivityIndicatorView *spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    [spinner startAnimating];
    [spinner setHidden:NO];
    [cell setAccessoryView:spinner];
  }
  
  return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  Build *build = [[self builds] objectAtIndex:[indexPath row]];
  
  if ([build isStable]) {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Stable build" 
                                                     message:@"Well Done!" 
                                                    delegate:nil 
                                           cancelButtonTitle:@"OK!" 
                                           otherButtonTitles:nil, nil] autorelease];
    [alert show]; 
  }
  else if ([build isBroken]) {
    
    BrokenBuildController *brokenBuildController = [[[BrokenBuildController alloc] initWithNibName:nil 
                                                                                            bundle:nil 
                                                                                       brokenBuild:build] autorelease];
    
    [[self navigationController] pushViewController:brokenBuildController animated:YES];
  
  }
  else {
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Building" 
                                                     message:@"Please let it build!" 
                                                    delegate:nil 
                                           cancelButtonTitle:@"OK!" 
                                           otherButtonTitles:nil, nil] autorelease];
    [alert show];
  }
}

#pragma mark - SearchBarDelegate

- (void)searchBarTapped;
{
  [self becomeFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
  [searchBar setShowsScopeBar:YES];
  [searchBar sizeToFit];
  [searchBar setShowsCancelButton:YES animated:YES];
  
  [[self view] addSubview:[self overlay]];
  
  [UIView beginAnimations:@"FadeIn" context:nil];
  [UIView setAnimationDuration:0.5];
  [UIView commitAnimations];
    
  return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;
{
  [searchBar setShowsCancelButton:NO animated:YES];
  [searchBar sizeToFit];
  [searchBar setShowsScopeBar:NO];
  return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
  NSString *buildToFind = [searchBar text];
  
  if (buildToFind == nil) {
   	return; 
  }
  
  NSMutableArray *searchResults = [self searchForBuild:buildToFind];
  
  [searchBar setShowsCancelButton:NO animated:YES];
  [searchBar resignFirstResponder];
  [[self overlay] removeFromSuperview];
  
  if (searchResults != nil) {
	  [self setBuilds:searchResults];
  	[[self tableView] reloadData];
  }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar;
{
  [searchBar setText:@""];
  [searchBar resignFirstResponder];
  [searchBar setShowsCancelButton:NO animated:YES];
  
  [[self overlay] removeFromSuperview];
}

#pragma mark - Search

- (NSMutableArray *)searchForBuild:(NSString *)buildName;
{
  NSMutableArray *matchedBuilds = [[[NSMutableArray alloc] init] autorelease];
	if (nil != buildName) {
    
    for (Build *build in _builds) {
      
      if ([buildName isEqualToString:[build name]]) {
        [matchedBuilds insertObject:build atIndex:0];
      }
      
    }
    
  }
  
  return matchedBuilds;
}
@end
