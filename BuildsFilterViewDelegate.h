//
//  BuildsFilterViewDelegate.h
//  Broken
//
//  Created by Mujtaba Hussain on 10/06/11.
//  Copyright 2011 REA Group. All rights reserved.
//

@protocol BuildsFilterViewDelegate <NSObject>

- (void)filterFailingBuilds;
- (void)filterPassingBuilds;
- (void)filterAllBuilds;

@end
