using Toybox.WatchUi;
using Toybox.Communications;
using Toybox.Application;

class HomeView extends WatchUi.View {

    private var progressBar, isProgressBarShown;

    private var mDrawables = {};

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.HomeLayout(dc));

        progressBar = new WatchUi.ProgressBar(
            WatchUi.loadResource(Rez.Strings.LoadingScreen_WaitingConnectionWithApp),
            null
        );
        // WatchUi.pushView(progressBar, new WaitingForConnectionViewDelegate(), WatchUi.SLIDE_UP );
        isProgressBarShown = true;
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        mDrawables[:TimeDate] = View.findDrawableById("TimeDate");
        var CurrentTime = System.getClockTime(); 
        mDrawables[:TimeDate].setText(
            CurrentTime.hour.format("%d") +
            ":" +
            CurrentTime.min.format("%02d")
        );
    }

    // Update the view
    function onUpdate(dc) {
        View.findDrawableById("TimeDate").setText(System.getClockTime().hour.format("%d") + ":" + System.getClockTime().min.format("%02d"));

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {

    }	
}