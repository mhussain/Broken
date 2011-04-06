//
//  JenkinsInstanceController.h
//  Broken
//
//  Created by Mujtaba Hussain on 6/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JenkinsInstanceController : UIViewController 
{
	    
}

@property (nonatomic, retain) UITextField *host;
@property (nonatomic, retain) UITextField *port;

- (void)connect;

@end
