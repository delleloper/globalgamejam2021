extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var toastScn = preload("res://Ui/ItemToast.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Ship_itemPicked(object) -> void:
	var toast = toastScn.instance()
	toast.item = object
	$ItemList.add_child(toast)
