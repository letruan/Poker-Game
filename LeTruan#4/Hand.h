//
//  EvaluateHand.h
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Hand : NSObject

@property NSMutableArray *hand;

- (id) initWithHand: (NSMutableArray*) h;
- (int) handValue;

/* m file methods
- (BOOL) isFlush;
- (BOOL) isStraight;
- (BOOL) is4s;
- (BOOL) isFullHouse;
- (BOOL) is3s;
- (BOOL) is22s;
- (BOOL) is2s;


- (int) valueStraightFlush;
- (int) valueFourOfAKind;
- (int) valueFullHouse;
- (int) valueFlush;
- (int) valueStraight;
- (int) valueSet;
- (int) valueTwoPairs;
- (int) valueOnePair;
- (int) valueHighCard;



- (void) sortBySuit;
- (void) sortByRank;
*/
@end
