extends ColorRect

@export var item1 : ColorRect;
@export var item2 : ColorRect;
@export var item3 : ColorRect;

func anim() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT) # Eases the animation out, slowing down towards the end
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(item1, "scale", Vector2(1, 1), 0.5).from(Vector2(0,0)) # Animate position over 1 second
	tween.parallel().tween_property(item1, "position", Vector2(item1.position.x, item1.position.y), 0.5).from(Vector2(item1.position.x+(item1.size.x/2),item1.position.y+(item1.size.y/2)))
	var tween2 = create_tween()
	tween2.set_ease(Tween.EASE_OUT) # Eases the animation out, slowing down towards the end
	tween2.set_trans(Tween.TRANS_ELASTIC)
	tween2.tween_property(item2, "scale", Vector2(1, 1), 0.5).from(Vector2(0,0)) # Animate position over 1 second
	tween2.parallel().tween_property(item2, "position", Vector2(item2.position.x, item2.position.y), 0.5).from(Vector2(item2.position.x+(item2.size.x/2),item2.position.y+(item2.size.y/2)))
	var tween3 = create_tween()
	tween3.set_ease(Tween.EASE_OUT) # Eases the animation out, slowing down towards the end
	tween3.set_trans(Tween.TRANS_ELASTIC)
	tween3.tween_property(item3, "scale", Vector2(1, 1), 0.5).from(Vector2(0,0)) # Animate position over 1 second
	tween3.parallel().tween_property(item3, "position", Vector2(item3.position.x, item3.position.y), 0.5).from(Vector2(item3.position.x+(item3.size.x/2),item3.position.y+(item3.size.y/2)))

func set_random_items(item_titles, item_descs, item_imgs, fucking_game_node):
	
	var items_list = item_titles.keys();
	var i = randi_range(0,items_list.size()-1)
	var picked_item = items_list[i];
	items_list.remove_at(i)
	item1.set_data(item_titles[picked_item], item_descs[picked_item], item_imgs[picked_item], fucking_game_node, picked_item)
	
	i = randi_range(0,items_list.size()-1)
	picked_item = items_list[i];
	items_list.remove_at(i)
	item2.set_data(item_titles[picked_item], item_descs[picked_item], item_imgs[picked_item], fucking_game_node, picked_item)
	
	i = randi_range(0,items_list.size()-1)
	picked_item = items_list[i];
	items_list.remove_at(i)
	item3.set_data(item_titles[picked_item], item_descs[picked_item], item_imgs[picked_item], fucking_game_node, picked_item)
	
	pass;
	
