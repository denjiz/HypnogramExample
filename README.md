# HypnogramExample

An example app that displays a sleep hypnogram for the user's last night of sleep.

The data is simulated. It is assumed that the raw data comes from a sleep-tracking device in 30-second intervals.

The chart is implemented using [Swift Charts](https://developer.apple.com/documentation/charts).

The app was made as a programming exercise.

<img src="https://github.com/user-attachments/assets/cbba783e-5cf1-4824-859f-84eec2262e20" width="250">

# Installation

## Requirements
- Xcode 16+

## Installation steps
1. Clone or download the project
2. Open `HypnogramExample.xcodeproj` in Xcode
3. Select the desired simulator in the toolbar at the top
4. Run the app or run unit tests
   - If you're using the default Xcode shortcuts, hit `Cmd+R` to run the app or `Cmd+U` to run unit tests
  
# App Usage

Upon launch, the app displays the simulated hypnogram for the user's last night of sleep.

To test the chart with different data, modify the [example data generation code](https://github.com/denjiz/HypnogramExample/blob/853e25797bb57361aec81cac0ba7c8c98307a9b0/HypnogramExample/DataAccess/HypnogramDataRepository.swift#L46) in `HypnogramDataRepository.swift`.
