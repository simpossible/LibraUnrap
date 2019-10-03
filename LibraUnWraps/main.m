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



int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Mnemonic *me = [[Mnemonic alloc] init];
//        NSString*  mm = [me generated];
//        NSLog(@"the Mnemonic is %@",mm);
        
//        IBLSeed *sed = [[IBLSeed alloc] initWithMnemonic:@"" andSalt:LibraSalt];
//        [sed extract];
        KeyFactory *keyfact = [[KeyFactory alloc] init];
        LibraAccount *acc = [keyfact createAccount];
        [acc gen];//生成公私钥
        NSLog(@"公钥是:%@,地址h是 %@",[[acc pubKey] HexString],[[acc accountKey] HexString]);
        
    }
    return 0;
}
