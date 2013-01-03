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
#import "Flurry.h"

@implementation ComSofisoftwarellcTiflurryModule

#pragma mark Internal

// this is generated for your module
// Please note that for the Open Source version of the module, you MUST change this GUID,
// otherwise Appcelerator's licensing will prevent use of the module.
// You must also change the matching entry in "manifest".
-(id)moduleGUID
{
	return @"8089a91b-487e-4054-aed5-b9be2670f588";
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
	
//	NSLog(@"[INFO] %@ loaded",self);
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
    
//	NSLog(@"[INFO] %@ startSession",self);

    NSString *appId = [TiUtils stringValue:args];
    
    [Flurry startSession:appId];
}

void uncaughtExceptionHandler(NSException *exception) 
{
    [Flurry logError:@"Uncaught Exception" message:@"Uncaught Objective-C exception" exception:exception];
}

- (void)logUncaughtExceptions:(id)args
{
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
}

- (void)setSessionReportsOnCloseEnabled:(id)args
{
	ENSURE_SINGLE_ARG(args, NSNumber);

	BOOL setting = [TiUtils boolValue:args];
    
	[Flurry setSessionReportsOnCloseEnabled:setting];
}

- (void)setSessionReportsOnPauseEnabled:(id)args
{
	ENSURE_SINGLE_ARG(args, NSNumber);

	BOOL setting = [TiUtils boolValue:args];

	[Flurry setSessionReportsOnPauseEnabled:setting];
}

- (void)setSecureTransportEnabled:(id)args
{
	ENSURE_SINGLE_ARG(args, NSNumber);
    
	BOOL setting = [TiUtils boolValue:args];
    
	[Flurry setSecureTransportEnabled:setting];
}

- (void)setEventLoggingEnabled:(id)args
{
	ENSURE_SINGLE_ARG(args, NSNumber);
    
	BOOL setting = [TiUtils boolValue:args];
    
	[Flurry setEventLoggingEnabled:setting];
}

- (void)setLogEnabled:(id)args
{
    [self setEventLoggingEnabled:args];
}

/*
 * You can call this in several ways from Ti:
    flurry.logEvent('myEvent');
    flurry.logEvent('myEvent', {key: 'value'});
    flurry.logEvent('myEvent', {key: 'value'}, true); // for timed event

 */
- (void)logEvent:(id)args
{
	NSString * eventId = nil;
	NSDictionary * parameters = nil;
    NSNumber * timed = nil;
    
    if ([args isKindOfClass:[NSString class]]) {
        eventId = args;
    } else if ([args isKindOfClass:[NSArray class]] && [args count] > 0) {
        eventId = [TiUtils stringValue:[args objectAtIndex:0]];

        if ([args count] > 2) {
            timed = [args objectAtIndex:2];
        }
        if ([args count] > 1) {
            parameters = [args objectAtIndex:1];
//            NSLog(@"params=%@", [parameters class]);
        }
    }
    
    if (eventId == nil) {
        [self throwException:TiExceptionInvalidType subreason:[NSString stringWithFormat:@"expected: %@, was: nil", [NSString class]] location:CODELOCATION];
        return;
    }
    if (parameters == nil) {
		[Flurry logEvent:eventId];
	} else if (timed == nil) {
		[Flurry logEvent:eventId withParameters:parameters];
	} else {
		[Flurry logEvent:eventId withParameters:parameters timed:[timed boolValue]];
    }
}

-(void)endTimedEvent:(id)args
{
	NSString * eventId;
	NSDictionary * parameters = nil;
    
    if ([args isKindOfClass:[NSString class]]) {
        eventId = args;
    } else if ([args isKindOfClass:[NSArray class]] && [args count] > 1) {
        eventId = [TiUtils stringValue:[args objectAtIndex:0]];
		parameters = [args objectAtIndex:1];
	}
    
	[Flurry endTimedEvent:eventId withParameters:parameters];
}

- (void)logPageView:(id)args
{
	[Flurry logPageView];
}

- (void)logError:(id)args
{
    if ([args isKindOfClass:[NSArray class]] && [args count] >= 2) {
		NSString * errorId = [TiUtils stringValue:[args objectAtIndex:0] ];
        NSString * message = [TiUtils stringValue:[args objectAtIndex:1] ];
        NSException * exception = [NSException exceptionWithName:@"FlurryException"
                                                          reason:@"Error"
                                                        userInfo:nil];
        [Flurry logError:errorId message:message exception:exception];
	}
}

-(void)setUserID:(id)args
{
	ENSURE_SINGLE_ARG(args, NSString);

	[Flurry setUserID:args];
}

-(void)setAge:(id)args
{
	ENSURE_SINGLE_ARG(args, NSNumber);
	NSInteger age = [TiUtils intValue:args];
	[Flurry setAge:age];
}

-(void)setGender:(id)args
{
	ENSURE_SINGLE_ARG(args, NSObject);
    NSString * gender = nil;
    
    if ([args isKindOfClass:[NSNumber class]]) {
        int genderInt = [TiUtils intValue:args];
        if (genderInt == 0)
            gender = @"f";
        else 
            gender = @"m";
    } else if ([args isKindOfClass:[NSString class]]) {
        NSString * genderStr = [TiUtils stringValue:args];
        
        if ([genderStr isEqualToString:@"m"] || [genderStr isEqualToString:@"f"]) {
            gender = genderStr;
        }
    }
    
    if (gender != nil)
        [Flurry setGender:gender];
}

-(void)setLatitude:(id)args
{   
    if ([args isKindOfClass:[NSArray class]] && [args count]==4) {
		CGFloat lat = [TiUtils floatValue:[args objectAtIndex:0] ];
   		CGFloat lon = [TiUtils floatValue:[args objectAtIndex:1] ];
   		CGFloat h = [TiUtils floatValue:[args objectAtIndex:2] ];
   		CGFloat v = [TiUtils floatValue:[args objectAtIndex:3] ];

        [Flurry setLatitude:lat longitude:lon horizontalAccuracy:h verticalAccuracy:v];
	}
}

-(void)onEndSession:(id)args
{
    NSLog(@"onEndSession ignored on ios");
}

@end
