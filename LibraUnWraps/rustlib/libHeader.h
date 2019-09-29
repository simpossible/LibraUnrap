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

#endif /* libHeader_h */
