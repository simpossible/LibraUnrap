//
//  main.m
//  LibraUnWraps
//
//  Created by simp on 2019/8/8.
//  Copyright © 2019 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mnemonic.h"
#import "KeyFactory.h"
#import "IBLSeed.h"

#define LibraSalt @"LIBRA"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Mnemonic *me = [[Mnemonic alloc] init];
        NSString*  mm = [me generated];
        NSLog(@"the Mnemonic is %@",mm);
        
        IBLSeed *sed = [[IBLSeed alloc] initWithMnemonic:me andSalt:LibraSalt];
        [sed extract];
        KeyFactory *keyfact = [[KeyFactory alloc] init];
        [keyfact gen];
    }
    return 0;
}
