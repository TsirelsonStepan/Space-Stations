extends Resource
class_name StorageData
@export var resources : Dictionary
@export var limits : Dictionary

func _increase(type: String, amount: int) -> String:
	if type not in resources.keys():
		resources[type] = amount
		return "OK"
	elif limits[type] >= resources[type] + amount:
		resources[type] += amount
		return "OK"
	else: return "NOT_OK"

func _decrease(type: String, amount: int) -> String:
	if type not in resources.keys():
		return "NOT_OK"
	elif resources[type] >= amount:
		resources[type] -= amount
		return "OK"
	else: return "NOT_OK"

func _change_limits(type: String, amount: int) -> void:
	if (type not in limits.keys() and amount < 0 or 
	type in limits.keys() and limits[type] < amount):
		push_error("Attempt to decrease storgae limit that doesn't exist")
	if type not in limits.keys() and amount > 0: limits[type] = amount
	else: limits[type] += amount
