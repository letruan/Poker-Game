//
//  SecondViewController.h
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SecondViewController : UIViewController
// Labels
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerAmount;
@property (weak, nonatomic) IBOutlet UILabel *dealerLabel;
@property (weak, nonatomic) IBOutlet UILabel *dealerAmount;
@property (weak, nonatomic) IBOutlet UILabel *betAmount;
@property (weak, nonatomic) IBOutlet UILabel *potAmount;
@property (weak, nonatomic) IBOutlet UILabel *outcome;
@property (weak, nonatomic) IBOutlet UILabel *warnings;
@property (weak, nonatomic) IBOutlet UILabel *deckCount;
@property (weak, nonatomic) IBOutlet UITabBarItem *PlayButton;

// Buttons
@property (weak, nonatomic) IBOutlet UIBarButtonItem *foldOrDraw;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *betButton;
@property (weak, nonatomic) IBOutlet UISwitch *aceValue;

// Cards
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *playerHand;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dealerHand;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *texasCards;

// Actions
- (IBAction)changeBet:(UIStepper *)sender;
- (IBAction)addToPot:(id)sender;
- (IBAction)determineFoldorDraw:(id)sender;
- (IBAction)resetGame:(id)sender;
- (IBAction)changeState:(id)sender;
- (IBAction)changeAce:(id)sender;

@end

