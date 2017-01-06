//
//  Suit.h
//  LeTruan#4
//
//  Created by Truan Le on 8/3/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Suit : NSObject

+ (NSString *) toString: (int) cardSuit;

extern int const CLUBS;
extern int const DIAMONDS;
extern int const HEARTS;
extern int const SPADES;

@end
