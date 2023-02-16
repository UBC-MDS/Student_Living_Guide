# Author: Caesar Wong
# Date: 2023-02-16

"""
A script that preprocess the data and store it under the data/ folder.

Usage: src/preprocessing.py --input_path=<input_path> --output_path=<output_path> 

Options:
--input_path=<input_path>       Input path for the raw dataset
--output_path=<output_path>     Specify the path where user can store the preprocessed dataframe

"""

# Example:
# python preprocessing.py --input_path="../data/raw_data.csv" --output_path="../data/processed_data.csv"

# importing necessary modules
from docopt import docopt
import pandas as pd
import pycountry_convert as pc
from geopy.geocoders import Nominatim

opt = docopt(__doc__) # This would parse into dictionary in python

def generalPreprocessing(df):
    '''
    Perform general preprocessing on df
    
    Parameters
    ----------
    df : pd.DataFrame
        dataframe storing all the raw data
    
    Returns
    -------
    df : pd.DataFrame
        preprocessed (rename country) dataframe
        
    Examples
    --------
    >>> generalPreprocessing(df)
    df object
    '''
    
    # testing column shape
    assert df.shape[1] == 8, "Wrong dataframe shape (incorrect number of columns)"
    # testing typo
    assert 'Country' in df.columns, "Country column is missing"

    print("df shape : ")
    print(df.shape)

    replace_values = {'Bosnia And Herzegovina': 'Bosnia and Herzegovina',  
                  'Trinidad And Tobago': 'Trinidad and Tobago',
                  'Kosovo (Disputed Territory)': 'Kosovo'}  

    # rename some of the Countries to the pycountry_convert known countries
    df['Country'] = df['Country'].replace(replace_values)

    return df


def country_to_continent(country_name):
    if country_name == 'Kosovo':
        return 'Europe'
    country_alpha2 = pc.country_name_to_country_alpha2(country_name)
    country_continent_code = pc.country_alpha2_to_continent_code(country_alpha2)
    country_continent_name = pc.convert_continent_code_to_continent_name(country_continent_code)

    return country_continent_name

def get_lat_lon(location):
    try:
        geolocator = Nominatim(user_agent="first_app")
        location = geolocator.geocode(location)
        return (location.latitude, location.longitude)
    except:
        return (None, None)
    

def columnTransformation(df):

    
    # preprocessing 1: adding continent column to df, given country name
    print("Processing add Continent...")
    df['Continent'] = df['Country'].apply(lambda x: country_to_continent(x))
    print('Continent summary:')
    print(df['Continent'].value_counts())
    
    # preprocessing 2: adding 'latitude', 'longitude' to df, given country name
    print("Processing add latitude, longitude...")
    df[['latitude', 'longitude']] = df['Country'].apply(lambda x: pd.Series(get_lat_lon(x)))
    print("Number of missed Latitude: " + str(df['latitude'].isnull().sum()))


    print("preprocessed df shape : ")
    print(df.shape)

    return df

def main(input_path, output_path):
    '''
    main function for the preprocessing script
    1. Data dropping
    2. Data arrange column
    3. column transformation

    Parameters
    ----------
    input_path : str
        input file path

    output_path : str
        output file path
    
    Returns
    -------
    <None>
    save 1 csv to output_path
    - processed.csv

    Examples
    --------
    >>> main(opt["--input_path"], opt["--output_path"])
    
    '''
    print("Begin data preprocessing...")
    df = pd.read_csv(input_path)
    df = generalPreprocessing(df)

    # calling local columnTransformation function
    processed_df = columnTransformation(df)

    processed_df.to_csv(output_path, index=False)

    print("finised data preprocessing")
    

if __name__ == "__main__":
    main(opt["--input_path"], opt["--output_path"])