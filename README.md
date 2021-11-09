# WatchToys
Eventually, this will be a collection of complications for the Apple Watch. For now, it's just one complication (a step counter).

## Steps Complication
This is a simple complication that retrieves the number of steps the user has taken today from HealthKit and displays the count in a complication.
You must authorize this app to access your HealthKit data (only your step count!), and you can do that with a convenient button in the application on the watch itself. To see real step data, you must install and run this app on a real Apple Watch.

### To Run
Before you start, note that, when run in the Apple Watch simulators in Xcode, you will never see real or useful data in this complication (there is no mocked step data in the simulator).
1. Download and install Xcode.
2. Open this project and run it in the simulator using the Play button at the top of the application.
3. When the simulator appears, wait for the main app view to load. It should prompt you to authorize access to HealthKit data.
4. Tap the Authorize button and wait for the HealthKit authorization sheet to show up.
5. Tap the Review button and wait for the second authorization sheet to load.
6. Toggle the Steps datum and scroll down, then tap the Done button.
7. Use the digital crown button (top right button on the side of the simulator) to return to the watch face home screen (it looks like a watch face).
8. Long-click on the watch face to bring up the watch face designer (this will look like the watch face moving away from you).
9. Tap and drag the screen from right to left to move to the New screen.
10. Tap the New button to add a new watch face.
11. Scroll down to the Solar Dial face and click Add.
12. Tap and drag the screen from right to left to scroll over to the complication editing mode. The four corners around the watch face should have bubbles you can tap on to edit the complication that lives there.
13. Tap on any complication.
14. Scroll down to the WatchToys complications and tap the Steps complication.
15. You will be returned to the complication editing mode, but now the complication you edited should have the Steps complication's preview text in it (1524 STEPS).
16. Use the digital crown button (top right button on the side of the simulator) twice to accept your changes and then to return to the watch face home screen.
17. Now, the Steps complication should be working for you in the new watch face you made.
