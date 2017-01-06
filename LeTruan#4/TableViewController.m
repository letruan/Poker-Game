//
//  TableViewController.m
//  LeTruan#4
//
//  Created by Truan Le on 8/2/16.
//  Copyright © 2016 Le, Truan H. (UMSL-Student). All rights reserved.
//

#import "TableViewController.h"
#import "DTCustomColoredAccessory.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (section>0) return YES;
    
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            // return rows when expanded

            if (section == 1) {
                return 5;
            }
            else if (section == 2) {
                return 6;
            }
            else if (section == 3){
                return 10;
            }
            
        }
        
        return 1; // only top row showing
    }
    
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            
            // Sections
            if (indexPath.section == 1) {
                cell.textLabel.text = @"5 Card Draw";
            }
            else if (indexPath.section == 2) {
                cell.textLabel.text = @"Texas Hold'em";
            }
            else {
                cell.textLabel.text = @"Poker Scoring Hands";
            }
            
            
            if ([expandedSections containsIndex:indexPath.section])
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor blueColor] type:DTCustomColoredAccessoryTypeUp];
            }
            else
            {
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor blueColor] type:DTCustomColoredAccessoryTypeDown];
            }
        }
        else
        {
            // Rows in the sections
            if (indexPath.section == 1) {
                switch (indexPath.row) {
                    case 1:
                        cell.textLabel.text = @"Preliminaries";
                        cell.detailTextLabel.text = @"Deal 5 cards to each player.";
                        break;
                    case 2:
                        cell.textLabel.text = @"First Round of Betting";
                        cell.detailTextLabel.text = @"Make a bet.";
                        break;
                    case 3:
                        cell.textLabel.text = @"The Draw";
                        cell.detailTextLabel.text = @"Discard up to 3 cards and draw until you have 5 again.";
                        break;
                    case 4:
                        cell.textLabel.text = @"The Showdown";
                        cell.detailTextLabel.text = @"Reveal hand and determine who gets pot.";
                        break;
                    default:
                        break;
                }

            }
            else if (indexPath.section == 2) {
                switch (indexPath.row) {
                    case 1:
                        cell.textLabel.text = @"Preliminaries";
                        cell.detailTextLabel.text = @"Deals 2 cards to each player. Display the Flop.";
                        break;
                    case 2:
                        cell.textLabel.text = @"First Round of Betting";
                        cell.detailTextLabel.text = @"Make a bet or fold.";
                        break;
                    case 3:
                        cell.textLabel.text = @"Second Round of Betting";
                        cell.detailTextLabel.text = @"Show the Turn. Make a bet fold.";
                        break;
                    case 4:
                        cell.textLabel.text = @"Third Round of Betting";
                        cell.detailTextLabel.text = @"Show the River. Make a bet or fold.";
                        break;
                    case 5:
                        cell.textLabel.text = @"The Showdown";
                        cell.detailTextLabel.text = @"Reveal hand and determine who gets pot.";
                        break;
                    default:
                        break;
                }
            }
            else if (indexPath.section == 3){
                switch (indexPath.row) {
                    case 1:
                        cell.textLabel.text = @"One Pair";
                        cell.detailTextLabel.text = @"K♠️ K♦️";
                        break;
                    case 2:
                        cell.textLabel.text = @"Two Pair";
                        cell.detailTextLabel.text = @"A♦️ A♥️ 6♠️ 6♣️";

                        break;
                    case 3:
                        cell.textLabel.text = @"Three of a Kind";
                        cell.detailTextLabel.text = @"7♠️ 7♦️ 7♣️";
                        break;
                    case 4:
                        cell.textLabel.text = @"The Straight";
                        cell.detailTextLabel.text = @"4♣️ 5♦️ 6♠️ 7♥️ 8♣️";
                        break;
                    case 5:
                        cell.textLabel.text = @"The Flush";
                        cell.detailTextLabel.text = @"K♥️ 10♥️ 7♥️ 4♥️ 2♥️";
                        break;
                    case 6:
                        cell.textLabel.text = @"The Full House";
                        cell.detailTextLabel.text = @"Q♦️ Q♣️ Q♠️ 5♥️ 5♥️";
                        break;
                    case 7:
                        cell.textLabel.text = @"Four of a Kind";
                        cell.detailTextLabel.text = @"10♠️  10♥️  10♣️  10♦️  6♠️";
                        break;
                    case 8:
                        cell.textLabel.text = @"The Straight Flush";
                        cell.detailTextLabel.text = @"5♠️  6♠️  7♠️  8♠️  9♠️";
                        break;
                    case 9:
                        cell.textLabel.text = @"The Royal Flush";
                        cell.detailTextLabel.text = @"A♥️  K♥️  Q♥️  J♥️  10♥️";
                        break;
                    default:
                        break;
                }
            }
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    else
    {
        cell.accessoryView = nil;
        cell.textLabel.text = @"Poker Rules";
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // only first row toggles exapand/collapse
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                cell.accessoryView = [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
                
            }
        }
    }
}

@end
