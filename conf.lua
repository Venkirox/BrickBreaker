function love.conf(t)
	t.console = true
	t.window.width = 800
	t.window.height = 450

	GWidth = t.window.width / 800
	GHeigth = t.window.height / 450
	return (GWidth), (GHeigth)
end
