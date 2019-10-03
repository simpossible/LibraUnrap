//
//  KeyFactory.m
//  LibraUnWraps
//
//  Created by simp on 2019/8/14.
//  Copyright © 2019 simp. All rights reserved.
//

#import "KeyFactory.h"
#import "LibKey.h"

#import "IBLSeed.h"
#import "libHeader.h"
#define LibraSalt @"LIBRA"

@interface KeyFactory()

@property (nonatomic, strong) IBLSeed * seed;

@property (nonatomic, strong) NSData * masterData;

@property (nonatomic, strong) LibKey * privateKey;

@end

@implementation KeyFactory

- (instancetype)init {
    if (self = [super init]) {
        [self initialSeed];
        [self initialMaster];
    }
    return self;
}

- (void)initialSeed {
    IBLSeed *sed = [[IBLSeed alloc] initWithMnemonic:@"" andSalt:LibraSalt];
    self.seed = sed;
    [sed extract];
}

- (void)initialMaster{
    
    NSData *seedData = [self.seed seedData];
    uint8 *bytes = [seedData bytes];
    
    char salt[] = "LIBRA WALLET: master key salt$";
    uint32 size = sizeof(salt) -1;
    uint32 len = 0;
    uint8 *masterlen = rust_hkdf(salt, size,bytes, [seedData length],  &len);
    NSData *data = [[NSData alloc] initWithBytesNoCopy:masterlen length:len];
    self.masterData = data;
    
    [self getPrivate];
}

- (void)getPrivate {
    uint8 * masterkey = [self.masterData bytes];
    int64_t index = 0;
    uint32 resultLen = 0;
    uint8 * privateKey =  rust_hkdf_privateKey(masterkey, self.masterData.length, index,&resultLen);
    LibKey *key = [[LibKey alloc] initWithData:[[NSData alloc] initWithBytesNoCopy:privateKey length:resultLen] index:index];
    self.privateKey = key;
 
    NSData *pubdata = [key getPub];
    uint8 *bytes = [pubdata bytes];
    [self printDes:bytes withLen:[pubdata length] withRow:8];
    
    uint8 *b = getAccountAddr(bytes, 32, &resultLen);

    NSData *data = [[NSData alloc] initWithBytesNoCopy:b length:resultLen];

    NSString *hex = [self HexStringWithData:data];
    NSLog(@"the hex is %@",hex);

    
}

-(NSString *)HexStringWithData:(NSData *)data{
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
            printf("%u ",*itr);
        }else {
            printf("%u ",*itr);
        }
        itr ++;
    }
    printf("\n");
}


@end
