# Feedsta

Feedsta is an app which allows you to preview new posts in your Instagram feed prior to posting. It is currently in development only. There is no live accessible production environment.

## Dependencies

* Rails version 5.0
* MySQL version 5.0 and upwards

## Local Deployment

Follow these steps to deploy the app on your local machine:

* Clone the repo `git clone https://github.com/franklia/feedsta`
* Run `cd feedsta`
* Create an application.yml file to contain environment variables in this location: /config/application.yml Add the following variable names.

-----

INSTA\_CLIENT\_ID:  
INSTA\_SECRET\_KEY:  
GMAIL\_DOMAIN:  
GMAIL\_USERNAME:  
GMAIL\_PASSWORD:  
ACTION\_MAILER\_HOST:  
DEVELOPMENT\_MYSQL\_USERNAME:  
DEVELOPMENT\_MYSQL\_PASSWORD:  
DEVELOPMENT\_MYSQL\_DB\_NAME:  

development:  
  REDIRECT_URL:  

production:  
  REDIRECT_URL:  

-----

* Create your own Instagram developer account here: https://www.instagram.com/developer, enter your client ID and Secret Key into the application.yml file
* Run `mysql.server start` to start your local MySQL server
* Create a local MySQL database and enter the credentials into the application.yml files
* Follow this article to set up a mailer to perform the "Forgot Password" feature in devise: https://rubyonrailshelp.wordpress.com/2014/01/02/setting-up-mailer-using-devise-for-forgot-password/, then enter your Gmail credentials into the application.yml file
* Run `rails server` to start the local servers
* Open `http://localhost:3000` to view the app
