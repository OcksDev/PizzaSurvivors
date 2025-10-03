extends ColorRect

@export var title : RichTextLabel;
@export var desc : RichTextLabel;
@export var imgd : Sprite2D;
@export var imgs : Array[Texture2D] = [];
var gamer_node;
var held_item
var menu_node
var pp

func set_data(it,id,img,node,held):
	gamer_node = node;
	title.text = it;
	desc.text = id;
	held_item = held;
	imgd.texture = imgs[img];

func _on_button_pressed() -> void:
	menu_node.select_anim(held_item,pp)
	pass 
