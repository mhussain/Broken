//
//  Build.h
//  Broken
//
//  Created by Mujtaba Hussain on 7/04/11.
//  Copyright 2011 REA Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Build : NSObject 
{
  NSString *name_;
  NSString *url_;
  UIColor *currentState_;
  BOOL broken;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, retain) UIColor *currentState;
//@property (nonatomic, copy) BOOL *broken;

+ (id)buildFromDictionary:(NSDictionary *)dictionary;
- (void)setBroken:(BOOL)yesOrNo;
- (BOOL)isBroken;

@end
