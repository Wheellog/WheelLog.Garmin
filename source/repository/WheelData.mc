using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.Lang;
using Toybox.Communications;
using Toybox.System;

module WheelData {
    var currentSpeed = "0.0",
        batteryPercentage = 0,
        batteryVoltage,
        temperature = 0,
        bluetooth,
        useMph,
        maxDialSpeed = 40,
        rideTime = "00:00:00",
        rideDistance,
        averageSpeed,
        topSpeed,
        power,
        pwm = "00",
        maxPwm = "00",
        alarmType;
        
    var webServerPort;
    var isAppConnected = false;

    function setIsAppConnected(data) {
        var previousState = WheelData.isAppConnected;
        WheelData.isAppConnected = data;

        if (WheelData.isAppConnected == true && previousState == false) {
            WatchUi.popView(WatchUi.SLIDE_DOWN);

            var method = new Lang.Method(DataServer, :updateData_timer);
            WheelData.dataUpdateTimer.start(method, 400, true); // Start a timer routine for constantly getting data from the phone
            WheelData_updateData("details");
        } else if (WheelData.isAppConnected == false) {
            var progressBar = new WatchUi.ProgressBar(WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp), null);
            WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP);
            if (WheelData.dataUpdateTimer == null) {
                WheelData.dataUpdateTimer.stop(); // Shut down timer, bc it will malfunction if no server is up and running
            }
        }
    }

    var dataUpdateTimer = new Timer.Timer();
}
