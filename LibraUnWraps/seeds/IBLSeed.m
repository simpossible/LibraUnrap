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
    char salt[] = "LIBRA";
    
    int presize = sizeof(libraSaltPrefix);//字符串末尾/o
//    NSData * prefixData = [NSData dataWithBytesNoCopy:libraSaltPrefix length:presize -1];
    
    int saltsize = sizeof(salt);
    int realLength = presize + saltsize - 2;
    uint8 *a = malloc(realLength);
    memset(a, 0, realLength);
    memcpy(a, libraSaltPrefix, presize-1);
    uint8 * temp = a + presize -1;
    memcpy(temp, salt, saltsize-1);
    NSData *saltData = [NSData dataWithBytesNoCopy:a length:realLength];
    

    [self printData:saltData useC:YES];
    
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
    
   NSData * infoData = [self infoDataAtIndex:0];
    
   NSData *primarikey = [HKDFKit expand:masterKey info:infoData outputSize:32 offset:0];
 [self printData:primarikey useC:NO];
    NSString *str = [[NSString alloc] initWithData:primarikey encoding:0];
    
    NSLog(@"str is %@",str);
    
//    return extractData;
}

- (void)printData:(NSData *)data useC:(BOOL)c {
    uint8 *a = data.bytes;
    for (int i = 0; i < data.length; i ++) {
        if (c) {
            printf("[%c] ",*a);
        }else {
            printf("[%u] ",*a);
        }
        
        a++;
    }
    
}

- (NSData *)infoDataAtIndex:(NSInteger)index {
    int len = sizeof(libraInfoProfix);
    int realLen = len + 8 -1;
    uint8 *finnalByte = malloc(realLen);
    memset(finnalByte, 0, realLen);
    finnalByte[len-1] = index;
    uint8 * start = (uint8 *)&libraInfoProfix;
    memcpy(finnalByte, start, len - 1);
    
    [self printDes:finnalByte withLen:realLen withRow:9];
    
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
        printf("_%c_",*itr);
        itr ++;
    }
    printf("\n");
}

@end
