//
//  Deck.h
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property NSMutableArray *deck;

- (Deck *) initWithHigh: (int) h andLow: (int) l;
- (void) shuffleDeck;
- (Card *) deal;
- (int) count;

- (void) changeAceHigh;
- (void) changeAceLow;
@end
