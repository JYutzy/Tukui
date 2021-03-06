local T, C, L = unpack(select(2, ...)) -- Import: T - functions, constants, variables; C - config; L - locales

local DataVisibility = 1

---------------------------------------------------------
---[[ ADDITIONAL Asphyxia PANELS ]]---
---------------------------------------------------------

--TOP DUMMY FRAME DOES NOTHING 
if C["asphyxia_panels"].toppanel == true then 
local toppanel = CreateFrame("Frame", "TukuiTopPanel", UIParent)
toppanel:CreatePanel("Transparent", 2000, 20, "TOP", UIParent, "TOP", 0, 0)
toppanel:SetFrameStrata("BACKGROUND")
toppanel:SetFrameLevel(0)
toppanel:CreateShadow("Default")
end

--BOTTOM DUMMY FRAME DOES NOTHING 
if C["asphyxia_panels"].bottompanel == true then 
local bottompanel = CreateFrame("Frame", "TukuiBottomPanel", UIParent)
bottompanel:CreatePanel("Transparent", 2000, 20, "BOTTOM", UIParent, "BOTTOM", 0, 0)
bottompanel:SetFrameStrata("BACKGROUND")
bottompanel:SetFrameLevel(0)
bottompanel:CreateShadow("Default")
end

-- INFO CENTER (FOR STATS)
local icenter = CreateFrame("Frame", "TukuiInfoCenter", TukuiBar1)
icenter:CreatePanel("Default", TukuiBar1:GetWidth(), 17, "TOP", TukuiBar1, "BOTTOM", 0, -3)
icenter:CreateShadow("Default")
icenter:SetFrameLevel(2)
icenter:SetFrameStrata("BACKGROUND")

-- INFO CENTER LEFT (FOR STATS)
local icenterleft = CreateFrame("Frame", "TukuiInfoCenterLeft", TukuiBar2)
icenterleft:CreatePanel("Default", TukuiBar2:GetWidth(), 17, "TOP", TukuiBar2, "BOTTOM", 0, -3)
icenterleft:CreateShadow("Default")
icenterleft:SetFrameLevel(2)
icenterleft:SetFrameStrata("BACKGROUND")

-- INFO CENTER RIGHT (FOR STATS)
local icenterright = CreateFrame("Frame", "TukuiInfoCenterRight", TukuiBar3)
icenterright:CreatePanel("Default", TukuiBar3:GetWidth(), 17, "TOP", TukuiBar3, "BOTTOM", 0, -3)
icenterright:CreateShadow("Default")
icenterright:SetFrameLevel(2)
icenterright:SetFrameStrata("BACKGROUND")

-- TIME PANEL
local watch = CreateFrame("Frame", "Tukuiwatch", UIParent)
watch:CreatePanel("Default", 53, 17, "TOP", Minimap, "BOTTOM", T.Scale(0), 8)
watch:CreateShadow("Default")
watch:SetFrameStrata("MEDIUM")
watch:SetFrameLevel(2)

-- SWITCH LAYOUT
local swl = CreateFrame("Button", "TukuiSwitchLayoutButton", UIParent, "SecureActionButtonTemplate")
	swl:Size(20, 20)
	swl:Point("LEFT", TukuiInfoLeft, "RIGHT", 3, 0)
	swl:SetFrameStrata("BACKGROUND")
	swl:SetFrameLevel(2)
	swl:RegisterForClicks("AnyUp") swl:SetScript("OnClick", function()
		if IsAddOnLoaded("Tukui_Raid") then
			DisableAddOn("Tukui_Raid")
			EnableAddOn("Tukui_Raid_Healing")
			ReloadUI()
		elseif IsAddOnLoaded("Tukui_Raid_Healing") then
			DisableAddOn("Tukui_Raid_Healing")
			EnableAddOn("Tukui_Raid")
			ReloadUI()
		elseif not IsAddOnLoaded("Tukui_Raid_Healing") and not IsAddOnLoaded("Tukui_Raid") then
			EnableAddOn("Tukui_Raid")
			ReloadUI()
		end
end)

-- VERSION BUTTON
local verbutton = CreateFrame("Button", "TukuiVersionButton", TukuiMinimap, "SecureActionButtonTemplate")
verbutton:CreatePanel("Transparent", 13, 17, "LEFT", Tukuiwatch, "RIGHT", 3, 0)
verbutton:CreateShadow("Default")
verbutton:SetAttribute("type", "macro")
verbutton:SetAttribute("macrotext", "/version")
verbutton:SetFrameStrata("MEDIUM")
verbutton:SetFrameLevel(2)

