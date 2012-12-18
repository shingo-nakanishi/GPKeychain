//
//  IdKeychain.m
//  GPKeychainSample
//
//  Created by shingo.nakanishi on 12/12/18.
//  Copyright (c) 2012年 shingo.nakanishi. All rights reserved.
//

#import "IdKeychain.h"

@implementation IdKeychain

@dynamic bar;
@dynamic piyo;
@dynamic d;

static id gPKeychain = nil;

+(IdKeychain *)sharedManager{
    @synchronized(self) {
        if (gPKeychain == nil) {
            gPKeychain = [[self alloc] init];
        }
    }
    return gPKeychain;
}


@end
