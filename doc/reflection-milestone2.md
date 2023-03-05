# Reflection

## Things that we have implemented

1. Map plot with every single data point representing a country. The point color is adjusted by the continent and country filters.


2. We added a distribution plot visualizing the distribution of the cost of living index of the selected continent or continents. In addition, we also added lines for: first, the cost of living of the selected country; second, the mean cost of living of the selected continent(s).

3. Two bar plots: One showing the 10 most expensive countries and the other one showing the 10 less expensive countries in our dataset based on the cost of living index.

4. Scatter plot that highlights the relation between each of the indices.


## Things that are not implemented yet in our dashboard

1. Since there is limited space in a single webpage, we didn't want the customer to scroll up and down a lot, therefore, the small table output in the lower left corner of the sketch is not implemented yet.


## Things that are not working in our dashboard

1. When the customer filters the data by continent, the map plot will focus on the same selected country view instead of zooming out and showing the appearing/disappearing countries of the filtered continent(s). This feature is not available yet as the leaflet map is an observed element on the whole dashboard and it will refresh each time when there is an update.

2. We wanted to have the two bar plots on the same scale so that user can clearly see from the plots the gap between the most expensive and less expensive countries. However, when they are on the same scale, aesthetically it makes the overall dashboard uneven. Also, we tried to add a break (blank space) between the plots, again for aesthetics reasons but it did not work.

## Limitations and Improvements

There are several limitations we can work on and further improve our dashboard in the future.

1. Currently our map plot only provides visualization on a single index, we can further add other types
of the index and provide more flexibility to the customer.

2. Similarly, the distribution plot only draws the distribution of the cost of living index. Considering our target audience, they might also interest in comparing other indices like rent with respect to NYC.

3. For the distribution plot, we added vertical lines for the mean and the selected country's cost of living. However, we found it hard to dynamically adjust the position of the annotated texts using `ggplot`. 

4. Currently our bar plots showing the 10 most and least expensive countries are static and we could add reactivity  to it. For example when the user points at a country's bar plot, it can show the difference index value with New York City.

5. The third and fourth reactivity (selecting the x and y axis scale) is relevant only to the scatterplot and not relevant to the others. It is misleading to place it along with the country and continent filter. Moving it somewhere closer to the scatter plot would make the dashboard easy to understand.