verbutton.Text = T.SetFontString(verbutton, C.media.pixelfont, 10)
verbutton.Text:Point("CENTER", verbutton, "CENTER", 0.5, 0.5)
verbutton.Text:SetText(T.panelcolor.."V")

-- VERSION LOGO (Asphyxia Avatar)
	local avatar = CreateFrame("Frame", nil, TukuiVersionFrame)
	avatar:CreatePanel(avatar, 58, 58, "BOTTOM", TukuiVersionFrame, "TOP", 0, 2)
	avatar:SetFrameLevel(2)
	avatar:SetFrameStrata("BACKGROUND")
	avatar:SetTemplate("Default")
	avatar:CreateShadow("")
	
	local avatar_tex = avatar:CreateTexture(nil, "OVERLAY")
avatar_tex:SetTexture(C.media.asphyxia)
avatar_tex:SetPoint("TOPLEFT", avatar, "TOPLEFT", 2, -2)
avatar_tex:SetPoint("BOTTOMRIGHT", avatar, "BOTTOMRIGHT", -2, 2)

-- HELP BUTTON
local helpbutton = CreateFrame("Button", "TukuiHelpButton", TukuiMinimap, "SecureActionButtonTemplate")
helpbutton:CreatePanel("Default", 13, 17, "RIGHT", Tukuiwatch, "LEFT", -3, 0)
helpbutton:CreateShadow("Default")
helpbutton:SetAttribute("type", "macro")
helpbutton:SetAttribute("macrotext", "/ahelp")
helpbutton:SetFrameStrata("MEDIUM")
helpbutton:SetFrameLevel(2)

helpbutton.Text = T.SetFontString(helpbutton, C.media.pixelfont, 10)
helpbutton.Text:Point("CENTER", helpbutton, "CENTER", 1, 0.5)
helpbutton.Text:SetText(T.panelcolor.."H")

-- Animate function
TukuiAsphyxiaHelpFrame:Animate( 0, 500, 0.8 )
TukuiHelpButton:EnableMouse( true )
TukuiHelpButton:SetScript("OnClick", function(self)
if InCombatLockdown() then return end

if TukuiAsphyxiaHelpFrame:IsVisible() then
TukuiAsphyxiaHelpFrame:SlideOut()
else
TukuiAsphyxiaHelpFrame:SlideIn()
end
end )

-- ADDONS BUTTON
local adbutton = CreateFrame("Button", "TukuiAddonsButton", UIParent, "SecureActionButtonTemplate")
adbutton:CreatePanel("Default", 100, 17, "BOTTOM", UIParent, "BOTTOM", 0, 12)
adbutton:SetAttribute("type", "macro")
adbutton:SetAttribute("macrotext", "/al")

adbutton.Text = T.SetFontString(adbutton, C.media.pixelfont, 10, "OUTLINE")
adbutton.Text:Point("CENTER", adbutton, "CENTER", 0, 0.5)
adbutton.Text:SetText(T.panelcolor..ADDONS)
adbutton.Text:SetShadowColor( 0, 0, 0 )
adbutton.Text:SetShadowOffset(1.25, -1.25)

--[[adbutton.Status = CreateFrame( "StatusBar", "HydraDataStatus", adbutton )
adbutton.Status:SetFrameLevel( 12 )
adbutton.Status:SetStatusBarTexture( C["media"].normTex )
adbutton.Status:SetMinMaxValues( 0, 100 )
adbutton.Status:SetStatusBarColor( 1, 75 / 255, 75 / 255, 0.5, .8 )
adbutton.Status:Point( "TOPLEFT", adbutton, "TOPLEFT", 2, -2 )
adbutton.Status:Point( "BOTTOMRIGHT", adbutton, "BOTTOMRIGHT", -2, 2 )--]]

-- RESETUI BUTTON
local resetuibutton = CreateFrame("Button", "TukuiResetUIButton", UIParent, "SecureActionButtonTemplate")
resetuibutton:CreatePanel("Default", 60, 17, "LEFT", TukuiAddonsButton, "RIGHT", 5, 0)
resetuibutton:SetAttribute("type", "macro")
resetuibutton:SetAttribute("macrotext", "/resetui")

