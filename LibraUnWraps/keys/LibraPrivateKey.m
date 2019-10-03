//
//  LibraPrivateKey.m
//  LibraUnWraps
//
//  Created by simp on 2019/10/3.
//  Copyright © 2019年 simp. All rights reserved.
//

#import "LibraPrivateKey.h"
#import "libHeader.h"

@implementation LibraPrivateKey
- (LibKey *)getPub {
    uint8 *pData = [self.keyData bytes];
    uint64 len = 0;
    uint32 length = [self.keyData length];
    uint8 * pubAddr = pubkey_from_private(pData, length, &len);
    
    NSData *data = [[NSData alloc] initWithBytesNoCopy:pubAddr length:len];
    return [[LibKey alloc] initWithData:data];
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
