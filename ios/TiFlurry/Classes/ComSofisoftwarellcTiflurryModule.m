/**
 * Flurry is Copyright(c) 2012 by Flurry, Inc.
 *
 * Usage of this module is subject to the Terms of Service agreement of Flurry, Inc.
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 *
 * This module is Copyright (c) 2012 Sofi Software LLC
 * and licensed under the Apache Public License (version 2)
 * http://www.apache.org/licenses/LICENSE-2.0.html
 */

#import "ComSofisoftwarellcTiflurryModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "FlurryAnalytics.h"

@implementation ComSofisoftwarellcTiflurryModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"61d50af2-1676-4a5c-bab8-2f9b8f476469";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.sofisoftwarellc.tiflurry";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
}

#pragma Public APIs

- (void) startSession:(id) args
{
	ENSURE_SINGLE_ARG(args, NSString);
    
	NSLog(@"[INFO] %@ startSession",self);

    NSString *appId = [TiUtils stringValue:args];
    
    [FlurryAnalytics startSession:appId];
}

void uncaughtExceptionHandler(NSException *exception) 
{
    [FlurryAnalytics logError:@"Uncaught Exception" message:@"Uncaught Objective-C exception" exception:exception];
}

- (void)logUncaughtExceptions:(id)args
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}

- (void)setSessionReportsOnCloseEnabled:(id)args
{
	ENSURE_SINGLE_ARG(args, NSNumber);

	BOOL setting = [TiUtils boolValue:args];
    
	[FlurryAnalytics setSessionReportsOnCloseEnabled:setting];
}

- (void)setSessionReportsOnPauseEnabled:(id)args
{
	ENSURE_SINGLE_ARG(args, NSNumber);

	BOOL setting = [TiUtils boolValue:args];

	[FlurryAnalytics setSessionReportsOnPauseEnabled:setting];
}

- (void)setSecureTransportEnabled:(id)args
{
	ENSURE_SINGLE_ARG(args, NSNumber);
    
	BOOL setting = [TiUtils boolValue:args];

	[FlurryAnalytics setSecureTransportEnabled:setting];
}

/*
 * You can call this in several ways from Ti:
    flurry.logEvent('myEvent');
    flurry.logEvent('myEvent', {key: 'value'});
    flurry.logEvent('myEvent', {key: 'value'}, true); // for timed event

 */
- (void)logEvent:(id)args
{
	NSString * eventId = [TiUtils stringValue:[args objectAtIndex:0]];
	NSDictionary * parameters = nil;
    NSNumber * timed = nil;

    if ([args count] <= 1) {
        ENSURE_SINGLE_ARG(args, NSString);
    } else if ([args count] > 1) {
        parameters = [args objectAtIndex:1];
    } else if ([args count] > 2) {
        timed = [args objectAtIndex:2];
    }
	
    if (parameters == nil) {
		[FlurryAnalytics logEvent:eventId];
	} else if (timed == nil) {
		[FlurryAnalytics logEvent:eventId withParameters:parameters];
	} else {
		[FlurryAnalytics logEvent:eventId withParameters:parameters timed:[timed boolValue]];
    }
}

-(void)endTimedEvent:(id)args
{
	NSString * eventId = [TiUtils stringValue:[args objectAtIndex:0]];
	NSDictionary * parameters = nil;
	if ([args count] > 1)
	{
		parameters = [args objectAtIndex:1];
	}
    
	[FlurryAnalytics endTimedEvent:eventId withParameters:parameters];
}

- (void)logPageView:(id)args
{
	[FlurryAnalytics logPageView];
}

- (void)logError:(id)args
{
    if ([args count] >= 2) {
		NSString * errorId = [TiUtils stringValue:[args objectAtIndex:0] ];
        NSString * message = [TiUtils stringValue:[args objectAtIndex:1] ];
        NSException * exception = [NSException exceptionWithName:@"Titanium Exception" reason:@"Exception thrown" userInfo:nil];
        [FlurryAnalytics logError:errorId message:message exception:exception];
	}
}

-(void)setUserID:(id)args
{
	ENSURE_SINGLE_ARG(args, NSString);

	[FlurryAnalytics setUserID:args];
}

-(void)setAge:(id)args
{
	NSInteger age = [TiUtils intValue:args];
	[FlurryAnalytics setAge:age];
}

-(void)setGender:(id)args
{
	ENSURE_SINGLE_ARG(args, NSObject);
    NSObject * arg = [args objectAtIndex:0];
    NSString * gender = nil;
    
    if ([arg isKindOfClass:[NSNumber class]]) {
        int genderInt = [TiUtils intValue:arg];
        if (genderInt == 0)
            gender = @"f";
        else 
            gender = @"m";
    } else if ([arg isKindOfClass:[NSString class]]) {
        NSString * genderStr = [TiUtils stringValue:arg];
        
        if ([genderStr isEqualToString:@"m"] || [genderStr isEqualToString:@"f"]) {
            gender = genderStr;
        }
    }
    
    if (gender != nil)
        [FlurryAnalytics setGender:gender];
}

-(void)setLatitude:(id)args
{   
    if ([args count] >= 4)
	{
		CGFloat lat = [TiUtils floatValue:[args objectAtIndex:0] ];
   		CGFloat lon = [TiUtils floatValue:[args objectAtIndex:1] ];
   		CGFloat h = [TiUtils floatValue:[args objectAtIndex:2] ];
   		CGFloat v = [TiUtils floatValue:[args objectAtIndex:3] ];

        [FlurryAnalytics setLatitude:lat longitude:lon horizontalAccuracy:h verticalAccuracy:v];
	}
}

@end
