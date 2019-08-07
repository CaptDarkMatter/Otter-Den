extends Node


signal OnObjectLoaded(obj)
signal OnRequestObjectUnload(obj)
signal OnRequestLevelChange(level)
signal OnLevelLoaded()
signal OnPlayerCreated(player)
signal OnAttributeAdded(obj, added_name)
signal OnCameraDragged()
signal OnMovement(obj, dir)
signal OnPositionUpdated(obj)
signal OnBeginParallelAction(obj)
signal OnUseAP(obj, amount)
signal OnEndParallelAction(obj)
signal OnUseEnergy(obj, amount)
signal OnEnergyChanged(obj)
signal OnObjTurn(obj)
signal OnLogLine(text)
signal OnDealDamage(targets, shooter, weapon_data, shot_tile) # fired before all other validations
signal OnShotFired(shot_tile, shooter, weapon_data) # for VFX
signal OnDamageTaken(target, shooter) # only fired if damage is > 0
signal OnPickup(picker, picked)
signal OnDropCargo(dropper, item_id, count)
signal OnDropMount(dropper, item_id, index)
signal OnRemoveMount(dropper, item_id, index)
signal OnEquipMount(equipper, slot_name, index, item_id)
signal OnAddItem(picker, item_id)
signal OnRemoveItem(holder, item_id, amount)
signal OnScannerUpdated(obj)
signal OnPlayerDeath()
signal OnObjectDestroyed(obj) # for vfx
signal OnRequestTargettingOverlay(player, targetting_data, callback_obj, callback_method)
signal OnTargetClick(click_pos, target_type)
signal OnWaitForAnimation()
signal OnAnimationDone()
signal OnTransferPlayer(old_player, new_player)
signal OnMountRemoved(obj, slot, src)
signal OnMountAdded(obj, slot, src)
signal OnClearMounts(obj)
signal OnClearCargo(obj)
signal OnReplaceMounts(obj, new_mounts)
signal OnReplaceCargo(obj, new_cargo)
signal OnUpdateCargoVolume(obj)
signal OnConsumeItem(obj, item_data)
signal OnTriggerAnomaly(obj, anomaly)
signal OnAnomalyEffectGone(obj, effect_data)

signal OnGUILoaded(name, obj)
signal OnPushGUI(name, init_param)
signal OnPopGUI()
signal OnAddShortcut(key, obj, method)
signal OnRemoveShortcut(key, obj, method)
signal OnEnableShortcut(key, obj, method, isEnabled)


func _ready():
	pass