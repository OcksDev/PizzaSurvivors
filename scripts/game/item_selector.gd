extends ColorRect

@export var title : RichTextLabel;
@export var desc : RichTextLabel;
@export var imgd : Sprite2D;
@export var imgs : Array[Texture2D] = [];
var gamer_node;
var held_item
var menu_node
var pp
var ipos
var no_de = false

func set_data(it,id,img,node,held):
	gamer_node = node;
	title.text = it;
	desc.text = id;
	held_item = held;
	imgd.texture = imgs[img];

func _on_button_pressed() -> void:
	no_de = true;
	scale = Vector2(1,1);
	position = ipos
	menu_node.select_anim(held_item,pp)
	pass 


func _on_button_mouse_entered() -> void:
	var x = 0.03
	var y = x+1
	scale = Vector2(y,y);
	position = ipos - (size*(x/2))
	pass # Replace with function body.



func _on_button_mouse_exited() -> void:
	if(no_de): return;
	scale = Vector2(1,1);
	position = ipos
	pass # Replace with function body.
