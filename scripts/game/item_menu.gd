extends ColorRect

@export var item1 : ColorRect;
@export var item2 : ColorRect;
@export var item3 : ColorRect;

var ipos3 = null;
var ipos1 = null;
var ipos2;

func anim() -> void:
	
	if(ipos1 == null):
		ipos1 = item1.position;
		ipos2 = item2.position;
		ipos3 = item3.position;
	else:
		item1.position = ipos1;
		item2.position = ipos2;
		item3.position = ipos3;
	
	item1.scale = Vector2(0,0);
	item2.scale = Vector2(0,0);
	item3.scale = Vector2(0,0);
	
	var tween2 = create_tween()
	tween2.set_ease(Tween.EASE_OUT) # Eases the animation out, slowing down towards the end
	tween2.set_trans(Tween.TRANS_ELASTIC)
	tween2.tween_property(item2, "scale", Vector2(1, 1), 0.5).from(Vector2(0,0)) # Animate position over 1 second
	tween2.parallel().tween_property(item2, "position", Vector2(item2.position.x, item2.position.y), 0.5).from(Vector2(item2.position.x+(item2.size.x/2),item2.position.y+(item2.size.y/2)))
	await get_tree().create_timer(0.03).timeout #
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT) # Eases the animation out, slowing down towards the end
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(item1, "scale", Vector2(1, 1), 0.5).from(Vector2(0,0)) # Animate position over 1 second
	tween.parallel().tween_property(item1, "position", Vector2(item1.position.x, item1.position.y), 0.5).from(Vector2(item1.position.x+(item1.size.x/2),item1.position.y+(item1.size.y/2)))
	await get_tree().create_timer(0.03).timeout #
	var tween3 = create_tween()
	tween3.set_ease(Tween.EASE_OUT) # Eases the animation out, slowing down towards the end
	tween3.set_trans(Tween.TRANS_ELASTIC)
	tween3.tween_property(item3, "scale", Vector2(1, 1), 0.5).from(Vector2(0,0)) # Animate position over 1 second
	tween3.parallel().tween_property(item3, "position", Vector2(item3.position.x, item3.position.y), 0.5).from(Vector2(item3.position.x+(item3.size.x/2),item3.position.y+(item3.size.y/2)))
var gm;
func set_random_items(item_titles, item_descs, item_imgs, fucking_game_node):
	
	gm = fucking_game_node;
	var items_list = item_titles.keys();
	var i = randi_range(0,items_list.size()-1)
	var picked_item = items_list[i];
	items_list.remove_at(i)
	item1.menu_node = self;
	item1.pp = 0;
	item1.ipos = ipos1;
	item1.set_data(item_titles[picked_item], item_descs[picked_item], item_imgs[picked_item], fucking_game_node, picked_item)
	
	i = randi_range(0,items_list.size()-1)
	picked_item = items_list[i];
	items_list.remove_at(i)
	item2.menu_node = self;
	item2.pp = 1;
	item2.ipos = ipos2;
	item2.set_data(item_titles[picked_item], item_descs[picked_item], item_imgs[picked_item], fucking_game_node, picked_item)
	
	i = randi_range(0,items_list.size()-1)
	picked_item = items_list[i];
	items_list.remove_at(i)
	item3.menu_node = self;
	item3.pp = 2;
	item3.ipos = ipos3;
	item3.set_data(item_titles[picked_item], item_descs[picked_item], item_imgs[picked_item], fucking_game_node, picked_item)
	
	pass;
	
func select_anim(item, pp):
	var x = 0.5;
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN) # Eases the animation out, slowing down towards the end
	if(pp==0):
		tween.set_trans(Tween.TRANS_BACK)
	else:
		tween.set_trans(Tween.TRANS_SINE)
		x = 0.3
	tween.tween_property(item1, "scale", Vector2(0, 0), x).from(Vector2(1,1)) # Animate position over 1 second
	tween.parallel().tween_property(item1, "position", Vector2(item1.position.x+(item1.size.x/2),item1.position.y+(item1.size.y/2)), x).from(Vector2(item1.position.x, item1.position.y))
	x = 0.5;
	var tween2 = create_tween()
	tween2.set_ease(Tween.EASE_IN) # Eases the animation out, slowing down towards the end
	if(pp==1):
		tween2.set_trans(Tween.TRANS_BACK)
	else:
		tween2.set_trans(Tween.TRANS_SINE)
		x = 0.3
	tween2.tween_property(item2, "scale", Vector2(0, 0), x).from(Vector2(1,1)) # Animate position over 1 second
	tween2.parallel().tween_property(item2, "position", Vector2(item2.position.x+(item2.size.x/2),item2.position.y+(item2.size.y/2)), x).from(Vector2(item2.position.x, item2.position.y))
	x = 0.5
	var tween3 = create_tween()
	tween3.set_ease(Tween.EASE_IN) # Eases the animation out, slowing down towards the end
	if(pp==2):
		tween3.set_trans(Tween.TRANS_BACK)
	else:
		tween3.set_trans(Tween.TRANS_SINE)
		x = 0.3
	tween3.tween_property(item3, "scale", Vector2(0, 0), x).from(Vector2(1,1)) # Animate position over 1 second
	tween3.parallel().tween_property(item3, "position", Vector2(item3.position.x+(item3.size.x/2),item3.position.y+(item3.size.y/2)), x).from(Vector2(item3.position.x, item3.position.y))

	await get_tree().create_timer(0.75).timeout # Wait for 0.1 seconds
	gm.select_item(item);
	pass;
	
	
