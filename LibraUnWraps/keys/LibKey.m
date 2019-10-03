//
//  LibKey.m
//  LibraUnWraps
//
//  Created by simp on 2019/10/2.
//  Copyright © 2019年 simp. All rights reserved.
//

#import "LibKey.h"
#import "libHeader.h"

@interface LibKey()
//@property (nonatomic, strong) NSData * keyData;
@end

@implementation LibKey

- (instancetype)initWithData:(NSData *)keyData {
    if (self = [super init]) {
        self.keyData = [keyData copy];
    }
    return self;
}
- (LibKey *)getPub {
    uint8 *pData = [self.keyData bytes];
    uint64 len = 0;
    uint32 length = [self.keyData length];
    uint8 * pubAddr = pubkey_from_private(pData, length, &len);

    NSData *data = [[NSData alloc] initWithBytesNoCopy:pubAddr length:len];
    return [[LibKey alloc] initWithData:data];
}

-(NSString *)HexString{
    NSData *data = [self keyData];
    Byte *bytes = (Byte *)[data bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1){
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        }
        else{
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
        }
    }
    hexStr = [hexStr uppercaseString];
    return hexStr;
}

@end
