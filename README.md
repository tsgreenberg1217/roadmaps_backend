# Instructions to run the the Roadmaps backend
## Checkout the Demo [here](https://myroadmap.herokuapp.com/login)

## Features

* Alows CRUD functions with Users, Trips, Stops, Activities, and Pictures

* Authenticates users through JWT token and encrypts their passwords with bcrypt

* Includes Google API helpers that are integrated with the CRUD functions. Allows each Stop to be created and updated with stop information such as travel time and distance.


1. Clone the repo and make your current directory the root of the folder
2. in your terminal, run 'bundle install'
3. run 'rake db: create', then 'rake db:migrate'
4. finally, run 'rails s' and run the server on port 3000
