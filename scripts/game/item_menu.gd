extends ColorRect

@export var item1 : ColorRect;
@export var item2 : ColorRect;
@export var item3 : ColorRect;


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
	
