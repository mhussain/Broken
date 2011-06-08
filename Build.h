//
//  Build.h
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IBAForms/IBAInputManager.h>

@interface Build : NSObject 
{
  NSString *name_;
  NSString *url_;
  UIColor *currentState_;
	NSString *description_;
  NSString *lastBuildURL_;
  NSString *culprit_;
  NSString *comment_;
  NSString *brokenWhen_;
  NSString *commitID_;
  
  BOOL defaultPush;
  BOOL broken;
  BOOL stable;

}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) UIColor *currentState;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *lastBuildURL;
@property (nonatomic, copy) NSString *culprit;
@property (nonatomic, copy) NSString *commitID;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *brokenWhen;

+ (id)buildFromDictionary:(NSDictionary *)dictionary;

- (void)setBroken:(BOOL)yesOrNo;
- (BOOL)isBroken;

- (BOOL)isStable;

- (BOOL)wasDefaultPush;
- (void)setDefaultPush:(BOOL)yesOrNo;

@end
