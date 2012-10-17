# tiflurry Module

## Description

This is a Titanium iOS module for Flurry Analytics. There is a corresponding module for Android.

Version 1.0 of TiFlurry integrates:
- Flurry Android SDK version 3.0.4
- Flurry iOS SDK version 4.0.6

## Accessing the tiflurry Module

To access this module from JavaScript, you would do the following:

	var tiflurry = require("com.sofisoftwarellc.tiflurry");

The tiflurry variable is a reference to the Module object.	

## Reference

The API is essentially the same as the Flurry API, except in JS format.
However, the Android module implements a few extra methods to make the API
uniform across iOS and Android.

## Usage

	var tiflurry = require('com.sofisoftwarellc.tiflurry');
	Ti.API.info("module is => " + tiflurry);

	tiflurry.setContinueSessionMillis(1000);

	tiflurry.startSession("start session");

	tiflurry.logEvent("myEvent");
    tiflurry.logEvent('myEvent', {key: 'value'});
    tiflurry.logEvent('myEvent', {key: 'value'}, true); // for timed event
	tiflurry.endTimedEvent('myEvent');
	
	tiflurry.logPageView();

	tiflurry.logError("error id", "message");

	tiflurry.setUserID("123");

	tiflurry.setAge(19);
	tiflurry.setGender("f");
	tiflurry.setGender("m");

	tiflurry.onEndSession();
	tiflurry.setLogEnabled(false);

## Author

Eric Herrmann, eric@sofisoftware.com

## License

Apache 2.0