resetuibutton.Text = T.SetFontString(resetuibutton, C.media.pixelfont, 10)
resetuibutton.Text:Point("CENTER", resetuibutton, "CENTER", 0, 0.5)
resetuibutton.Text:SetText(T.panelcolor.."Reset UI")

-- RELOADUI BUTTON
local rluibutton = CreateFrame("Button", "TukuiReloadUIButton", UIParent, "SecureActionButtonTemplate")
rluibutton:CreatePanel("Default", 60, 17, "LEFT", resetuibutton, "RIGHT", 5, 0)
rluibutton:SetAttribute("type", "macro")
rluibutton:SetAttribute("macrotext", "/rl")

rluibutton.Text = T.SetFontString(rluibutton, C.media.pixelfont, 10)
rluibutton.Text:Point("CENTER", rluibutton, "CENTER", 0, 0.5)
rluibutton.Text:SetText(T.panelcolor.."Reload UI")

-- CONFIG BUTTON
local configbutton = CreateFrame("Button", "TukuiConfigButton", UIParent, "SecureActionButtonTemplate")
configbutton:CreatePanel("Default", 60, 17, "RIGHT", TukuiAddonsButton, "LEFT", -5, 0)
configbutton:SetAttribute("type", "macro")
configbutton:SetAttribute("macrotext", "/tc")

configbutton.Text = T.SetFontString(configbutton, C.media.pixelfont, 10)
configbutton.Text:Point("CENTER", configbutton, "CENTER", 0, 0.5)
configbutton.Text:SetText(T.panelcolor.."Config UI")

-- MOVEUI BUTTON
local moveuibutton = CreateFrame("Button", "TukuiMoveUIButton", UIParent, "SecureActionButtonTemplate")
moveuibutton:CreatePanel("Default", 60, 17, "RIGHT", configbutton, "LEFT", -5, 0)
moveuibutton:SetAttribute("type", "macro")
moveuibutton:SetAttribute("macrotext", "/mtukui")

moveuibutton.Text = T.SetFontString(moveuibutton, C.media.pixelfont, 10)
moveuibutton.Text:Point("CENTER", moveuibutton, "CENTER", 0, 0.5)
moveuibutton.Text:SetText(T.panelcolor.."Move UI")

-- MOUSEOVER FUNCTION FOR BUTTONS
local buttonsBG = CreateFrame("frame", "AsphyxiaButtonsBG", UIParent)
buttonsBG:SetPoint("TOPLEFT", moveuibutton, "TOPLEFT" ,0, 0)
buttonsBG:SetPoint("BOTTOMRIGHT", rluibutton, "BOTTOMRIGHT" ,0, 0)
buttonsBG:EnableMouse(true)

local function ModifiedBackdrop(self)
	local color = RAID_CLASS_COLORS[T.myclass]
	self:SetBackdropColor(unpack(C["media"].backdropcolor))
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end

local function OriginalBackdrop(self)
	self:SetBackdropColor(unpack(C["media"].backdropcolor))
	self:SetBackdropBorderColor(unpack(C["media"].bordercolor))
end

local buttons = {"TukuiMoveUIButton", "TukuiConfigButton", "TukuiAddonsButton", "TukuiResetUIButton", "TukuiReloadUIButton", "AsphyxiaButtonsBG"}

for i = 1, getn(buttons) do
	local frame = _G[buttons[i]]
	frame:SetFrameStrata("BACKGROUND")
	frame:SetFrameLevel(2)
	frame:SetAlpha(0)
	frame:CreateShadow("Default")
	frame:SetScript("OnEnter", function(self) for _, f in pairs(buttons) do _G[f]:SetAlpha(1) end end)
	frame:SetScript("OnLeave", function(self) for _, f in pairs(buttons) do _G[f]:SetAlpha(0) end end)
	frame:HookScript("OnEnter", ModifiedBackdrop)
	frame:HookScript("OnLeave", OriginalBackdrop)
	
	if i == 6 then
	frame:SetScript("OnEnter", function()
	if InCombatLockdown() then return end
		frame:FadeIn()
	end)

	frame:SetScript("OnLeave", function()
		frame:FadeOut()
	end)
	end
end

-- WORLD STATE FRAME 
WorldStateAlwaysUpFrame:ClearAllPoints()
WorldStateAlwaysUpFrame:SetPoint("TOP", UIParent, "TOP", 0, T.Scale(-35))

