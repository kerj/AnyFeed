# AnyFeed

At a glance, see what is most important to you about each of your activities, we all know how important saving
a few seconds can be!

The beginnings of a user customizable Strava feed. See your activities just the way you want to!
Strava API has loads of data points, and many of those are hidden in multiple layers of their UI. 
This App will seek to parity the Strava UI while allowing a user to select what stats show up where.

## Running Locally

1. Clone the repository:

   ```bash
   git clone https://github.com/kerj/AnyFeed.git
   ```
 2.   Open the project in Xcode:
    ```bash
    cd AnyFeed && xed .
    ```
 3. Install Dependencies:

    This project uses Swift Package Manager (SPM) to manage dependencies.

    Xcode will automatically resolve and fetch all packages on first open.
    If not, you can manually resolve them via:

    Product → Resolve Package Versions

    Or from terminal:

    ```xcodebuild -resolvePackageDependencies```


 4.   Before going further, you will need to have your own Strava app details setup:

      ```https://www.strava.com/settings/api```

      A. you need your `Client ID`

      B. you need your `Client Secret`

      C. you need to set your Authorization Callback Domain
      
      To get this app started the simplest way, set your Authorization Callback Domain to "ifinesse" as the app is setup to use that.
      Feel free to tinker and change that to whatever you want, though you will need to update the plist as well
      as the callback uri to match whatever you choose.
   

 5.   Select a simulator device (e.g., iPhone 14) in Xcode.

 6.   Press Run (or press Cmd + R) to build and launch the app on the simulator.

 7. Enter your Client ID and Client Secret and Press Login to follow the prompts from Strava and You should see your activities.   



## 📦 Dependencies

    Polyline – lightweight polyline decoder (SPM)


Feel free to open issues or contribute!


Let me know if you want me to add anything else!
