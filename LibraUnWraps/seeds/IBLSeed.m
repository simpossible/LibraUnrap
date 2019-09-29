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
#import "PBKDF2Configuration.h"
#import "PBKDF2Result.h"

#import "libHeader.h";

@interface IBLSeed()

@property (nonatomic, copy) NSString * salt;

@property (nonatomic, strong) Mnemonic * mnemonic;

@property (nonatomic, strong) NSData * seedData;

@end

@implementation IBLSeed

- (instancetype)initWithMnemonic:(Mnemonic *)mnemonic andSalt:(NSString *)salt {
    if (self = [super init]) {
        self.mnemonic = mnemonic;
        self.salt = salt;
//        [self extract];
    }
    return self;
}

- (NSData *)extract {
    char *salt = "libra";
    //固定助记词 方便对照调试
    char * mne = "legal winner thank year wave sausage worth useful legal winner thank year wave sausage worth useful legal will";
    struct RustBuffer *rb =  seed_from_m_s(mne, salt);
    [self printDes:rb->data withLen:rb->len withRow:8];
    NSData *data = [NSData dataWithBytes:rb->data length:rb->len];
    self.seedData = data;
    [self printData:data useC:false];
    return data;
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
        printf("_%u_",*itr);
        itr ++;
    }
    printf("\n");
}

@end
