//
//  AppDelegate.m
//  testGCD
//
//  Created by Georgy on 08/06/2018.
//  Copyright © 2018 YuanDuan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    static NSDate* s_start;
    static NSDate* s_last;
    static dispatch_source_t s_test_timer;
    s_last = s_start       = [NSDate dateWithTimeIntervalSinceNow:0];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    s_test_timer           = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(s_test_timer, DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(s_test_timer, ^(){
        NSDate* current = [NSDate dateWithTimeIntervalSinceNow:0];
        float interval = [current timeIntervalSinceDate:s_last];
        s_last = current;
        if (interval > .5) {
            NSLog(@"out of time %.3f........", interval);
        }
        NSLog(@"%.3f", [current timeIntervalSinceDate:s_start]);
    });
    dispatch_source_set_cancel_handler(s_test_timer, ^{
        NSLog(@"cancel...");
    });
    dispatch_resume(s_test_timer);
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
