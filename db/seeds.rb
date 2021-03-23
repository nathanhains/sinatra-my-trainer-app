#create 2 users
nate = User.create(name: "Nate", email: "natehains@yahoo.com", password: "password")
raven = User.create(name: "Raven", email: "ravenmccoy@yahoo.com", password: "password")

Exercise.create(name: "Bicep Dumbell Curl", description: "Curl dumbells starting with arms perpindicular to the floor and lift to a 45 degree angle. Repeat.", reps:"8-12", sets:"3-4", muscle_group: "Bicep", user_id: nate.id)
Exercise.create(name: "Bicep Barbell Curl", description: "Curl barbell starting with arms perpindicular to the floor and lift to a 45 degree angle. Repeat.", reps:"8-12", sets:"3-4", muscle_group: "Bicep", user_id: raven.id)

