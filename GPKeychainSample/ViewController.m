//
//  ViewController.m
//  GPKeychainSample
//
//  Created by shingo.nakanishi on 12/12/17.
//  Copyright (c) 2012年 shingo.nakanishi. All rights reserved.
//

#import "ViewController.h"
#import "IdKeychain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    [[IdKeychain sharedManager] setBar:@"BBB"];
    [[IdKeychain sharedManager] setPiyo:@"PPP"];
    [[IdKeychain sharedManager] setD:@"DDD"];
    [[IdKeychain sharedManager] setFf:@"FFF"];
    [[IdKeychain sharedManager] setFFFFF:@"FFFFFFF"];
    
    NSLog(@"bar:%@", [IdKeychain sharedManager].bar);
    NSLog(@"piyo:%@", [IdKeychain sharedManager].piyo);
    NSLog(@"d:%@", [IdKeychain sharedManager].d);
    NSLog(@"ff:%@", [IdKeychain sharedManager].ff);
    
    [[IdKeychain sharedManager] deleteAllKey];
    
    NSLog(@"bar:%@", [IdKeychain sharedManager].bar);
    NSLog(@"piyo:%@", [IdKeychain sharedManager].piyo);
    NSLog(@"d:%@", [IdKeychain sharedManager].d);
    NSLog(@"ff:%@", [IdKeychain sharedManager].ff);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
