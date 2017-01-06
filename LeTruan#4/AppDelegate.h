//
//  AppDelegate.h
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic) BOOL *pokerType;
@property (nonatomic, weak) NSString *player;
@property (nonatomic) int schmeckles;

@end

