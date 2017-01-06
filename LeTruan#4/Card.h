//
//  Card.h
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property int num;
@property int suit;
@property bool mark;

- (Card *) initWithNum: (int) num andSuit: (int) suit;
- (void) changeBool;
- (NSString *) toString;

@end
