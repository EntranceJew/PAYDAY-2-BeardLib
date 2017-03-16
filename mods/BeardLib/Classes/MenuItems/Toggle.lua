Toggle = Toggle or class(Item)

function Toggle:init(parent, params)    
	self.type_name = "Toggle"
	self.super.init(self, parent, params)
    params.panel:bitmap({
        name = "toggle",
        w = params.items_size,
        h = params.items_size,
        layer = 6,
        color = params.text_color or Color.black,
        texture = "guis/textures/menu_tickbox",
        texture_rect = params.value and {24,0,24,24} or {0,0,24,24},
    }):set_right(params.panel:w())
end

function Toggle:SetEnabled(enabled)
	self.super.SetEnabled(self, enabled)
	self.panel:child("toggle"):set_alpha(enabled and 1 or 0.5)
end

function Toggle:SetValue(value, run_callback)
	self.super.SetValue(self, value, run_callback)
	if alive(self.panel) then
		if managers.menu_component then
			managers.menu_component:post_event(value and "box_tick" or "box_untick")
		end
		if value == true then
			self.panel:child("toggle"):set_texture_rect(24,0,24,24)
		else
			self.panel:child("toggle"):set_texture_rect(0,0,24,24)			
		end
	end
end

function Toggle:MousePressed(button, x, y)
	if button == Idstring("0") then
		self:SetValue(not self.value)	
		self.super.MousePressed(self, button, x, y)
        return true
	end
end

function Toggle:KeyPressed(o, k)
	if k == Idstring("enter") then
		self:SetValue(not self.value)
		self:RunCallback()
	end
end

function Toggle:MouseMoved(x, y)
    if not self.super.MouseMoved(self, x, y) then
        return
    end    
    self.panel:child("toggle"):set_color(self.panel:child("title"):color())
end

 