//
//  KeyFactory.m
//  LibraUnWraps
//
//  Created by simp on 2019/8/14.
//  Copyright © 2019 simp. All rights reserved.
//

#import "KeyFactory.h"



@implementation KeyFactory

- (void)gen {
    int len = sizeof(libraInfoProfix);
    uint8 *finnalByte = malloc(len + 8 -1);
    memset(finnalByte, 0, len + 8 - 1);
    [self printDes:finnalByte withLen:len +8 -1 withRow:8];
    
    uint8 * start = (uint8 *)&libraInfoProfix;
    memcpy(finnalByte, start, len +8 -1);
    [self printDes:finnalByte withLen:len +8 -1 withRow:len +8 -1];
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
