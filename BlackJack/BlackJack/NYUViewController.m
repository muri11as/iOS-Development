//
//  NYUViewController.m
//  BlackJack
//
//  Created by Cesar Murillas on 2/28/14.
//  Copyright (c) 2014 Cesar Murillas. All rights reserved.
//

#import "NYUViewController.h"
#import "Game.h"
#import "Player.h"
#import "Card.h"
#import "Deck.h"

@interface NYUViewController ()
@property (weak, nonatomic) IBOutlet UILabel *secondCardDealer;
@property (weak, nonatomic) IBOutlet UILabel *firstCardPlayer;
@property (weak, nonatomic) IBOutlet UILabel *secCardPlayer;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *greetingLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstCardDealer;
-(NSString*)displayCard:(Card *)c;

@end

@implementation NYUViewController

-(NSString*)displayCard:(Card*) c
{
    NSMutableString* _first = [[NSMutableString alloc]init];
    
    if ([c.face isEqual: @"King"] || [c.face isEqual: @"Queen"] || [c.face isEqual: @"Jack"] || [c.face isEqual: @"Ace"] )
    {
        NSString* f = [NSString stringWithFormat:@"%@ ",c.face];
        _first = [[NSMutableString alloc]initWithString:f];
    }
    else
    {
        NSString* f = [NSString stringWithFormat:@"%i ",c.value];
        _first = [[NSMutableString alloc]initWithString:f];
        
    }
    NSString* s = [NSString stringWithFormat:@"%@",c.suit];
    [_first appendString:s];
    return _first;
    
}
- (IBAction)acquireName:(id)sender
{
    NSString* nam = self.nameTextField.text;
    NSString *_msg = [NSString stringWithFormat:@"%@:", nam];
    self.nameLabel.text = _msg;
    Game* gamey = [[Game alloc] init:nam];
    Deck* d = [gamey start];
    Player* p = [[Player alloc]init];
    [p setName:nam];
    [p printName];
    [self.nameTextField resignFirstResponder];
    
    Card* c1 = [gamey dealCard:d];
    Card* c2 = [gamey dealCard:d];
    Card* c3 = [gamey dealCard:d];
    Card* c4 = [gamey dealCard:d];
    self.firstCardDealer.text = [self displayCard:c1];
    self.firstCardPlayer.text = [self displayCard:c2];
   
    // self.secondCardDealer.text = [self displayCard:c3];
    self.secCardPlayer.text = [self displayCard:c4];
    
   
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
