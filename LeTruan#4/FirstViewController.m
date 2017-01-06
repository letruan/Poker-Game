//
//  FirstViewController.m
//  LeTruan#4
//
//  Created by Le, Truan H. (UMSL-Student) on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
{
    AppDelegate *delegate;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.pokerType = (BOOL *)self.switchGame.isOn;
    delegate.schmeckles = [self.schmeckles.text intValue];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Press anywhere on screen to hide keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// Enters message after return is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
    
    
}

// Switches the game
- (IBAction)changeGame:(id)sender {
    if (self.switchGame.isOn) {
        self.fiveCard.textColor = [UIColor lightGrayColor];
        self.texas.textColor = [UIColor blackColor];
    }
    else {
        self.fiveCard.textColor = [UIColor blackColor];
        self.texas.textColor = [UIColor lightGrayColor];
    }
    
    delegate.pokerType = (BOOL *)self.switchGame.isOn;

}

// Uses Stepper to increment money
- (IBAction)changeSchmeck:(UIStepper *)sender {
    int value = [sender value];
    
    [self.schmeckles setText:[NSString stringWithFormat:@"%i", value]];
    delegate.schmeckles = [self.schmeckles.text intValue];
}

- (IBAction)updateStepper:(id)sender {
    self.stepper.value = [self.schmeckles.text intValue];
    delegate.schmeckles = [self.schmeckles.text intValue];
}

- (IBAction)changeName:(id)sender {
    if([self.name.text isEqual:@""]){
        self.warnings.text = @"Enter a name";
    }
    else {
        delegate.player = self.name.text;
        if([self.warnings.text isEqual:@"Enter a name"]){
            self.warnings.text = @"";
        }
    }
}
@end
