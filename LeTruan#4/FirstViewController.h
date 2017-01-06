//
//  FirstViewController.h
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AppDelegate.h"

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *schmeckles;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;
@property (weak, nonatomic) IBOutlet UISwitch *switchGame;
@property (weak, nonatomic) IBOutlet UILabel *texas;
@property (weak, nonatomic) IBOutlet UILabel *fiveCard;
@property (weak, nonatomic) IBOutlet UILabel *warnings;

- (IBAction)changeGame:(id)sender;
- (IBAction)changeSchmeck:(UIStepper *)sender;
- (IBAction)updateStepper:(id)sender;
- (IBAction)changeName:(id)sender;
@end

