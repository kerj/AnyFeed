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


 4.   Select a simulator device (e.g., iPhone 14) in Xcode.

 5.   Press Run (or press Cmd + R) to build and launch the app on the simulator.



## 📦 Dependencies

    Polyline – lightweight polyline decoder (SPM)


Feel free to open issues or contribute!


Let me know if you want me to add anything else!