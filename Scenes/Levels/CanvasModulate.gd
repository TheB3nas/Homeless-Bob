extends CanvasModulate

@export var gradiant:GradientTexture2D

var time:float = 0.0
const MINUTES_PER_DAY = 1440

func _process(delta):
	var total_minutes_normalized = float(Globals.total_minutes / MINUTES_PER_DAY)
	var value = (sin(total_minutes_normalized * 2.0 * PI - 0.5 * PI) + 1.0) / 2.0
	
	self.color = gradiant.gradient.sample(value) #0.1 night, 0.5 dusk, 1 day should be moved away from process
	
