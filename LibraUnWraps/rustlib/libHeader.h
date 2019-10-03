//
//  libHeader.h
//  rustApp
//
//  Created by simp on 2019/9/24.
//  Copyright © 2019年 simp. All rights reserved.
//

#ifndef libHeader_h
#define libHeader_h

struct RustBuffer {
    uint8 * data;
    uint32 len;
};

//pub extern fn seed_from_m_s<'a>(length_ptr:&'a mut u32, mnemonic_ptr:*const c_char,salt_ptr:*const c_char) ->   Box<RustBuffer>

char *say_hello(void);

uint8 * seed_from_m_s(char *mnemonic,char *salt,uint32 *length);

void free_rust_buf(struct RustBuffer buf);

uint8 *rust_hkdf(uint8 *first,uint32 firstLen,uint8 * second,uint32 secondLen,uint32 *length);

uint8 * rust_hkdf_privateKey(uint8 *masterData,uint32 masterLen, uint64 index,uint32 * resultLen);
//pub extern fn rust_hkdf_privateKey(masterData_ptr:* const u8,masterLen:usize,index:u64) -> *mut u8

//pub extern fn pubkey_from_private(privateData_ptr:*const u8,privateLen:usize,resultLen_ptr:&mut u8) -> *mut u8

uint8 * pubkey_from_private(uint8 *privateData,uint32 privateLen,uint8 *resultLen);

uint8 * getAccountAddr(uint8 *pubData,uint32 pubLen,uint32 *resultLen);

//pub extern fn getAccountAddr(pubData_ptr:*const u8,pubLen:usize,resultLen_ptr:&mut u8)-> * mut u8

#endif /* libHeader_h */
