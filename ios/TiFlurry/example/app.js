// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.


// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var label = Ti.UI.createLabel();
win.add(label);
win.open();

// TODO: write your module tests here
var tiflurry = require('com.sofisoftwarellc.tiflurry');
Ti.API.info("module is => " + tiflurry);

tiflurry.setContinueSessionMillis(1000);

tiflurry.startSession("your flurry API key");

// The following 4 do nothing on Android
tiflurry.logUncaughtExceptions();
tiflurry.setSessionReportsOnCloseEnabled(true);
tiflurry.setSessionReportsOnPauseEnabled(true);
tiflurry.setSecureTransportEnabled(true);

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
