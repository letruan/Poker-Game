//
//  Suit.m
//  LeTruan#4
//
//  Created by Truan Le on 8/3/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import "Suit.h"

@implementation Suit

// Suit consts
int const CLUBS = 0;
int const DIAMONDS = 1;
int const HEARTS = 2;
int const SPADES = 3;


// Return a string representation of a given suit
+ (NSString *) toString:(int)cardSuit {
    if (cardSuit == 0) {
        return @"Club";
    }
    else if (cardSuit == 1) {
        return @"Diamonds";
    }
    else if (cardSuit == 2) {
        return @"Hearts";
    }
    else if (cardSuit == 3) {
        return @"Spades";
    }
    
    return nil;
}

@end
