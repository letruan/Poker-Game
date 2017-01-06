//
//  EvaluateHand.m
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import "Hand.h"
#import "HandType.h"

@implementation Hand
@synthesize hand;

-(id) initWithHand:(NSMutableArray *)h {
    
    self = [super init];
    
    if (self) {
        hand = h;
    }
    
    return self;
}

// Return hand value
- (int) handValue {
    
    if ([self isFlush] && [self isStraight])
        return [self valueStraightFlush];
    else if ([self is4s])
        return [self valueFourOfAKind];
    else if ([self isFullHouse])
        return [self valueFullHouse];
    else if ([self isFlush])
        return [self valueFlush];
    else if ([self isStraight])
        return [self valueStraight];
    else if ([self is3s])
        return [self valueSet];
    else if ([self is22s])
        return [self valueTwoPairs];
    else if ([self is2s])
        return [self valueOnePair];
    else
        return [self valueHighCard];
    
}

/* Methods used to determine poker hand value*/

- (int) valueStraightFlush {
    return STRAIGHT_FLUSH + [self valueHighCard];
}

- (int) valueFourOfAKind {
    [self sortByRank];
    
    return FOUR_OF_A_KIND + [[hand objectAtIndex:2] num];
}

- (int) valueFullHouse {
    [self sortByRank];
    
    return FULL_HOUSE + [[hand objectAtIndex:2] num];
}

- (int) valueFlush {
    return FLUSH + [self valueHighCard];
}

- (int) valueStraight {
    return STRAIGHT + [self valueHighCard];
}

- (int) valueSet {
    [self sortByRank];
    
    return THREE_OF_A_KIND + [[hand objectAtIndex:2] num];
}

