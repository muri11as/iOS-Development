//
//  Player.m
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Player.h"

@implementation Player
-(id) init
{
    self = [super init];
    if(self)
    {
        _money = 100.00;
        _score = 0;
    }
    return self;
}
-(void)bet:(int)amount
{
    if(amount < self.minBet)
        NSLog(@"NOT A VALID BET AMOUNT. DOES NOT MEET MINIMUM");
    
    if (amount <= self.money)
        self.money -= amount;
    
    else
        NSLog(@"NOT A VALID BET AMOUNT.");
}
-(void)printName
{
    if (self.name != nil)
        NSLog(@"MY NAME IS: %@ \n",self.name);
}
@end
