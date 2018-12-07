class Lifts{
    constructor(date, Name, Reps, Sets, Weight, ID)
    {
        this.date = date;
        this.Name = Name;
        this.Reps = Reps;
        this.Sets = Sets;
        this.Weight = Weight;
    }
}

firebase.auth().onAuthStateChanged(function(user) {
    if (user) {
      var uid = user.uid
      return firebase.database().ref("/users/" + uid).once('value').then(function(snapshot) {
        var name = (snapshot.val() && snapshot.val().name) 
        var title = document.getElementById("title")
        title.innerText = name + "'s Lifts"
        document.getElementById("loader").style.display = 'none'  
        retrieveData()
      }); 
    } else {
      alert("please sign in before trying to continue.")
      window.location.href="index.html"
    }
  });

  function handleSignOut()
  {
    firebase.auth().signOut().then(function() {
        window.location.href="index.html"
      }).catch(function(error) {
        alert("shit something happened" + error)
      });
  }
  function retrieveData(){
    var listOfLifts =[]
    var user = firebase.auth().currentUser;
    var uid = user.uid
    firebase.database().ref("/users/" + uid + "/Workouts").once('value').then(function(snapshot)
    {
      snapshot.forEach(function(childSnapshot)
      {
          var date = document.createTextNode(childSnapshot.key)
          var workoutDate = document.createElement("H2")
          workoutDate.appendChild(date)
          document.body.appendChild(workoutDate)
          childSnapshot.forEach(function(grandChildSnapshot, date, workoutDate)
          {
              //creating an object of the current lift.
            var lift = new Lifts(date, grandChildSnapshot.child("Name").val(), grandChildSnapshot.child("Reps").val(), grandChildSnapshot.child("Sets").val(), grandChildSnapshot.child("Weight").val())
            var workoutName = document.createElement("H3")
            var name = document.createTextNode("Name: " + lift.Name)
            workoutName.appendChild(name)
            document.body.appendChild(workoutName)

            var workoutSets = document.createElement("H4")
            var sets = document.createTextNode("Sets Performed: "+ lift.Sets)
            workoutSets.appendChild(sets)
            document.body.appendChild(workoutSets)
            

            var workoutReps = document.createElement("H4")
            var reps = document.createTextNode("Reps Performed: " + lift.Reps)
            workoutReps.appendChild(reps)
            document.body.appendChild(workoutReps)

            var workoutWeight = document.createElement("H4")
            var weight = document.createTextNode("Weight Used: "+lift.Weight)
            workoutWeight.appendChild(weight)
            document.body.appendChild(workoutWeight);

            var blank = document.createElement("br")
            document.body.appendChild(blank)
           
          });
      });
       
      });

      var button1 = document.getElementById("grab")
      button1.parentNode.removeChild(button1)
  }