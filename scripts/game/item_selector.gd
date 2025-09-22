extends ColorRect

@export var title : RichTextLabel;
@export var desc : RichTextLabel;
var gamer_node;
var held_item

func set_data(it,id,node,held):
	gamer_node = node;
	title.text = it;
	desc.text = id;
	held_item = held;


func _on_button_pressed() -> void:
	gamer_node.select_item(held_item)
	pass 
