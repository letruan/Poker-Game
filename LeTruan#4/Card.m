//
//  Card.m
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import "Card.h"
#import "Suit.h"

@implementation Card

- (Card *) initWithNum: (int) num andSuit: (int) suit {
    self = [super init];
    
    if (self) {
        self.num = num;
        self.suit = suit;
        self.mark = NO;
    }
    
    return self;
}

// Returns a string for current card
- (NSString *) toString {
    NSMutableString *cardStr = [NSMutableString stringWithString:@""];
    
    if (self.num == 1)
        [cardStr appendString:@"Ace"];
    
    else if (self.num == 11)
        [cardStr appendString:@"Jack"];
    
    else if (self.num == 12)
        [cardStr appendString:@"Queen"];
    
    else if (self.num == 13)
        [cardStr appendString:@"King"];
    
    else
        [cardStr appendString:[NSString stringWithFormat:@"%d", self.num]];
    
    
    [cardStr appendString:@" of "];
    [cardStr appendString:[Suit toString:self.suit]];
    
    return cardStr;
}

- (void) changeBool {
    if (self.mark == NO) {
        self.mark = YES;
    }
    else {
        self.mark = NO;
    }
}

@end
