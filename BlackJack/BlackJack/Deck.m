//
//  Deck.m
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Deck.h"

@implementation Deck

-(id)init
{
    self = [super init];
    if (self)
    {
        _suits = [[NSMutableArray alloc] init];
        _faces = [[NSMutableArray alloc] init];
        _deckie = [[NSMutableArray alloc] init];
        _suits[0] = @"♠";
        _suits[1]  = @"♣";
        _suits[2]  = @"♦";
        _suits[3]  = @"♥";
        _faces[0] = @"K";
        _faces[1] = @"Q";
        _faces[2] = @"J";
        _faces[3] = @"A";
    }
    return self;
}
-(void)makeDeck
{
    //Loop over the 4 suits, and 4 face cards to fill deck
    for(int i = 0; i < 4; i++)
    {
        //Looping over face cards
        for(int j = 0; j < 4; j++)
        {
            Card *cardy = [[Card alloc]initCard:[self.suits objectAtIndex:i] faceOfCard:[self.faces objectAtIndex:j]];
            [self.deckie addObject:cardy];
            self.totalCards +=1;
            //[cardy display];
        }
        //Filling in non-face cards for each suit
        for(int k = 2; k < 11; k++)
        {
            Card *cardy = [[Card alloc]initWithVal:[self.suits objectAtIndex:i] valueOfCard: k];
            [self.deckie addObject:cardy];
            //[cardy display];
            self.totalCards += 1;
        }
    }
  //  NSLog(@"Total cards in deck: %i \n",self.totalCards);
}
-(Card*)showCard:(int) idx
{
    NSLog(@"SIZE: %lu\n",(unsigned long)[self.deckie count]);
     return[self.deckie objectAtIndex:idx];
}

@end
