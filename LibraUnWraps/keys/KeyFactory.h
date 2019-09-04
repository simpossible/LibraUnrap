//
//  KeyFactory.h
//  LibraUnWraps
//
//  Created by simp on 2019/8/14.
//  Copyright © 2019 simp. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static char libraSaltPrefix[] = "LIBRA WALLET: mnemonic salt prefix$";
static char libraMasterSalt[] = "LIBRA WALLET: master key salt$";
static char libraInfoProfix[] = "LIBRA WALLET: derived key$";


@interface KeyFactory : NSObject

- (void)gen;

@end

NS_ASSUME_NONNULL_END
