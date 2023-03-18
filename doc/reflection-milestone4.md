# Reflection

In terms of interactivity, we improve our [continent and country selection](https://github.com/UBC-MDS/Student_Living_Guide/issues/62). For example, when the client selects different continents, the country selection will also change dynamically. In addition, we used `pickerInput` instead of `selectInput` and a separate checkbox (for selecting all continents), providing two extra buttons to select all or deselect all continents. This interactivity and UI enhancement provides the client a simpler and more efficient data filtering.

Other than the continent and country selection, we also incorporate the [reactive component in our bar plot](https://github.com/UBC-MDS/Student_Living_Guide/issues/61), which shows the top N and least N expensive countries depending on the selected continents.

We introduce a [download button](https://github.com/UBC-MDS/Student_Living_Guide/issues/60) for the client to download the filtered data they want, and the data is well formatted such that the client can use it for further analysis immediately.

After improving our front-end design to [separate multiple plots into other tabs](https://github.com/UBC-MDS/Student_Living_Guide/pull/73), it makes it easier to navigate and look for information on our dashboard. 

The map plot is automatically changed based on the selected country, therefore, when the client changes the continent selection, it will also modify the country selection, making it complicated to implement [zoom to continent](https://github.ubc.ca/fdandrea/532-peer-review/issues/15#issuecomment-23035) visualization.

The feedback on our front-end design from [classmates](https://github.ubc.ca/fdandrea/532-peer-review/issues/15#issuecomment-22995) and faculty members is very useful for us to improve our application layout. We implemented the multi-tab design such that the client does not need to scroll up and down to view the dashboard changes, it provides a convenient and cleaner user interface.
