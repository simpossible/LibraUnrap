//
//  LibraAccounts.m
//  LibraUnWraps
//
//  Created by simp on 2019/10/3.
//  Copyright © 2019年 simp. All rights reserved.
//

#import "LibraAccount.h"
#import "LibraPrivateKey.h"
#import "libHeader.h"

@interface LibraAccount()

@property (nonatomic, strong) NSData * masterData;

@property (nonatomic, assign)  int64_t index;

@property (nonatomic, strong) LibraPrivateKey * privateKey;

@property (nonatomic, strong) LibKey * pubKey;

@property (nonatomic, strong) LibKey * accountKey;

@end

@implementation LibraAccount

- (instancetype)initWithAccountFromMaterData:(NSData *)masterData andIndex:(int64_t)index {
    if (self = [super init]) {
        self.masterData = masterData;
        self.index = index;
    }
    return self;
}

- (void)gen {
    uint8 * masterkey = (uint8 *)[self.masterData bytes];
    
    uint32 resultLen = 0;
    uint8 * privateKey =  rust_hkdf_privateKey(masterkey, self.masterData.length, self.index,&resultLen);
    NSData *aData = [[NSData alloc] initWithBytesNoCopy:privateKey length:resultLen];
    self.privateKey = [[LibraPrivateKey alloc] initWithData:aData];

    [self printDes:privateKey withLen:resultLen withRow:8];    
    self.pubKey = [self.privateKey getPub];
    
    uint8 *bytes = (uint8 *) [self.pubKey.keyData bytes];
    uint8 *b = getAccountAddr(bytes, 32, &resultLen);
    
    self.accountKey = [[LibKey alloc] initWithData:[[NSData alloc] initWithBytesNoCopy:b length:resultLen]];;
}

+ (instancetype)accountFromMaterData:(NSData *)masterData andIndex:(int64_t)index {
    return [[self alloc] initWithAccountFromMaterData:masterData andIndex:index];
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
