//
//  JenkinsInstanceController.m
//  Broken
//
//  Created by Mujtaba Hussain on 6/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "JenkinsInstanceController.h"
#import "JSON.h"

@implementation JenkinsInstanceController

@synthesize host=_host;
@synthesize port=_port;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

  if (self) 
  {
    [self setTitle:@"Broken?"];
    
    UIView *add_host = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    
    UILabel *host_label = [[[UILabel alloc] initWithFrame:CGRectMake(10., 10., 170., 30.)] autorelease];
    [host_label setText:@"Hostname"];
    
    UILabel *port_label = [[[UILabel alloc] initWithFrame:CGRectMake(10., 50., 170., 30.)] autorelease];
    [port_label setText:@"Port"];
    
    _host = [[UITextField alloc] initWithFrame:CGRectMake(140., 10., 170., 30.)];
    [_host setBorderStyle:UITextBorderStyleBezel];
    [_host setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_host setPlaceholder:@"http://...."];
    
    _port = [[UITextField alloc] initWithFrame:CGRectMake(140., 50., 170., 30.)];
    [_port setBorderStyle:UITextBorderStyleBezel];
    [_port setAutocorrectionType:UITextAutocorrectionTypeNo]; 
    [_port setKeyboardType:UIKeyboardTypeNumberPad];
    [_port setPlaceholder:@"8080"];
    
    UIButton *connect = [[[UIButton alloc] initWithFrame:CGRectMake(30., 100., 250., 30.)] autorelease];
    [connect setBackgroundColor:[UIColor redColor]];
    [connect setClipsToBounds:YES];
    [connect setTitle:@"Connect to Jenkins" forState:UIControlStateNormal];
    
    [connect addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
    [add_host addSubview:host_label];    
    [add_host addSubview:_host];
    [add_host addSubview:port_label];
    [add_host addSubview:_port];
    [add_host addSubview:connect];
    
    [self setView:add_host];
  }
  
  return self;
}

- (void)connect;
{
  NSString *hostname = [_host text];
  NSString *port = [_port text];
  
	if (nil == hostname || nil == port) 
  {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Required Parameters" 
                                                  message:@"Please enter hostname and port number" 
                                                 delegate:nil 
                                        cancelButtonTitle:@"OK" 
                                         otherButtonTitles:nil, nil] autorelease];
    [alert show];
  }
  
  builds = [[BuildsController alloc] initWithStyle:UITableViewStyleGrouped address:[NSString stringWithFormat:@"%@:%@",hostname,port]];
  
	[[ self navigationItem ] setBackBarButtonItem: [[[UIBarButtonItem alloc] initWithTitle:@"Connect" 
                                                                                   style:UIBarButtonItemStyleBordered 
                                                                                  target:nil 
                                                                                  action:nil] autorelease]];
  
  [[self navigationController] pushViewController:builds animated:YES];
  
  
}

- (void)dealloc
{
  [builds release];
  [_host release];
  [_port release];
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
