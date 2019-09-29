//
//  Seed.h
//  LibraUnWraps
//
//  Created by simp on 2019/8/15.
//  Copyright © 2019 simp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Mnemonic;


@interface IBLSeed : NSObject

- (instancetype)initWithMnemonic:(Mnemonic *)mnemonic andSalt:(NSString *)salt;

- (NSData *)extract;

@end

