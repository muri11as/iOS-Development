//
//  Card.m
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize val;
-(id)initCard:(NSString *) s faceOfCard:(NSString *)f
{
    self = [super init];
    if(self)
    {
        _suit = s;
        _face = f;
        if ([_face  isEqual: @"K"] || [_face  isEqual: @"Q"] || [_face  isEqual: @"J"] )
            val = 10;
        if ([_face isEqual:@"A"])
        {
            val = 11;
        }
        
    }
    return self;
}

-(id)initWithVal:(NSString *)s valueOfCard:(int)v
{
    self = [super init];
    if (self)
    {
        _suit = s;
        val = v;
        _face = @"";
        
    }
    return self;
    
}

-(NSString*) displayFace
{
    return _face;
}
@end
