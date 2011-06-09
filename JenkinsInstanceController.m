//
//  JenkinsInstanceController.m
//  Broken
//
//  Created by Mujtaba Hussain on 6/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "JenkinsInstanceController.h"
#import "JSON.h"
#import "UIColor+Hex.h"

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
    [host_label setBackgroundColor:[UIColor clearColor]];
    [host_label setTextColor:[UIColor whiteColor]];
    [host_label setText:@"Host"];
    
    UILabel *port_label = [[[UILabel alloc] initWithFrame:CGRectMake(10., 50., 170., 30.)] autorelease];
    [port_label setText:@"Port"];
    [port_label setBackgroundColor:[UIColor clearColor]];
    [port_label setTextColor:[UIColor whiteColor]];

    
    _host = [[UITextField alloc] initWithFrame:CGRectMake(100., 10., 200., 30.)];
    [_host setBorderStyle:UITextBorderStyleRoundedRect];
    [_host setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    NSString *hostname = [self retrieveFromUserDefaults:@"host"];
    if (hostname) 
    {
      [_host setText:hostname];
    }
    else
    {
      [_host setPlaceholder:@"http://...."];
    }
   
    _port = [[UITextField alloc] initWithFrame:CGRectMake(100., 50., 200., 30.)];
    [_port setBorderStyle:UITextBorderStyleRoundedRect];
    [_port setAutocorrectionType:UITextAutocorrectionTypeNo]; 
    [_port setKeyboardType:UIKeyboardTypeNumberPad];

    NSString *port = [self retrieveFromUserDefaults:@"port"];    
    if (port) 
    {
      [_port setText:port];
    }
    else
    {
      [_port setPlaceholder:@"8080"];
    }
    
   UIButton *connect = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    [connect setFrame:CGRectMake(30., 100., 250., 30.)];
    [[connect imageView] setExclusiveTouch:YES];
    [connect setShowsTouchWhenHighlighted:YES];
    
    [connect setTitle:@"Connect to Jenkins" forState:UIControlStateNormal];
    [connect setBackgroundImage:[UIImage imageNamed:@"buttonBg.png"] forState:UIControlStateNormal];
    [connect setTitle:@"Connecting ..." forState:UIControlStateSelected];
    [connect addTarget:self action:@selector(connect) forControlEvents:UIControlEventTouchUpInside];
    
    [add_host addSubview:host_label];    
    [add_host addSubview:_host];
    
    [add_host addSubview:port_label];
    [add_host addSubview:_port];
    
    [add_host addSubview:connect];
    [add_host setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    
    [self setView:add_host];
    [[self navigationItem] setHidesBackButton:YES];
  }
  
  return self;
}

-(void)saveToUserDefaults:(NSString*)data forKey:(NSString *)key;
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
  
	if (standardUserDefaults) {
		[standardUserDefaults setObject:data forKey:key];
		[standardUserDefaults synchronize];
	}
}

-(NSString*)retrieveFromUserDefaults:(NSString *)key;
{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *val = nil;
	
	if (standardUserDefaults) 
		val = [standardUserDefaults objectForKey:key];
	
	return val;
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
  
  [self saveToUserDefaults:hostname forKey:@"host"];
  [self saveToUserDefaults:port forKey:@"port"];
  
  BuildsController *builds_controller = [[[BuildsController alloc] initWithStyle:UITableViewStyleGrouped 
                                                                         address:[NSString stringWithFormat:@"%@:%@/api/json",hostname,port]] autorelease];
  
  //[self navigationItem] a
  [[self navigationController] pushViewController:builds_controller animated:YES];
  
  //UINavigationController *temp = [[[UINavigationController alloc] initWithNibName:nil bundle:nil] autorelease];
  //[self presentModalViewController:builds_controller animated:YES]; 
  
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
  [[self navigationItem] setHidesBackButton:YES];
}


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
