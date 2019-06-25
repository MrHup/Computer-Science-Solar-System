conf = {
	-------------GENERAL STUFF----------------------
	orientation = Stage.LANDSCAPE_LEFT,
	transition = SceneManager.crossfade,  --crossfade
	easing = easing.outBack,
	textureFilter = true,
	scaleMode = "letterbox",
	keepAwake = true,
	hugeFont = TTFont.new("Fonts/Voyager Heavy.otf", 586),
	bigFont = TTFont.new("Fonts/Voyager Heavy.otf", 56),
	smallFont = TTFont.new("Fonts/Voyager Light.otf", 40),
	vsmallFont = TTFont.new("Fonts/Voyager Heavy.otf", 20),
	width = 1080,
	height = 1980,
	fps = 60,
	dx = application:getLogicalTranslateX() / application:getLogicalScaleX(),
	dy = application:getLogicalTranslateY() / application:getLogicalScaleY(),
	-------------GAME STUFF------------
	unitate = 10,
	viteza = 20, -- viteza la obiecte
	gravity = 0,
	---------------PLANET STUFF---------------
	radius = 10000,
	scale = 11,
	angle_speed = 1,
	domains = 8,
	zoom = .05,
	time_fade_notif = 2500,
	increment = 0,
	increm_speed = 5,
	extra = 1600,
	EXP2 = 1,
	--------------DEBUGGING---------------
	debug = true
}

CONTROLS = {
	forward = KeyCode.S,
	left = KeyCode.D,
	backwards = KeyCode.W,
	right = KeyCode.A,
	plus = KeyCode.P,
	minus = KeyCode.O,
	reset = KeyCode.L,
	exper = KeyCode.M
}

domens = nil
char = nil
char2 = nil
lume = nil
lume_mare = nil
line_layer = Sprite.new()
lookAtX = nil
lookAtY = nil
zooming = false
unzooming = false
rotate = true
reset = true
centruX, centruY = 0,0
centru = nil
offsetuX = 0
stop_move = false
LUPA = false
offsetuY = 0
de_reprezentat = nil
EXPERIMENT = 0.001