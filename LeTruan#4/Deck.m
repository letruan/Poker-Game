//
//  Deck.m
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import "Deck.h"

@implementation Deck
{
    // Determines ace value on creation of deck
    int high, low;
}
@synthesize deck;

// Initalize the deck with 52 cards
- (Deck*) initWithHigh:(int)h andLow:(int)l {
    high = h;
    low = l;
    
    deck = [[NSMutableArray alloc] init];
    for (int number = low; number <=high; number++){
        
        for (int suit = 0; suit <= 3; suit++) {
            
            [deck addObject:[[Card alloc] initWithNum:number andSuit:suit]];
        }
    }
    
    return self;
}

// Shuffle deck by swaping objects at different indexes
- (void) shuffleDeck {
    int a = (int)[deck count];
    
    for(int b = 0; b < a; b++) {
        int randomObject = arc4random() % [deck count];
        Card *swapObject = [[Card alloc] init];
        swapObject = [deck objectAtIndex:b];
        
        [deck replaceObjectAtIndex:b withObject:[deck objectAtIndex:randomObject]];
        [deck replaceObjectAtIndex:randomObject withObject:swapObject];
    }
}

// Add card to player/dealer hand and remove card from deck
- (Card *) deal {
    Card *cardDealt = [deck objectAtIndex:self.deck.count-1];
    
    // Removes card in array
    [deck removeLastObject];
    
    return cardDealt;
}

- (int) count {
    return (int)[deck count];
}

- (void) changeAceHigh{
    
    for(Card *c in deck){
        if([c num] == 1){
            c.num = 14;
        }
    }
}

- (void) changeAceLow{

    for(Card *c in deck){
        if([c num] == 14){
            c.num = 1;
        }
    }
}


@end
