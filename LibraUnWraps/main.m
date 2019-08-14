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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Mnemonic *me = [[Mnemonic alloc] init];
        NSString*  mm = [me generated];
        NSLog(@"the Mnemonic is %@",mm);;
        
        KeyFactory *keyfact = [[KeyFactory alloc] init];
        [keyfact gen];
    }
    return 0;
}
