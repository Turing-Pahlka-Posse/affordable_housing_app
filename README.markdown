## Pahlka Posse Affordable Housing App - Neighborhome

### Overview
Pahlka Posse is a group of Turing School students who are passionate about civic tech. We named our group after Jennifer Pahlka of Code for America, whose leadership has helped us understand the possibilities in this space.

Starting in March 2016 we began meeting to identify a project that would match our capabilities and interests as a group, as well as serve the Denver community. We have begun developing an application that helps low-income Denver residents to find suitable housing. Housing stood out as an area for impact -- it is the basis of individual wealth and stability, and shapes one's sense of community and connection.

While current housing tools take some individual preferences into consideration, most do not adequately address the needs of low-income residents and those who depend on public transportation and public services. Our app, therefore, is one that helps users optimize access to vital services, employment opportunities, and community resources.

![affordable
housing](/app/assets/images/affordable_housing.png "Logo Title Text 1")

The first iteration of Neighborhome does the following:
* asks users to provide three locations that are important to their daily lives (e.g. work, childcare, social service location)
* asks users to identify the maximum rent they can afford.  
* using Google's Distance Matrix API and a monthly data file from Zillow on rental prices, the app identifies neighborhoods within the user's price range which minimize travel distance in text and via map.  
* chloropleth maps display rental information by neighborhood.  

Next steps for the app include:
* identifying an appropriate algorithm to weigh the relative importance of affordability and travel distance.
* identifying most appropriate manner to display results to the user.
* schedule a recurring job to retrieve the updated rental data file from Zillow.  
* incorporate maps and information on public services.  
