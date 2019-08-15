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
    uint8 * salt = malloc(size -1);
    memcpy(salt, &libraMasterSalt, size);
    [self printDes:salt withLen:size withRow:size];
    free(salt);
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