- (int) valueTwoPairs {
    
    int val = 0;
    
    [self sortByRank];
    
    if ([[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] &&
        [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num]) {
        val = 14*14*[[hand objectAtIndex:2] num] + 14*[[hand objectAtIndex:0] num] + [[hand objectAtIndex:4] num];
    }
    else if ([[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] &&
             [[hand objectAtIndex:3] num] == [[hand objectAtIndex:4] num]) {
        val = 14*14*[[hand objectAtIndex:3] num] + 14*[[hand objectAtIndex:0] num] + [[hand objectAtIndex:2] num];
    }
    else {
        val = 14*14*[[hand objectAtIndex:3] num] + 14*[[hand objectAtIndex:1] num] + [[hand objectAtIndex:0] num];
    }
    
    return TWO_PAIR + val;
}

- (int) valueOnePair {
    int val = 0;
    
    [self sortByRank];
    
    if ( [[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] ){
        val = 14*14*14*[[hand objectAtIndex:0]num] + [[hand objectAtIndex:2] num] + 14*[[hand objectAtIndex:3]num] + 14*14*[[hand objectAtIndex:4]num];
    }
    else if ( [[hand objectAtIndex:1] num] == [[hand objectAtIndex:2] num] ){
        val = 14*14*14*[[hand objectAtIndex:1]num] + [[hand objectAtIndex:0]num] + 14*[[hand objectAtIndex:3]num] + 14*14*[[hand objectAtIndex:4]num];
    }
    else if ( [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num] ){
        val = 14*14*14*[[hand objectAtIndex:2]num] + [[hand objectAtIndex:0]num] + 14*[[hand objectAtIndex:1]num] + 14*14*[[hand objectAtIndex:4]num];
    }
    else {
        val = 14*14*14*[[hand objectAtIndex:3]num] + [[hand objectAtIndex:0]num] + 14*[[hand objectAtIndex:1]num] + 14*14*[[hand objectAtIndex:2]num];
    }
    
    return PAIR + val;
    
}

- (int) valueHighCard {
    int val;
    
    [self sortByRank];
    
    val = [[hand objectAtIndex:0] num] + 14*[[hand objectAtIndex:1] num] + 14*14*[[hand objectAtIndex:2] num] +
            14*14*14*[[hand objectAtIndex:3]num] + 14*14*14*14*[[hand objectAtIndex:4] num];
    
    return HIGH_CARD + val;
}

/* Methods usesd to determine a certain poker hand */

- (BOOL) isFlush {
    
    [self sortBySuit]; // Sort cards by suit value
    
    // All cards has same suit
    if ([[hand objectAtIndex:0] suit] == [[hand objectAtIndex:4] suit]) {
        return YES;
    }
    
    return NO;
}

- (BOOL) isStraight {
    
    int i, testRank;
    
    [self sortByRank];
    
    // Ace is High
    if ([[hand objectAtIndex:4] num] == 14 ) {
        
        // Checks for straight using ace high
        BOOL b = [[hand objectAtIndex:0] num] == 10 && [[hand objectAtIndex:1] num] == 11
        && [[hand objectAtIndex:2] num] == 12 && [[hand objectAtIndex:3] num] == 13;
        
        return b;
    }
    
    // Ace is low
    else if ([[hand objectAtIndex:0] num] == 0 ) {
        
        // Checks for straight using ace low
        BOOL a = [[hand objectAtIndex:1] num] == 2 && [[hand objectAtIndex:2] num] == 3
        && [[hand objectAtIndex:3] num] == 4 && [[hand objectAtIndex:4] num] == 5;
        
        // Checks for straight using ace high
        BOOL b = [[hand objectAtIndex:0] num] == 10 && [[hand objectAtIndex:1] num] == 11
        && [[hand objectAtIndex:2] num] == 12 && [[hand objectAtIndex:3] num] == 13;
        
        return (a || b);
    }
    else {
        
        // General straight
        testRank = [[hand objectAtIndex:0] num] + 1;
        
        for (i = 1; i < 5; i++) {
            
            if ([[hand objectAtIndex:i] num] != testRank)
                return NO; // straight fail
            
            testRank++;
        }
        
        return YES; // straight found
    }
}

- (BOOL) is4s {
    
    BOOL a1, a2;
    
    [self sortByRank]; // Sort array
    
    // Check for 4 cards of same rank + higher ranked unmatched card
    a1 = [[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] &&
        [[hand objectAtIndex:1] num] == [[hand objectAtIndex:2] num] &&
        [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num];
    
    // Check for lower ranked unmatched card + 4 cards of the same rank
    a2 = [[hand objectAtIndex:1] num] == [[hand objectAtIndex:2] num] &&
        [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num] &&
        [[hand objectAtIndex:3] num] == [[hand objectAtIndex:4] num];
    
    return (a1 || a2);
}

- (BOOL) isFullHouse {
    
    BOOL a1, a2;
    
    [self sortByRank];
    
    // Check x x y y y
    a1 = [[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] &&
    [[hand objectAtIndex:1] num] == [[hand objectAtIndex:2] num] &&
    [[hand objectAtIndex:3] num] == [[hand objectAtIndex:4] num];
    
    // Check y y y x x
    a2 = [[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] &&
    [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num] &&
    [[hand objectAtIndex:3] num] == [[hand objectAtIndex:4] num];
    
    return (a1 || a2);
}

- (BOOL) is3s {
    
    BOOL a1, a2, a3;
    
    if ([self is4s] || [self isFullHouse])
        return NO;
    
    [self sortByRank];
    
    // Check x x x a b
    a1 = [[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] &&
    [[hand objectAtIndex:1] num] == [[hand objectAtIndex:2] num];
    
    // Check a x x x b
    a2 = [[hand objectAtIndex:1] num] == [[hand objectAtIndex:2] num] &&
    [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num];
    
    
    // Check a b x x x
    a3 = [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num] &&
        [[hand objectAtIndex:3] num] == [[hand objectAtIndex:4] num];
    
    return (a1 || a2 || a3);
}

- (BOOL) is22s {
    BOOL a1, a2, a3;
    
    if ([self is4s] || [self isFullHouse] || [self is3s])
        return NO;
    
    [self sortByRank];
    
    
    // Check a a b b x
    a1 = [[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] &&
        [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num];
    
    // Check a a x b b
    a2 = [[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num] &&
        [[hand objectAtIndex:3] num] == [[hand objectAtIndex:4] num];
    
    
    // Check x a a b b
    a3 = [[hand objectAtIndex:1] num] == [[hand objectAtIndex:2] num] &&
        [[hand objectAtIndex:3] num] == [[hand objectAtIndex:4] num];

    return (a1 || a2 || a3);
}

- (BOOL) is2s {
    
    BOOL a1, a2, a3, a4;
    
    if ([self is4s] || [self isFullHouse] || [self is3s] || [self is22s])
        return NO;
    
    [self sortByRank];
    
    // Check a a x y z
    a1 = [[hand objectAtIndex:0] num] == [[hand objectAtIndex:1] num];
    
    // Check x a a y z
    a2 = [[hand objectAtIndex:1] num] == [[hand objectAtIndex:2] num];
    
    // Check x y a a z
    a3 = [[hand objectAtIndex:2] num] == [[hand objectAtIndex:3] num];

    // Check x y z a a
    a4 = [[hand objectAtIndex:3] num] == [[hand objectAtIndex:4] num];
    
    return (a1 || a2 || a3 || a4);
}

- (void) sortByRank {
    
    int i, j, min_j;
    
    for (i = 0; i < [hand count]; i++) {
        
        min_j = i;
        
        for (j=i+1; j < [hand count]; j++) {
            
            if ([[hand objectAtIndex:j] num] < [[hand objectAtIndex:min_j] num]) {
                
                min_j = j; // Found smaller value, update min_j
            
            }
        }
        
        // Swap
        [hand exchangeObjectAtIndex:i withObjectAtIndex:min_j];
    }
}

- (void) sortBySuit {
    
    int i, j, min_j;
    
    // Selection sort
    for ( i=0; i < [hand count]; i++) {
        
        min_j = i; // Assume elem i is the minimum
        
        for (j = i + 1; j < [hand count]; j++) {
            
            if([[hand objectAtIndex:j] suit] < [[hand objectAtIndex:min_j] suit]){
                
                min_j = j; // Found maller suit value, update min_j
            
            }
        }
        
        // Swap hand[i] an hand[min_j]
        [hand exchangeObjectAtIndex:i withObjectAtIndex:min_j];
    }
}
@end
