//
//  Card.m
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Card.h"

@implementation Card

-(id)initCard:(NSString *) s faceOfCard:(NSString *)f
{
    self = [super init];
    if(self)
    {
        _suit = s;
        _face = f;
        if ([_face  isEqual: @"King"] || [_face  isEqual: @"Queen"] || [_face  isEqual: @"Jack"] )
            _value = 10;
        
    }
    return self;
}

-(id)initWithVal:(NSString *)s valueOfCard:(int)v
{
    self = [super init];
    if (self)
    {
        _suit = s;
        _value = v;
        
    }
    return self;
    
}

-(void) display
{
    NSLog(@"This is my suit %@ \n",self.suit);
    NSLog(@"This is my face %@ \n",self.face);
    NSLog(@"This is my value %i \n", self.value);
}
@end
