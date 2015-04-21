//
//  AppDelegate.m
//  GifView_OC
//
//  Created by SkyNullCode on 4/19/15.
//  Copyright (c) 2015 SkyNullCode. All rights reserved.
//

#import "AppDelegate.h"
#import "GifView.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self.gifView setWantsLayer:YES];
    [self.gifView setImageURL:@"http://www.12306.cn/mormhweb/images/new02.gif"];
    
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
