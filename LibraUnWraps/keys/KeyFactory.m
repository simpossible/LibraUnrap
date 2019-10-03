//
//  KeyFactory.m
//  LibraUnWraps
//
//  Created by simp on 2019/8/14.
//  Copyright © 2019 simp. All rights reserved.
//

#import "KeyFactory.h"
#import "LibKey.h"
#import "LibraPrivateKey.h"

#import "IBLSeed.h"
#import "libHeader.h"
#import "LibraAccount.h"

#define LibraSalt @"LIBRA"

@interface KeyFactory()

@property (nonatomic, strong) IBLSeed * seed;

@property (nonatomic, strong) NSData * masterData;

@property (nonatomic, strong) LibraPrivateKey * privateKey;

@property (nonatomic, assign) int64_t accountIndex;

@property (nonatomic, strong) NSMutableDictionary * Accounts;

@end

@implementation KeyFactory

- (instancetype)init {
    if (self = [super init]) {
        [self initialSeed];
        [self initialMaster];
    }
    return self;
}

- (void)initialSeed {
    IBLSeed *sed = [[IBLSeed alloc] initWithMnemonic:@"" andSalt:LibraSalt];
    self.seed = sed;
    [sed extract];
}

- (void)initialMaster{
    
    NSData *seedData = [self.seed seedData];
    uint8 *bytes = [seedData bytes];
    
    char salt[] = "LIBRA WALLET: master key salt$";
    uint32 size = sizeof(salt) -1;
    uint32 len = 0;
    uint8 *masterlen = rust_hkdf(salt, size,bytes, [seedData length],  &len);
    NSData *data = [[NSData alloc] initWithBytesNoCopy:masterlen length:len];
    self.masterData = data;
    
   
}

- (LibraAccount *)createAccount {

    LibraAccount *account = [LibraAccount accountFromMaterData:self.masterData andIndex:self.accountIndex];
    self.accountIndex ++;
    return account;
}



- (void)gen {
    int len = sizeof(libraInfoProfix);
    int realLen = len + 8 -1;
    uint8 *finnalByte = malloc(realLen);
    memset(finnalByte, 0, realLen);
    finnalByte[len-1] = 1;
    uint8 * start = (uint8 *)&libraInfoProfix;
    memcpy(finnalByte, start, len - 1);
    
    int saltLen = sizeof(libraMasterSalt);
    NSData * saltData = [NSData dataWithBytesNoCopy:libraMasterSalt length:saltLen -1];
    

//    NSData * hkdf_extract = [HKDFKit extract:<#(NSData *)#> salt:<#(NSData *)#>]
}


- (void)printDes:(UInt8 *)array withLen:(int)len withRow:(int)row {
    UInt8 * itr = array;
    int index = 0;
    printf("\n");
    while (true) {
        if ( index % row == 0) {
            printf("\n");
        }
        index ++;
        if (index > len) {
            break;
        }
        if (*itr >= 0 && *itr <= 9) {
            printf("%u ",*itr);
        }else {
            printf("%u ",*itr);
        }
        itr ++;
    }
    printf("\n");
}


@end
