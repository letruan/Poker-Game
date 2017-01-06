//
//  SecondViewController.m
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import "SecondViewController.h"
#import "Deck.h"
#import "Hand.h"

@interface SecondViewController ()
{
    AppDelegate *delegate;
    Deck *deck;
    int turn; // Keeps track of betting turns
    NSMutableArray *dealer;
    NSMutableArray *player;
    NSMutableArray *texasHoldEmCards;
    Hand *playerEval;
    Hand *dealerEval;
    int high, low;
    BOOL lastGame;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    // Sets values from first controller
    
    // For 5 card draw initalize with back of card placeholder and structure of board
    if (delegate.pokerType == NO) {
   
        self.foldOrDraw.title = @"DRAW";
        
        for(UIButton *card in self.dealerHand){
            UIImage *colorimage = [UIImage imageNamed:@"back.png"];
            [card setBackgroundImage:colorimage forState:UIControlStateNormal];
        }
        
        for(UIButton *card in self.playerHand){
            UIImage *colorimage = [UIImage imageNamed:@"back.png"];
            [card setBackgroundImage:colorimage forState:UIControlStateNormal];
        }
    }
    // For texas holdem initalize with back of card placeholder and structure of board
    else {
   
        self.foldOrDraw.title = @"FOLD";
        
        for(UIButton *card in self.texasCards){
            UIImage *colorimage = [UIImage imageNamed:@"back.png"];
            [card setBackgroundImage:colorimage forState:UIControlStateNormal];
        }
        
        for(UIButton *card in self.dealerHand){
            if (card.tag == 1 || card.tag == 3){
                UIImage *colorimage = [UIImage imageNamed:@"back.png"];
                [card setBackgroundImage:colorimage forState:UIControlStateNormal];
            }
        }
        
        for(UIButton *card in self.playerHand){
            if (card.tag == 1 || card.tag == 3){
                UIImage *colorimage = [UIImage imageNamed:@"back.png"];
                [card setBackgroundImage:colorimage forState:UIControlStateNormal];
            }
        }
    }
    
    self.playerLabel.text = [NSString stringWithFormat:@"%@: $",delegate.player];
    self.playerAmount.text = [NSString stringWithFormat:@"%i",delegate.schmeckles];
    NSLog(@"%i", delegate.schmeckles);
    
    // initalize turn
    turn = 0;
    
    // initalize new deck and print deck count
    high = 13; low = 1;
    deck = [[Deck alloc] initWithHigh:high andLow:low];
    self.deckCount.text = [NSString stringWithFormat:@"%i", [deck count]];
    
    // Initalize hands arrays
    dealer = [NSMutableArray array];
    player = [NSMutableArray array];
    
    // If button is for 5 card draw, it is disable until bet is made
    if (delegate.pokerType == NO){
        self.foldOrDraw.enabled = NO;
    }
    
