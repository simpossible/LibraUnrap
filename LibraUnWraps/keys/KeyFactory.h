//
//  KeyFactory.h
//  LibraUnWraps
//
//  Created by simp on 2019/8/14.
//  Copyright © 2019 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibraAccount.h"
#import "LibKey.h"

NS_ASSUME_NONNULL_BEGIN

static char libraSaltPrefix[] = "LIBRA WALLET: mnemonic salt prefix$";
static char libraMasterSalt[] = "LIBRA WALLET: master key salt$";
static char libraInfoProfix[] = "LIBRA WALLET: derived key$";


@interface KeyFactory : NSObject

- (LibraAccount *)createAccount;


@end

NS_ASSUME_NONNULL_END
