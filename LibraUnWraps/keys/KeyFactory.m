//
//  KeyFactory.m
//  LibraUnWraps
//
//  Created by simp on 2019/8/14.
//  Copyright © 2019 simp. All rights reserved.
//

#import "KeyFactory.h"
#import "HKDFKit.h"
#import "IBLSeed.h"

@implementation KeyFactory

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
            printf("%d ",*itr);
        }else {
            printf("%c ",*itr);
        }
        itr ++;
    }
    printf("\n");
}


@end
