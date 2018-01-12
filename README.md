# Instructions to run the the Roadmaps backend

1. Clone the repo and make your current directory the root of the folder
2. in your terminal, run 'bundle install'
3. run 'rake db: create', then 'rake db:migrate'
4. finally, run 'rails s' to run the server


##Backend features

*Alows CRUD functions with Users, Trips, Stops, Activities, and Pictures

*Authenticates users through their JWT token and encrypts their passwords with bcrypt

*Includes Google API helpers that are integrated with the CRUD functions. Allows each Stop to be created and updated with stop information such as travel time and distance.
