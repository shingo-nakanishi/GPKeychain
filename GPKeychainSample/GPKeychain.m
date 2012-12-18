//
//  GPKeychain.m
//  GPKeychainSample
//
//  Created by shingo.nakanishi on 12/12/17.
//  Copyright (c) 2012年 shingo.nakanishi. All rights reserved.
//

#import "GPKeychain.h"
#import <objc/runtime.h>
#import "LKKeychain.h"

@implementation GPKeychain

#define SERVICE_KEY @"YOUR_SERVICE_KEY"
static id gPKeychain = nil;

- (id)init
{
    self = [super init];
    if (self) {
        //=======================================================================//
        // プロパティをNSStringの配列で取得
        //=======================================================================//
        NSMutableArray *propertiesNames = [self getProperties:[self class]];
        
        //=======================================================================//
        // setterとgetterをメタプログラミング
        //=======================================================================//
        for(int i=0; i<propertiesNames.count; i++){
            //-----------------------------------------------------//
            // setter
            //-----------------------------------------------------//
            void (^setBlock)(id o, NSString *s) = ^(id o, NSString *s){
//                NSLog(@">>> %@",s);
                [LKKeychain updatePassword:s account:[propertiesNames objectAtIndex:i] service:SERVICE_KEY];
            };
            NSString *setSelString = [NSString stringWithFormat:@"set%@:", [((NSString *)[propertiesNames objectAtIndex:i]) capitalizedString] ];
            SEL setSel = NSSelectorFromString(setSelString);
            IMP setImp = imp_implementationWithBlock(setBlock);
            class_addMethod([GPKeychain class], setSel, setImp, "v@:@");
            
            //-----------------------------------------------------//
            // getter
            //-----------------------------------------------------//
            NSString *(^getBlock)(id o) = ^(id o){
//                NSLog(@"%@", o);
                return [LKKeychain getPasswordWithAccount:[propertiesNames objectAtIndex:i] service:SERVICE_KEY];
            };
            SEL getSel = NSSelectorFromString([propertiesNames objectAtIndex:i]);
            IMP getImp = imp_implementationWithBlock(getBlock);
            class_addMethod([GPKeychain class], getSel, getImp, "@@:");
        }
    }
    return self;
}

+(instancetype)sharedManager{
    @synchronized(self) {
        if (gPKeychain == nil) {
            gPKeychain = [[self alloc] init];
        }
    }
    return gPKeychain;
}

-(NSMutableArray *)getProperties:(id)c
{
    NSString *propertyName;
    unsigned int outCount, i;
    NSMutableArray *propertieNames = [[NSMutableArray alloc] initWithObjects: nil];
    
    objc_property_t *properties = class_copyPropertyList(c, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        propertyName = [NSString stringWithUTF8String:property_getName(property)];
        [propertieNames addObject:propertyName];
    }
    return propertieNames;
}

-(NSArray *)getAllKey
{
    NSArray* accounts = [LKKeychain getItemsWithService:SERVICE_KEY];
    return accounts;
}

@end
