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

#define SERVICE_KEY @"POINTCM"
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
                if( s != nil ){
                    [LKKeychain updatePassword:s account:[propertiesNames objectAtIndex:i] service:SERVICE_KEY];
                }else if([LKKeychain getPasswordWithAccount:[propertiesNames objectAtIndex:i] service:SERVICE_KEY] != nil){
                    [LKKeychain deletePasswordWithAccount:[propertiesNames objectAtIndex:i]  service:SERVICE_KEY];
                }
            };
            
            NSString *capitalString = [self capitalString:[propertiesNames objectAtIndex:i]];
            NSString *setSelString = [NSString stringWithFormat:@"set%@:",capitalString];
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
    free(properties);
    return propertieNames;
}

-(NSArray *)getAllKey
{
    NSArray* accounts = [LKKeychain getItemsWithService:SERVICE_KEY];
    return accounts;
}

-(void)deleteAllKey{
    //=======================================================================//
    // プロパティをNSStringの配列で取得
    //=======================================================================//
    NSMutableArray *propertiesNames = [self getProperties:[self class]];
    
    //=======================================================================//
    // delete
    //=======================================================================//
    for(int i=0; i<propertiesNames.count; i++){
        [LKKeychain deletePasswordWithAccount:[propertiesNames objectAtIndex:i] service:SERVICE_KEY];
    }
}

-(NSString *)capitalString:(NSString *)str{
    NSString *initial = [[str substringToIndex:1] capitalizedString];
    NSString *result = [NSString stringWithFormat:@"%@%@", initial, [str substringFromIndex:1]];
    
//    NSLog(@"initial:%@", initial);
//    NSLog(@"result:%@", result);
    
    return result;
}

@end
