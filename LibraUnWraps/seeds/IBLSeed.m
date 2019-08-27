//
//  Seed.m
//  LibraUnWraps
//
//  Created by simp on 2019/8/15.
//  Copyright © 2019 simp. All rights reserved.
//

#import "IBLSeed.h"
#import "Mnemonic.h"
#import "KeyFactory.h"
#import "HKDFKit.h"
#import "PBKDF2Configuration.h"
#import "PBKDF2Result.h"

@interface IBLSeed()

@property (nonatomic, copy) NSString * salt;

@property (nonatomic, strong) Mnemonic * mnemonic;

@end

@implementation IBLSeed

- (instancetype)initWithMnemonic:(Mnemonic *)mnemonic andSalt:(NSString *)salt {
    if (self = [super init]) {
        self.mnemonic = mnemonic;
        self.salt = salt;
        [self extract];
    }
    return self;
}

- (void)extract {
    int size = sizeof(libraMasterSalt);//字符串末尾/o
    
    NSData * saltData = [NSData dataWithBytesNoCopy:libraMasterSalt length:size -1];
    
    NSString *mnemonicWord = [self.mnemonic mnemonicWord];
//    NSData * mnemonicData = [NSData dataWithBytesNoCopy:[mnemonicWord UTF8String] length:mnemonicWord.length];
    
//    NSData *extractData = [HKDFKit extract:mnemonicData salt:saltData];
//    NSData *extractData2 = [HKDFKit extract:mnemonicData salt:saltData];
    
    PBKDF2Configuration *config = [[PBKDF2Configuration alloc] initWithSalt:saltData
                             derivedKeyLength:32
                                       rounds:2048
                         pseudoRandomFunction:PBKDF2PseudoRandomFunctionSHA256];
    PBKDF2Result *result = [[PBKDF2Result alloc] initWithPassword:mnemonicWord configuration:config];
    NSData *masterKey = result.derivedKey;
    
    NSData * infoData = [self infoData];
    
   NSData *primarikey = [HKDFKit expand:masterKey info:infoData outputSize:32 offset:0];;
    
    NSString *str = [[NSString alloc] initWithData:primarikey encoding:0];
    
    NSLog(@"str is %@",str);
    
//    return extractData;
}

- (NSData *)infoData {
    int len = sizeof(libraInfoProfix);
    int realLen = len + 8 -1;
    uint8 *finnalByte = malloc(realLen);
    memset(finnalByte, 0, realLen);
    finnalByte[len-1] = 1;
    uint8 * start = (uint8 *)&libraInfoProfix;
    memcpy(finnalByte, start, len - 1);
    
    return [NSData dataWithBytesNoCopy:finnalByte length:realLen];
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
        printf("%c",*itr);
        itr ++;
    }
    printf("\n");
}

@end
