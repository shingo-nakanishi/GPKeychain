//
//  GPKeychain.h
//  GPKeychainSample
//
//  Created by shingo.nakanishi on 12/12/17.
//  Copyright (c) 2012年 shingo.nakanishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPKeychain : NSObject

+(instancetype)sharedManager;
-(NSArray *)getAllKey;

@end
