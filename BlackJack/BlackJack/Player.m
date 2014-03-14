//
//  Player.m
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Player.h"
#import "Card.h"

@implementation Player
@synthesize score, money;
-(id) init
{
    self = [super init];
    if(self)
    {
        money = 100.00;
        score = 0;
        _hand = [[NSMutableArray alloc] init];
    }
    return self;
}
-(void)bet:(int)amount
{
    if(amount < self.minBet)
        NSLog(@"NOT A VALID BET AMOUNT. DOES NOT MEET MINIMUM");
    
    if (amount <= money)
        money -= amount;
    
    else
        NSLog(@"NOT A VALID BET AMOUNT.");
}
-(void)draw: (Card*) c
{
    [_hand addObject:c];
}
-(int)handSize
{
    return [_hand count];
}
-(int)calcScore
{
    score = 0;
    for (int i = 0; i < [_hand count]; i++)
    {
        if ([[_hand[i] displayFace] isEqualToString:@"J"] || [[_hand[i] displayFace] isEqualToString:@"Q"] || [[_hand[i] displayFace] isEqualToString:@"K"])
        {
            score += 10;
        }
        else if ([[_hand[i] displayFace] isEqualToString:@"A"])
        {
            int busty = score + 11;
            if (busty >21)
            {
                score +=1;
            }
            else
            {
                score += 11;
            }
            
        }
        else
        {
            score += [_hand[i] val];
        }
    }

    return score;
}

@end
