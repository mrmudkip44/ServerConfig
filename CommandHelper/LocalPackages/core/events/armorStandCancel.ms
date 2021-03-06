bind(hanging_break,null,array('type': '/ITEM_FRAME|PAINTING/'),@e){
        cancel()
        if(@e['player'] != null && has_permission(@e['player'],'cancel.entityclicks') == false){
            console('dead from hanging break')
            console(@e['location'])
            entity_remove(@e['id'])
            die()
        }else if(@e['cause'] == 'PHYSICS'){
            entity_remove(@e['id'])
            if(@e['type'] == 'PAINTING'){
                @num = '321'
            }else{
                @num = '389'
            }
            @item = array('type':@num, 'data':0, 'qty': 1)
            console(@e)
 
            drop_item(@e['location'],@item)
        }
}
bind(player_interact_at_entity,null,null,@e){
    if(has_permission('cancel.entityclicks') == false){
        console('dead from player interact at entity')
        console(@e['player'])
        die()
    }
    cancel()
}
bind(player_interact_entity,null,array('clicked':'ITEM_FRAME'),@e){
    if(has_permission('cancel.entityclicks') == false){
        console('dead from player interact')
        console(@e['location'])
        die()
    }
    cancel()
}
bind(entity_damage,null,array('type':'/ARMOR_STAND|ITEM_FRAME|PAINTING|MINECART|CHEST_MINECART|TNT_MINECART|FURNACE_MINECART|HOPPER_MINECART/'),@e){
    cancel()
    if(array_index_exists(@e,'damager')){
        if(has_permission(@e['damager'],'cancel.entityclicks') == false){
            console('dead from damage entity')
            console(@e['location'])
            entity_remove(@e['id'])
            die()
        }
    }
}
bind(vehicle_destroy,null,null,@e){
    include('/home/minecraft/server/plugins/CommandHelper/includes/isWorldExplorable.ms')
    if(_isWorldExplorable(@e['location']['world'])){
        cancel()
    }
    if(array_index_exists(@e, 'damager') && has_permission(@e['damager'],'cancel.entityclicks') == false){
        console('dead from vehicle destroy')
        entity_remove(@e['vehicle'])
        console(@e['location'])
        die()
    }
}
bind(block_dispense,null,null,@e){
    include('/home/minecraft/server/plugins/CommandHelper/includes/isWorldExplorable.ms')
    if(_isWorldExplorable(@e['location']['world'])){
        cancel()
    }
}
bind(inventory_click,null,array(item: 301, item: 305, item: 309, item: 313, item: 317 ),@e){
        if(@e['slotitem'] != null && array_index_exists(@e['slotitem'],'enchants')){
            foreach(@enchant in @e['slotitem']['enchants']){
                if(@enchant['etype'] == 'FROST_WALKER'){
                    @enchant['elevel'] = 0
                }
            }
            modify_event('slotitem',@e['slotitem'])
        }
}
bind(player_interact, null, array(button: 'right'), @e){
    if(@e['action'] == 'right_click_air'){
        @meta = get_itemmeta(@e['player'], null)
        if(@meta != null && is_array(@meta['enchants'])){
            @item = pinv(@e['player'],null)
            if(@item['type'] == 301 || @item['type'] == 305 || @item['type'] == 309 || @item['type'] == 313 || @item['type'] == 317){
                foreach(@enchant in @meta['enchants']){
                    if(@enchant['etype'] == 'FROST_WALKER'){
                        @enchant['elevel'] = 0
                    }
                }
                set_itemmeta(@e['player'], null, @meta)
            }
        }
    }
}
#bind(inventory_open,null,null,@e){
#    if(has_permission('cancel.entityclicks') && !has_permission('is.op')){
#        cancel()
#    }
#}
