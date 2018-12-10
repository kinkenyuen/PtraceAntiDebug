//
//  main.m
//  PtraceAntiDebug
//
//  Created by Kinken_Yuen on 2018/12/10.
//  Copyright © 2018年 Kinken_Yuen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyPtrace.h"
#import <dlfcn.h>

int main(int argc, char * argv[]) {
    
    /**
     反调试
     */
#ifndef PT_DENY_ATTACH
#define PT_DENY_ATTACH 31
#endif
    typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
    ptrace(PT_DENY_ATTACH, 0, 0, 0);
    
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = (ptrace_ptr_t)dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH,0,0,0);
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
