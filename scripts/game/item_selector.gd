extends ColorRect

@export var title : RichTextLabel;
@export var desc : RichTextLabel;
@export var imgd : Sprite2D;
@export var imgs : Array[Texture2D] = [];
var gamer_node;
var held_item


func set_data(it,id,img,node,held):
	gamer_node = node;
	title.text = it;
	desc.text = id;
	held_item = held;
	imgd.texture = imgs[img];

func _on_button_pressed() -> void:
	gamer_node.select_item(held_item)
	pass 
