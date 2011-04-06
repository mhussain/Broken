//
//  BuildsController.m
//  Broken
//
//  Created by Mujtaba Hussain on 6/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "BuildsController.h"

- (id)initWithStyle:(UITableViewStyle)style;
{
  
  if ((self = [super initWithStyle:style]))
  {
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Search", @"Search")
                                                               style:UIBarButtonItemStyleBordered 
                                                              target:self 
                                                              action:@selector(something)];
    [[self navigationItem] setRightBarButtonItem:button];
    
    //[self setToolbarItems:[NSMutableArray arrayWithObjects:button, nil] animated:YES];
    
    [self setTitle:@"Blame Thower Builds"];
    
    NSString *build_server  = [self buildServer:@"conf.plist"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:build_server]];
    [request setDelegate:self];
    [request startAsynchronous];
    
  }
  
  return self;
}

- (void) something
{
  //UIView *hello = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 12)] autorelease];
  //UILabel *text = [[[[UIView alloc] initWithFrame:CGRectZero] setText:@"hello"] autorelease];
  //[hello addSubview:text];
  //[self presentModalViewController:[[UIViewController alloc]  autorelease] animated:YES];
}

- (void)dealloc
{
  [builds_ release];
  
  [super dealloc];
}

@synthesize builds = builds_;

#pragma mark -
#pragma mark View lifecycle

/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }
 */

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  // Return the number of sections.
  return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return [[self builds] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  
  Build *build = [[self builds] objectAtIndex:[indexPath row]];
  [[cell textLabel] setText:[build name]];
  [[cell textLabel] setTextColor:[build color]];
  
  return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  Build *build = [builds_ objectAtIndex:[indexPath row]];
  
  SelectedBuildController *buildController = [[[SelectedBuildController alloc] initWithStyle:UITableViewStylePlain build:build] autorelease];
  
  [[ self navigationItem ]setBackBarButtonItem: [[[UIBarButtonItem alloc] initWithTitle:@"Builds" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease]];    
  [[self navigationController] pushViewController:buildController animated:NO];
  
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
  // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
  // For example: self.myOutlet = nil;
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate

- (void)requestStarted:(ASIHTTPRequest *)request;
{
  
}
//- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
//- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL;
- (void)requestFinished:(ASIHTTPRequest *)request;
{
  NSString *json_string = [request responseString];
  
  SBJsonParser *parser = [[[SBJsonParser alloc] init] autorelease];
  
  NSDictionary *object = [parser objectWithString:json_string error:nil];
  NSArray *builds = [[object objectForKey:@"jobs"] asBuilds];
  
  [self setBuilds:builds];
  [[self tableView] reloadData];
}

//- (void)requestFailed:(ASIHTTPRequest *)request;
//- (void)requestRedirected:(ASIHTTPRequest *)request;

- (NSString *)buildServer:(NSString *)file_name;
{
  NSString *path = [[NSBundle mainBundle] bundlePath];
  NSString *finalPath = [path stringByAppendingPathComponent:file_name];
  NSDictionary *plist_data = [NSDictionary dictionaryWithContentsOfFile:finalPath];  
  
  return [plist_data objectForKey:@"test-server"];
  
}

@end