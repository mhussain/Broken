//
//  BrokenAppDelegate.m
//  Broken
//
//  Created by Mujtaba Hussain on 6/04/11.
//

#import "BrokenAppDelegate.h"
#import "BuildsController.h"

@implementation BrokenAppDelegate

@synthesize window=_window;
@synthesize navigationController=_navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{
  _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  _navigationController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
  [[_navigationController navigationBar] setBarStyle:UIBarStyleBlack];
  
  NSMutableDictionary *form = [[[NSMutableDictionary alloc] init] autorelease];
  
	// Values set on the model will be reflected in the form fields.
	[form setObject:@"A value contained in the model" forKey:@"readOnlyText"];
    
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  if ([defaults objectForKey:@"host"]) {
		builds_controller = [[BuildsController alloc] initWithStyle:UITableViewStyleGrouped defaults:defaults];
    [_navigationController pushViewController:builds_controller animated:YES];
  }
  else {
    jenkins_instance_controller = [[JenkinsInstanceController alloc] initWithNibName:nil bundle:nil];
    [_navigationController pushViewController:jenkins_instance_controller animated:YES];
  }
  
  [_window setRootViewController:_navigationController];

  [self setWindow:_window];
  [[self window] makeKeyAndVisible];
  [self displaySplash];
  
  return YES;
}

- (void)displaySplash;
{
  UIImageView *splash = [[[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  [splash setTag:909];
  [splash setImage:[UIImage imageNamed:@"Default.png"]];
  
  [_window addSubview:splash];
  [_window bringSubviewToFront:splash];
  
	[self delayedHideSplash:splash];
}

- (void)delayedHideSplash:(UIView *)splash;
{
  [self performSelector:@selector(hideSplash:) withObject:splash afterDelay:1.];
}

- (void)hideSplash:(UIView *)splash;
{
  [UIView beginAnimations:@"hide splash" context:splash];
  
  [UIView setAnimationDuration:0.4];
  [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:[splash window] cache:YES];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(clearSplashWithAnimationID:finished:context:)];
  
  [splash setAlpha:0.];
  
  [UIView commitAnimations];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
	[jenkins_instance_controller release];
  [_window release];
  [builds_controller release];
  [_navigationController release];
  [super dealloc];
}

@end