    lastGame = delegate.pokerType;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeBet:(UIStepper *)sender {
    int value = [sender value];
    
    self.betAmount.text = [NSString stringWithFormat:@"%i", value];
}

- (IBAction)addToPot:(id)sender {
    if(lastGame != delegate.pokerType){
        self.warnings.text = @"Press Reset";
        return;
    }
    
    // Resets labels
    if ([self.outcome.text length] != 0){
        self.outcome.text = @"";
    }
    
    if ([self.warnings.text length] != 0){
        self.warnings.text = @"";
    }

    
    if ([self.playerAmount.text intValue] == 0 && turn == 0) {
        self.warnings.text = @"Bankrupt.";
        return;
    }
    
    if ([self.betAmount.text intValue] == 0 && turn == 0){
        self.warnings.text = @"Make a bet.";
        return;
    }
    
    if ([self.betAmount.text intValue] == 0 && !delegate.pokerType){
        self.warnings.text = @"Make a bet.";
        return;
    }
    
    // Enable draw/fold button
    self.foldOrDraw.enabled = YES;
    
    // Initalize new deck if deck is less than 10 cards
    if([deck count] <= 15 && turn == 0){
        deck = [[Deck alloc] initWithHigh:high andLow:low];
        
        // Updates deck count
        self.deckCount.text = [NSString stringWithFormat:@"%i", [deck count]];
    }
    // Subtract from player amount
    NSString *newAmount = [NSString stringWithFormat:@"%i", [self.playerAmount.text intValue] - [self.betAmount.text intValue]];
    if ([newAmount intValue] >= 0) {
        self.playerAmount.text = newAmount;
        
        // Adds bet to the current pot and dealer adds same amount
        self.potAmount.text = [NSString stringWithFormat:@"%i", [self.potAmount.text intValue] + ([self.betAmount.text intValue]*2)];
    }
    else {
        self.warnings.text = @"Over betting.";
        return;
    }
    
    // Plays poker base on user selection
    // Plays five card poker
    if (delegate.pokerType == NO) {
        
        switch (turn) {
            case 0:
            {
                
                [self reset];
                
                
                // Shuffle Deck and deals cards
                [deck shuffleDeck];
                
                for (int i = 0; i < 10; i++) {
                    if (i % 2 != 0) {
                        [dealer addObject:[deck deal]];
                    }
                    else {
                        [player addObject:[deck deal]];
                    }
                }
                
                int k = 0;
                for (Card *d in player) {
                    if (d.suit == 0){
                        [[self.playerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_clubs.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 1){
                        [[self.playerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_diamonds.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 2){
                        [[self.playerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_hearts.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 3){
                        [[self.playerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_spades.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    
                    k++;
                }
                
                self.betButton.enabled = NO;
                
                turn++;
                break;
            }
            default:
                NSLog(@"Error...");
                self.warnings.text = @"Press Reset";
                break;
        }
        
    }
    // Plays texas hold em
    else {
        
        switch (turn) {
            case 0:
            {
                
                [self reset];
                
                // shuffle the Deck and deals cards
                [deck shuffleDeck];
                
                texasHoldEmCards = [NSMutableArray array];
                
                for (int i = 0; i < 4; i++) {
                    if (i % 2 != 0) {
                        [dealer addObject:[deck deal]];
                    }
                    else {
                        [player addObject:[deck deal]];
                    }
                }
                
                for (int i = 0; i < 3; i++){
                    [texasHoldEmCards addObject:[deck deal]];
                }
                
                // Set player's card image
                int k = 1;
                for (Card *d in player) {
                    if (d.suit == 0){
                        [[self.playerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_clubs.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 1){
                        [[self.playerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_diamonds.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 2){
                        [[self.playerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_hearts.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 3){
                        [[self.playerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_spades.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    
                    k+=2;
                }
                
                // Displays the flop
                
                if ([(Card *)[texasHoldEmCards objectAtIndex:0] suit] == 0){
                    [[self.texasCards objectAtIndex:0] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_clubs.png", [(Card *)[texasHoldEmCards objectAtIndex:0] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:0] suit] == 1){
                    [[self.texasCards objectAtIndex:0] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_diamonds.png", [(Card *)[texasHoldEmCards objectAtIndex:0] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:0] suit] == 2){
                    [[self.texasCards objectAtIndex:0] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_hearts.png", [(Card *)[texasHoldEmCards objectAtIndex:0] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:0] suit] == 3){
                    [[self.texasCards objectAtIndex:0] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_spades.png", [(Card *)[texasHoldEmCards objectAtIndex:0] num]]] forState:UIControlStateNormal];
                        
                    }

                turn++;
                break;
            }
            case 1:
            {
                // Displays the turn
                if ([(Card *)[texasHoldEmCards objectAtIndex:1] suit] == 0){
                    [[self.texasCards objectAtIndex:1] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_clubs.png", [(Card *)[texasHoldEmCards objectAtIndex:1] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:1] suit] == 1){
                    [[self.texasCards objectAtIndex:1] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_diamonds.png", [(Card *)[texasHoldEmCards objectAtIndex:1] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:1] suit] == 2){
                    [[self.texasCards objectAtIndex:1] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_hearts.png", [(Card *)[texasHoldEmCards objectAtIndex:1] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:1] suit] == 3){
                    [[self.texasCards objectAtIndex:1] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_spades.png", [(Card *)[texasHoldEmCards objectAtIndex:1] num]]] forState:UIControlStateNormal];
                    
                }
                
                turn++;
                break;
            }
            case 2:
            {
                // Displays the river
                
                if ([(Card *)[texasHoldEmCards objectAtIndex:2] suit] == 0){
                    [[self.texasCards objectAtIndex:2] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_clubs.png", [(Card *)[texasHoldEmCards objectAtIndex:2] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:2] suit] == 1){
                    [[self.texasCards objectAtIndex:2] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_diamonds.png", [(Card *)[texasHoldEmCards objectAtIndex:2] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:2] suit] == 2){
                    [[self.texasCards objectAtIndex:2] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_hearts.png", [(Card *)[texasHoldEmCards objectAtIndex:2] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[texasHoldEmCards objectAtIndex:2] suit] == 3){
                    [[self.texasCards objectAtIndex:2] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_spades.png", [(Card *)[texasHoldEmCards objectAtIndex:2] num]]] forState:UIControlStateNormal];
                }
                
                
                turn++;
                break;
            }
            case 3: {
                // Reveal dealer's hand
                int k = 1;
                for (Card *d in dealer) {

                    if (d.suit == 0){
                        [[self.dealerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_clubs.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 1){
                        [[self.dealerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_diamonds.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 2){
                        [[self.dealerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_hearts.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    if (d.suit == 3){
                        [[self.dealerHand objectAtIndex:k] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_spades.png", d.num]] forState:UIControlStateNormal];
                        
                    }
                    
                    k+=2;
                }
                
                // Adds first card to player and dealer array for late evaluation
                [player addObjectsFromArray:texasHoldEmCards];
                [dealer addObjectsFromArray:texasHoldEmCards];
                
                // Evaluate player's hand
                playerEval = [[Hand alloc] initWithHand: player];
                dealerEval = [[Hand alloc] initWithHand: dealer];
                
                NSLog(@"Player: %i", [playerEval handValue]);
                NSLog(@"Dealer: %i", [dealerEval handValue]);
                
                // If win you get pot
                if ([playerEval handValue] > [dealerEval handValue]) {
                    self.outcome.text = @"You Win";
                    self.playerAmount.text = [NSString stringWithFormat:@"%i",[self.playerAmount.text intValue] + [self.potAmount.text intValue]];
                    self.potAmount.text = @"0";
                }
                // If lose you get nothing
                else if ([playerEval handValue] < [dealerEval handValue]){
                    self.outcome.text = @"You Lose";
                    self.potAmount.text = @"0";
                }
                // If tie you get half the pot
                else {
                    self.outcome.text = @"You Tie";
                    self.playerAmount.text = [NSString stringWithFormat:@"%i",[self.playerAmount.text intValue] + ([self.potAmount.text intValue] / 2)];
                    self.potAmount.text = @"0";
                }
                
                [dealer removeAllObjects];
                [player removeAllObjects];
                [texasHoldEmCards removeAllObjects];
                turn = 0;
                break;
            }
            default:
                NSLog(@"Error...");
                break;
        }
    }
    
    
    // Updates deck count
    self.deckCount.text = [NSString stringWithFormat:@"%i", [deck count]];
}

- (IBAction)determineFoldorDraw:(id)sender {
    if(lastGame != delegate.pokerType){
        self.warnings.text = @"Press Reset";
        return;
    }
    
    // Performs Draw feature
    if (delegate.pokerType == NO) {
        // Updates deck count
        self.deckCount.text = [NSString stringWithFormat:@"%i", [deck count]];
        
        // Redraws
        for (UIButton *p in self.playerHand) {
            
            // If the card is selected it will be removed
            if ([p isSelected]) {
                
                [p setSelected:NO];
                [p setHighlighted:NO];
                
                [player removeObjectAtIndex:p.tag];
                
                // Draws new card from deck and adds it
                [player insertObject:[deck deal] atIndex:p.tag];
                
                // Replaces image
                if ([(Card *)[player objectAtIndex:p.tag] suit] == 0){
                    [p setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_clubs.png", [(Card *)[player objectAtIndex:p.tag] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[player objectAtIndex:p.tag] suit] == 1){
                    [p setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_diamonds.png", [(Card *)[player objectAtIndex:p.tag] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[player objectAtIndex:p.tag] suit] == 2){
                    [p setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_hearts.png", [(Card *)[player objectAtIndex:p.tag] num]]] forState:UIControlStateNormal];
                    
                }
                if ([(Card *)[player objectAtIndex:p.tag] suit] == 3){
                    [p setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_spades.png", [(Card *)[player objectAtIndex:p.tag] num]]] forState:UIControlStateNormal];
                    
                }
            }
        }
        
        // Reveal Dealer's card
        int c = 0;
        for (Card *d in dealer) {
            if (d.suit == 0){
                [[self.dealerHand objectAtIndex:c] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_clubs.png", d.num]] forState:UIControlStateNormal];
                
            }
            if (d.suit == 1){
                [[self.dealerHand objectAtIndex:c] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_diamonds.png", d.num]] forState:UIControlStateNormal];
                
            }
            if (d.suit == 2){
                [[self.dealerHand objectAtIndex:c] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_hearts.png", d.num]] forState:UIControlStateNormal];
                
            }
            if (d.suit == 3){
                [[self.dealerHand objectAtIndex:c] setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%i_of_spades.png", d.num]] forState:UIControlStateNormal];
                
            }
            
            c++;
        }
        
        // Evaluate the player and dealer's hand
        playerEval = [[Hand alloc] initWithHand: player];
        dealerEval = [[Hand alloc] initWithHand: dealer];
        
        NSLog(@"Player: %i", [playerEval handValue]);
        NSLog(@"Dealer: %i", [dealerEval handValue]);
        
        // If win you get pot
        if ([playerEval handValue] > [dealerEval handValue]) {
            self.outcome.text = @"You Win";
            self.playerAmount.text = [NSString stringWithFormat:@"%i",[self.playerAmount.text intValue] + [self.potAmount.text intValue]];
            self.potAmount.text = @"0";
        }
        // If lose you get nothing
        else if ([playerEval handValue] < [dealerEval handValue]){
            self.outcome.text = @"You Lose";
            self.potAmount.text = @"0";
        }
        // If tie you get half the pot
        else {
            self.outcome.text = @"You Tie";
            self.playerAmount.text = [NSString stringWithFormat:@"%i",[self.playerAmount.text intValue] + ([self.potAmount.text intValue] / 2)];
            self.potAmount.text = @"0";
        }
        
        // Disable draw after use
        self.foldOrDraw.enabled = NO;
    }
    else {
        [self reset];
        self.outcome.text = @"You lose";
    }
    
    if (!self.betButton.enabled) {
        self.betButton.enabled = YES;
    }
    
    [dealer removeAllObjects];
    [player removeAllObjects];
    turn = 0;
    
    
    // Updates deck count
    self.deckCount.text = [NSString stringWithFormat:@"%i", [deck count]];
}

// Resets the game by reloading inital values or changed values from first view controller
- (IBAction)resetGame:(id)sender {
    // Clears the board
    for(UIButton *card in self.dealerHand){
        [card setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    for(UIButton *card in self.playerHand){
        [card setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    for(UIButton *card in self.texasCards){
        [card setBackgroundImage:nil forState:UIControlStateNormal];
    }
    
    if([self.foldOrDraw isEnabled]){
        self.foldOrDraw.enabled = NO;
    }
    
    self.outcome.text = @"";
    self.warnings.text = @"";
    lastGame = delegate.pokerType;
    
    // Resets pot
    self.potAmount.text = @"0";

    [self reset];
    turn = 0;
    self.playerLabel.text = [NSString stringWithFormat:@"%@: $",delegate.player];
    self.playerAmount.text = [NSString stringWithFormat:@"%i",delegate.schmeckles];
}

- (IBAction)changeState:(id)sender {
    if ([sender tag] == 0 || [sender tag] == 1 || [sender tag] == 2 || [sender tag] == 3 || [sender tag] == 4) {
        if (![sender isSelected]) {
            [sender setSelected:YES];
            [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];
        }
        else {
            [sender setSelected:NO];
            [sender setHighlighted:NO];
        }
    }
}

- (IBAction)changeAce:(id)sender {
    // Switch is yes ace is high
    if([self.aceValue isOn]){
        // Sets new high and low
        high = 14; low = 2;
        
        // Search existing deck and change
        [deck changeAceHigh];
        
        // Search dealer and player hand for ace
        for(Card *p in player){
            if([p num] == 1){
                p.num = 14;
            }
        }
        
        for(Card *d in dealer){
            if([d num] == 1){
                d.num = 14;
            }
        }
    }
    // Switch is no ace is low
    else {
        // Sets new high and low
        high = 13; low = 1;
        
        // Search existing deck and change
        [deck changeAceLow];
        
        // Search dealer and player hand for ace
        for(Card *p in player){
            if([p num] == 14){
                p.num = 1;
            }
        }
        
        for(Card *d in dealer){
            if([d num] == 14){
                d.num = 1;
            }
        }
    }
}
- (void)highlightButton:(UIButton *)b {
    [b setHighlighted:YES];
}

- (void) reset{

    if(![self.betButton isEnabled]){
        self.betButton.enabled = YES;
    }
    
    // For 5 card draw initalize
    if (delegate.pokerType == NO) {
        
        self.foldOrDraw.title = @"DRAW";
        
        if([self.foldOrDraw isEnabled] && turn > 0){
            self.foldOrDraw.enabled = NO;
        }
        
        for(UIButton *card in self.dealerHand){
            UIImage *colorimage = [UIImage imageNamed:@"back.png"];
            [card setBackgroundImage:colorimage forState:UIControlStateNormal];
        }
        
        for(UIButton *card in self.playerHand){
            UIImage *colorimage = [UIImage imageNamed:@"back.png"];
            [card setBackgroundImage:colorimage forState:UIControlStateNormal];
        }
    }
    // For texas holdem initalize
    else {
        
        self.foldOrDraw.title = @"FOLD";
        
        if(![self.foldOrDraw isEnabled] && turn > 0){
            self.foldOrDraw.enabled = YES;
        }
        
        for(UIButton *card in self.texasCards){
            UIImage *colorimage = [UIImage imageNamed:@"back.png"];
            [card setBackgroundImage:colorimage forState:UIControlStateNormal];
        }
        
        for(UIButton *card in self.dealerHand){
            if (card.tag == 1 || card.tag == 3){
                UIImage *colorimage = [UIImage imageNamed:@"back.png"];
                [card setBackgroundImage:colorimage forState:UIControlStateNormal];
            }
        }
        
        for(UIButton *card in self.playerHand){
            if (card.tag == 1 || card.tag == 3){
                UIImage *colorimage = [UIImage imageNamed:@"back.png"];
                [card setBackgroundImage:colorimage forState:UIControlStateNormal];
            }
        }
    }
    
    [player removeAllObjects];
    [dealer removeAllObjects];
    [texasHoldEmCards removeAllObjects];
}

@end
