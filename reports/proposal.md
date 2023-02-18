# Proposal

## Section 1: Motivation and Purpose

As international students, the main question that we all asked ourselves before moving to Vancouver was: How affordable is Vancouver city? How affordable a country or a city is, is indeed the biggest factor when it comes to choosing the country or city where one wants to pursue their studies. Many students, therefore, browse hundreds of websites to find indicators of the cost of living in the country or the city they plan to go to. However, this process can be exhaustive because the information about the cost of living is spread across different websites and the search results often contradict. How can we be sure that this process of comparing cities/countries based on the cost of living is less exhaustive for students and potentially yields reliable results? This is the question that our application `Student_Living_Guide` aims to address.

### User Persona

Quan is a 22-years old student pursuing an undergraduate degree in Neuroscience at New York University (NYU). After completing his freshman year at NYU, Quan is considering several student exchange programs abroad from his entire Sophomore year. Quan is hesitating between four countries which are: France, South Africa, India, and China. Aware that his one-year budget is limited, Quan decides to use the application `Student_Living_Guide` in order to make a choice that matches his budget. Through the `Student_Living_Guide` application, Quan will be able to interactively select those four countries and compare attributes such as rent/month, and groceries index.

The cost-of-living data on which the application `Student_Living_Guide` is based on New York as a reference point, therefore, the target market for our application is any student living in New York and who is considering other countries to pursue their studies. The `Student_Living_Guide` will guide them in making a more informed decision about the country they wish to pursue their studies.

## Section 2: Description of the data

We will visualize the Numbeo Cost of Living Index dataset, which contains information on the cost of living in cities across the globe. `Cost of Living Index`, `Rent Index`, `Groceries Index`, `Restaurant Price Index` and `Local Purchasing Power Index` are the five primary indices included in the dataset. All the indices take New York City with a score of 100 as a reference point.

The main focus of our dashboard will be the `Cost of Living Index`. It is established by comparing the expenses of living in each region to those of New York City for an everyday set of goods and services, such as housing, transportation, and utilities. For example,  A city with a `Cost of Living Index` of 80 indicates that it is 20% less expensive to live in than New York City.

In addition, the Numbeo dataset also includes the `Rent Index`, which is calculated by comparing the monthly rental prices in that city to those in New York. The `Groceries Index` and `Restaurant Index`, as their name suggests, are indices comparing the cost of grocery prices and restaurant prices with regard to New York.

The `Local Purchasing Power Index` measures the relative purchasing power of a typical income in a city relative to New York City, with a score of 100 representing equal purchasing power. In other words,  If a city has a score of more than 100, the average salary can purchase more goods and services than in New York City, while a number less than 100 implies that the average salary in that city can purchase fewer goods and services than in New York City. 

Apart from the major indices, we also conducted data preprocessing to obtain the country's or city's geolocational features, including `Continent`, `latitude`, and `longitude`, which will allow us to visualize the data on a map.

For our dashboard, we plan to visualize all five aforementioned indices by country and continent. We will allow the user to filter by country and continent and rank the cities based on the selected index.

### Exploratory Data Analysis

The EDA notebook can be found [here](../EDA.ipynb).

## Section 3: Research questions and usage scenarios

Througn our application, students in the shoes of our fictional character Quan will be able to answer the following questions:

- Which country has the highest cost of living?

- Which country has the lowest cost of living?

- What is the correlation between different indexes? For example, what is the correlation between the Groceries Index and Restaurant Price Index?

- Which country has the closest living cost compared to New York?