-- TALENT SPEC-SWITCHER (Advanced)
if C["asphyxia_panels"].asphyxiatalent == true then
if UnitLevel("player") <= 10 then return end

local frame = CreateFrame("Frame", "AsphyxiaTalent", UIParent)
frame:CreatePanel(nil, 20, 20, "RIGHT", TukuiInfoRight, "LEFT", -3, 0)
frame:EnableMouse(true)

frame.tex = frame:CreateTexture(nil, "ARTWORK")
frame.tex:Point("TOPLEFT", 2, -2)
frame.tex:Point("BOTTOMRIGHT", -2, 2)
frame.tex:SetTexCoord(0.08, 0.92, 0.08, 0.92)

frame.highlight = frame:CreateTexture(nil, "ARTWORK")
frame.highlight:Point("TOPLEFT", 2, -2)
frame.highlight:Point("BOTTOMRIGHT", -2, 2)
frame.highlight:SetTexture(1,1,1,.3)
frame.highlight:Hide()

local UpdateTexture = function(self)
	local primary = GetPrimaryTalentTree()
	local tex = select(4, GetTalentTabInfo(primary))
	
	self.tex:SetTexture(tex)
end

local ChangeSpec = function()
	local spec = GetActiveTalentGroup()
	
	if spec == 1 then
		SetActiveTalentGroup(2)
	else
		SetActiveTalentGroup(1)
	end
end

local color = RAID_CLASS_COLORS[T.myclass]

local StyleTooltip = function(self)
	if not InCombatLockdown() then
		local p1 = select(5, GetTalentTabInfo(1))
		local p2 = select(5, GetTalentTabInfo(2))
		local p3 = select(5, GetTalentTabInfo(3))
		local name = select(2, GetTalentTabInfo(GetPrimaryTalentTree()))
		local spec = GetActiveTalentGroup()
		
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 0, 2)
		GameTooltip:ClearLines()
		
		if spec == 1 then
			GameTooltip:AddDoubleLine(format(T.panelcolor.."%s: %s/%s/%s - [%s]", name, p1, p2, p3, PRIMARY))
		else
			GameTooltip:AddDoubleLine(format(T.panelcolor.."%s: %s/%s/%s - [%s]", name, p1, p2, p3, SECONDARY))
		end
		
		self.highlight:Show()
		self:SetBackdropBorderColor(color.r, color.g, color.b)
		GameTooltip:Show()
	end
end

local OnLeave = function(self)
	GameTooltip:Hide()
	self.highlight:Hide()
	self:SetBackdropBorderColor(unpack(C.media.bordercolor))
end

frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterEvent("PLAYER_TALENT_UPDATE")
frame:SetScript("OnEvent", UpdateTexture)
frame:SetScript("OnMouseDown", ChangeSpec)
frame:SetScript("OnEnter", StyleTooltip)
frame:SetScript("OnLeave", OnLeave)
end


-- UNITFRAME SHOW/HIDE
if C["unitframes"].hideunitframes == true then
local HideUnitframes = function(self, event)
	if event == "PLAYER_REGEN_DISABLED" then
		UIFrameFadeIn(TukuiPlayer, 0.5, 0, 1)
	else
		UIFrameFadeIn(TukuiPlayer, 0.5, 1, 0)
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:SetScript("OnEvent", HideUnitframes)
end

-- DATATEXT PANEL TOGGLE (Button)
local cp = "|cff9a1212-|r" 
local cm = "|cff9a1212+|r" 
local icb = CreateFrame("Frame", "InfoCenterButton", TukuiChatBackgroundRight)
icb:CreatePanel(nil, 20, 20, "TOPRIGHT", TukuiChatBackgroundRight, "TOPRIGHT", -3, -4)
icb:EnableMouse(true)
icb.f = icb:CreateFontString(nil, overlay)
icb.f:SetPoint("CENTER")
icb.f:SetFont(C["media"].pixelfont, 15, "THINOUTLINE")
icb.f:SetText(cp)
icb.f:Point("CENTER", 1, 1)
icb:SetScript("OnMouseDown", function(self)
	ToggleFrame(icenter)
	ToggleFrame(icenterleft)
	ToggleFrame(icenterright)
	if icenter:IsShown() then
		self.f:SetText(cp)
	else
		self.f:SetText(cm)
	end
end)