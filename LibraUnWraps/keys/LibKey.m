//
//  LibKey.m
//  LibraUnWraps
//
//  Created by simp on 2019/10/2.
//  Copyright © 2019年 simp. All rights reserved.
//

#import "LibKey.h"
#import "libHeader.h"

@implementation LibKey

- (instancetype)initWithData:(NSData *)keyData index:(uint64)index {
    if (self = [super init]) {
        self.keyData = keyData;
        self.index = index;
    }
    return self;
}

- (NSData *)getPub {
    uint8 *pData = [self.keyData bytes];
    uint64 len = 0;
    uint8 * pub = pubkey_from_private(pData, self.keyData.length, &len);
    NSData *data = [[NSData alloc] initWithBytesNoCopy:pub length:len];
    return data;
}

@end
