//
//  Connection.m
//  Broken
//
//  Created by Mujtaba Hussain on 15/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import "Connection.h"
#import <IBAForms/IBAForms.h>

@implementation Connection

- (id)initWithModel:(id)aModel {
	if ((self = [super initWithModel:aModel])) {
		// Some basic form fields that accept text input
		IBAFormSection *basicFieldSection = [self addSectionWithHeaderTitle:@"Server Settings" footerTitle:nil];
    
    [basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"host" title:@"Host"] autorelease]];
		[basicFieldSection addFormField:[[[IBATextFormField alloc] initWithKeyPath:@"port" title:@"Port"] autorelease]];
    [basicFieldSection addFormField:[[[IBAButtonFormField alloc] initWithTitle:@"Connect to Jenkins"
                                                                       icon:nil
                                                             executionBlock:^{}] autorelease]];

    
  }
  
  return self;
}

@end
