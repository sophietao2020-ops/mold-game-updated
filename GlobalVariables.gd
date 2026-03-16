extends Node

var tutorialDone = false
var tutorialSkippedAsk = false
var tutorialSkipped = false
var tutorialPart = 0
var inhand = null
var fridgeItems = ["res://Items/apple.png","res://Items/banana.png","res://Items/cheese.png"]
var sinkItems = ["res://Items/plug.PNG","res://Items/sponge.png","res://Items/water.PNG","res://Items/dishwash.PNG"]
var drawerItems = ["res://Items/tongs.png","res://Items/spatula.png","res://Items/fork.png","res://Items/knife.png","res://Items/spoon.png"]
var cupboardItems = ["res://Items/tomatocan.png","res://Items/sardinecan.png","res://Items/mug.png","res://Items/bowl.png"]
var tableItems = [null,null,null,null]
var eatenItems = {"Other": 0, "Metal": 0, "Food": 0}
var propertyItems = {
  "res://Items/apple.png": "Food",
  "res://Items/banana.png": "Food",
  "res://Items/cheese.png": "Food",
  "res://Items/tomatocan.png": "Food",
  "res://Items/sardinecan.png": "Food",
  "res://Items/fork.png": "Metal",
  "res://Items/knife.png": "Metal",
  "res://Items/spoon.png": "Metal",
  "res://Items/tongs.png": "Metal",
  "res://Items/spatula.png": "Metal",
  "res://Items/plug.PNG": "Other",
  "res://Items/sponge.png": "Other",
  "res://Items/water.PNG": "Other",
  "res://Items/mug.png": "Other",
  "res://Items/bowl.png": "Other","res://Items/dish wash.PNG":"Other"
};
var moldType = ["res://MoldStages/inital.PNG","Basic"]
