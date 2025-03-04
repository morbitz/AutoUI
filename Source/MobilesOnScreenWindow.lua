
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

MobilesOnScreen = {}
MobilesOnScreen.IsInTable = {}
MobilesOnScreen.MobilesSort = {}
MobilesOnScreen.MobilesSortReverse = {}
MobilesOnScreen.NeedsUpdate = false
MobilesOnScreen.DeltaClean = 0
MobilesOnScreen.STRFilter = ""
MobilesOnScreen.DistanceSort = false
MobilesOnScreen.locked = false

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------
MobilesOnScreen.Mobiles = {}
MobilesOnScreen.BarsY = 55
MobilesOnScreen.BarScale = 1 
MobilesOnScreen.windowOffset = 0

MobilesOnScreen.Hidden = false
MobilesOnScreen.Filter = {}
MobilesOnScreen.Filter[1] =	GetStringFromTid(1011051)
MobilesOnScreen.Filter[2] =	GetStringFromTid(1154822)
MobilesOnScreen.Filter[3] =	GetStringFromTid(1078866)
MobilesOnScreen.Filter[4] =	GetStringFromTid(1154823)
MobilesOnScreen.Filter[5] =	GetStringFromTid(1153802)
MobilesOnScreen.Filter[6] =	GetStringFromTid(1095164)
MobilesOnScreen.Filter[7] =	GetStringFromTid(1154824)
MobilesOnScreen.Filter[8] =	GetStringFromTid(3000509)
MobilesOnScreen.Filter[9] =	GetStringFromTid(1154825)
MobilesOnScreen.Filter[10] =GetStringFromTid(1154826)
MobilesOnScreen.SavedFilter = {}

MobilesOnScreen.PetUpdateTime = 0
MobilesOnScreen.PetUpdateFreq = 1
MobilesOnScreen.ReversePet = {}

MobilesOnScreen.YellowEnabled = false
MobilesOnScreen.GreyEnabled = false
MobilesOnScreen.BlueEnabled = false
MobilesOnScreen.RedEnabled = false
MobilesOnScreen.GreenEnabled = false
MobilesOnScreen.OrangeEnabled = false

MobilesOnScreen.UnsortedLimit = 10
MobilesOnScreen.YellowLimit = 10
MobilesOnScreen.GreyLimit = 10
MobilesOnScreen.BlueLimit = 10
MobilesOnScreen.RedLimit = 10
MobilesOnScreen.GreenLimit = 10
MobilesOnScreen.OrangeLimit = 10

MobilesOnScreen.UnsortedWindows = 0
MobilesOnScreen.YellowWindows = 0
MobilesOnScreen.GreyWindows = 0
MobilesOnScreen.BlueWindows = 0
MobilesOnScreen.RedWindows = 0
MobilesOnScreen.GreenWindows = 0
MobilesOnScreen.OrangeWindows = 0

MobilesOnScreen.UnSorted = {}

MobilesOnScreen.MobilesYellow = {}
MobilesOnScreen.MobilesGrey = {}
MobilesOnScreen.MobilesBlue = {}
MobilesOnScreen.MobilesRed = {}
MobilesOnScreen.MobilesGreen = {}
MobilesOnScreen.MobilesOrange = {}

MobilesOnScreen.MobilesOrange = {}

MobilesOnScreen.Dockspotlocked = false

MobilesOnScreen.AnchorUpdateRequest = false
MobilesOnScreen.delta = 0

MobilesOnScreen.UpdateLimit = 0.25

MobilesOnScreen.FarmNames = {
["a dog"] = true, ["a hind"] = true, ["a boar"] = true, ["a cat"] = true, ["a bull"] = true, ["a chicken"] = true, ["a cow"] = true, ["a goat"] = true, ["a jack rabbit"] = true, 
["a pig"] = true, ["a rabbit"] = true, ["a sheep"] = true, ["a black bear"] = true, ["a brown bear"] = true, ["a cougar"] = true, ["an eagle"] = true, ["a gorilla"] = true, ["a great hart"] = true, ["a grey wolf"] = true, 
["a grizzly bear"] = true, ["a horse"] = true, ["a llama"] = true, ["a mountain goat"] = true, ["a panther"] = true, ["a timber wolf"] = true,
["a crane"] = true, ["a gaman"] = true, ["a tropical bird"] = true, ["a crow"] = true, ["a bird"] = true, ["a magpie"] = true, ["a raven"] = true, ["a squirrel"] = true, ["a ferret"] = true, ["a tern"] = true, ["a swift"] = true, ["a wren"] = true,
["a swallow"] = true, ["a warbler"] = true, ["a nuthatch"] = true, ["a chickadee"] = true, ["a thrush"] = true, ["a nightingale"] = true, ["a starling"] = true, ["a skylark"] = true, ["a finch"] = true, ["a crossbill"] = true, ["a canary"] = true,
["a sparrow"] = true, ["a towhee"] = true, ["a shrike"] = true, ["a woodpecker"] = true, ["a kingfisher"] = true, ["a plover"] = true, ["a lapwing"] = true, ["a hawk"] = true, ["a dove"] = true, ["a cuckoo"] = true, ["a skittering hopper"] = true }

MobilesOnScreen.Summons = { ["a revenant"] = true, ["an energy vortex"] = true, ["a blade spirit"] = true, ["a rising colossus"] = true, ["a nature's fury"] = true
}

MobilesOnScreen.CloseLeft = true

----------------------------------------------------------------
-- MobilesOnScreen Functions
----------------------------------------------------------------
function MobilesOnScreen.Initialize()
	local windowName = "MobilesOnScreenWindow"
	SnapUtils.SnappableWindows[windowName] = true
	local titleName = windowName.."ShowViewName"
	local hideTitleName = windowName.."HideViewName"
	
	LabelSetText(titleName, GetStringFromTid(1075672) )
	LabelSetText(hideTitleName, GetStringFromTid(1075672) )
	
	MobilesOnScreen.CloseLeft = Interface.LoadBoolean( "MobilesOnScreenCloseLeft", MobilesOnScreen.CloseLeft)
	WindowClearAnchors("MobilesOnScreenWindowHideView")
	if (MobilesOnScreen.CloseLeft) then
		WindowAddAnchor("MobilesOnScreenWindowHideView", "topleft", "MobilesOnScreenWindow", "topleft", 0, 0 )
	else
		WindowAddAnchor("MobilesOnScreenWindowHideView", "topright", "MobilesOnScreenWindow", "topright", 0, 0 )
	end
	
	WindowUtils.RestoreWindowPosition(windowName, false)
	WindowSetAlpha(windowName .. "ShowViewFrame", 0.5)
	WindowSetScale(windowName, SystemData.Settings.Interface.customUiScale * 0.80)
	MobilesOnScreen.DistanceSort = Interface.LoadBoolean( "MobilesOnScreenDistanceSort" , MobilesOnScreen.DistanceSort )
	MobilesOnScreen.ButtonRotation()	
	-- MoS Filter Window
	
	MobilesOnScreen.UnsortedLimit = Interface.LoadNumber("UnsortedLimit", 10 )
	MobilesOnScreen.YellowLimit = Interface.LoadNumber("YellowLimit", 10 )
	MobilesOnScreen.GreyLimit = Interface.LoadNumber("GreyLimit", 10 )
	MobilesOnScreen.BlueLimit = Interface.LoadNumber("BlueLimit", 10 )
	MobilesOnScreen.RedLimit = Interface.LoadNumber("RedLimit", 10 )
	MobilesOnScreen.GreenLimit = Interface.LoadNumber("GreenLimit", 10 )
	MobilesOnScreen.OrangeLimit = Interface.LoadNumber("OrangeLimit", 10 )
	
	MobilesOnScreen.UpdateLimit = Interface.LoadNumber("MobilesOnScreenUpdateLimit", MobilesOnScreen.UpdateLimit )
	MobilesOnScreen.windowOffset = Interface.LoadNumber("MobilesOnScreenOffset", MobilesOnScreen.windowOffset )
	
	CreateWindowFromTemplate( "MobilesOnScreenOptionsWindowSubSectionFilters", "SubSectionLabelTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( "MobilesOnScreenOptionsWindowSubSectionFilters", "topleft", "MobilesOnScreenOptionsWindow", "topleft", 35, 12 )
	LabelSetText( "MobilesOnScreenOptionsWindowSubSectionFiltersLabel", GetStringFromTid( SettingsWindow.TID.Filter ) )

	for i = 2, table.getn(MobilesOnScreen.Filter) do
		local templatename = "FilterCheckButton_"..i
		CreateWindowFromTemplate( templatename, "Settings_LabelCheckButton", "MobilesOnScreenOptionsWindow" )
		ButtonSetCheckButtonFlag( templatename .. "Button", true )
		LabelSetText(templatename.."Label", MobilesOnScreen.Filter[i])
		if (i == 10) then
			LabelSetTextColor(templatename.."Label", NameColor.TextColors[NameColor.Notoriety.MURDERER].r, NameColor.TextColors[NameColor.Notoriety.MURDERER].g, NameColor.TextColors[NameColor.Notoriety.MURDERER].b)
		end
		if i < 9 then
			NameColor.UpdateLabelNameColor(templatename.."Label", i)
		end
		
		if (i == 2) then
			WindowAddAnchor(templatename, "topleft", "MobilesOnScreenOptionsWindowSubSectionFilters", "topleft", 0, 32)
		else
			WindowAddAnchor(templatename, "bottomleft", "FilterCheckButton_"..i-1, "topleft", 0, 12)
		end
	end
	
	CreateWindowFromTemplate( "MobilesOnScreenOptionsWindowSubSectionLimits", "SubSectionLabelTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( "MobilesOnScreenOptionsWindowSubSectionLimits", "topleft", "MobilesOnScreenOptionsWindow", "topleft", 35, 480 )
	LabelSetText( "MobilesOnScreenOptionsWindowSubSectionLimitsLabel", GetStringFromTid(1154806) )
	
	local templatename = "FilterCheckButton_"..table.getn(MobilesOnScreen.Filter)
	local barName =	"UnsortedLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "MobilesOnScreenOptionsWindowSubSectionLimits", "topleft", 0, 50 )
	LabelSetText( barName .. "Text", GetStringFromTid(1154807))
	
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.UnsortedLimit / 20)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.UnsortedLimit)
	
	barName =	"YellowLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "UnsortedLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text", GetStringFromTid(1154808))
	
	local c = NameColor.TextColors[NameColor.Notoriety.INVULNERABLE]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.YellowLimit / 20)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.YellowLimit)
	
	barName =	"GreyLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "YellowLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text", GetStringFromTid(1154809))
	
	local c = NameColor.TextColors[NameColor.Notoriety.CRIMINAL]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.GreyLimit / 20)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.GreyLimit)
	
	barName =	"BlueLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "GreyLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text", GetStringFromTid(1154810))
	
	local c = NameColor.TextColors[NameColor.Notoriety.INNOCENT]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.BlueLimit / 20)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.BlueLimit)
	
	barName =	"RedLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "BlueLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text",GetStringFromTid(1154811) )
	
	local c = NameColor.TextColors[NameColor.Notoriety.MURDERER]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.RedLimit / 20)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.RedLimit)
	
	barName =	"GreenLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "RedLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text",GetStringFromTid(1154812))
	
	local c = NameColor.TextColors[NameColor.Notoriety.FRIEND]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.GreenLimit / 20)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.GreenLimit)
	
	barName =	"OrangeLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "GreenLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text", GetStringFromTid(1154813))
	
	local c = NameColor.TextColors[NameColor.Notoriety.ENEMY]
	LabelSetTextColor(barName .. "Text",  c.r, c.g, c.b)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.OrangeLimit / 20)
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.OrangeLimit)
	
	CreateWindowFromTemplate( "MobilesOnScreenOptionsWindowSubSectionOthers", "SubSectionLabelTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( "MobilesOnScreenOptionsWindowSubSectionOthers", "topleft", "MobilesOnScreenOptionsWindow", "topleft", 35, 900 )
	LabelSetText( "MobilesOnScreenOptionsWindowSubSectionOthersLabel", GetStringFromTid(1154814) )
	
	barName =	"UpdateLimit"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "MobilesOnScreenOptionsWindowSubSectionOthers", "topleft", 0, 50 )
	LabelSetText( barName .. "Text",GetStringFromTid(1154815) )
	LabelSetTextColor(barName .. "Text", 255, 255, 255)
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.UpdateLimit )
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.UpdateLimit)
	
	barName =	"windowOffset"
	CreateWindowFromTemplate( barName, "SliderItemTemplate", "MobilesOnScreenOptionsWindow" )
	WindowAddAnchor( barName, "bottomleft", "UpdateLimit", "topleft", 0, 20 )
	LabelSetText( barName .. "Text",GetStringFromTid(1154816) )
	LabelSetTextColor(barName .. "Text", 255, 255, 255)
	
	SliderBarSetCurrentPosition(barName .. "SliderBar", MobilesOnScreen.windowOffset / 20 )
	LabelSetText( barName .. "Val", L"" .. MobilesOnScreen.windowOffset)
	
	MobilesOnScreen.ReloadFilterSettings()	
	MobilesOnScreen.ReloadSettings()
	
	local listOffset = ScrollWindowGetOffset("SettingsMobilesOnScreen")
	ScrollWindowUpdateScrollRect( "SettingsMobilesOnScreen" )   	
		local maxOffset = VerticalScrollbarGetMaxScrollPosition("SettingsMobilesOnScreen".."Scrollbar")
		if( listOffset > maxOffset ) then
		    listOffset = maxOffset
		end
		ScrollWindowSetOffset("SettingsMobilesOnScreen",listOffset)
	
	windowName ="YellowDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.INVULNERABLE]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , GetStringFromTid(1154817) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.YellowEnabled = Interface.LoadBoolean( "MobilesOnScreenYellowEnabled", false)
	if (MobilesOnScreen.YellowEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="GreyDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.CRIMINAL]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , GetStringFromTid(1154818) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.GreyEnabled = Interface.LoadBoolean( "MobilesOnScreenGreyEnabled", false)
	if (MobilesOnScreen.GreyEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="BlueDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.INNOCENT]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , GetStringFromTid(1154819) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.BlueEnabled = Interface.LoadBoolean( "MobilesOnScreenBlueEnabled", false)
	if (MobilesOnScreen.BlueEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="RedDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.MURDERER]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , GetStringFromTid(1154820))		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.RedEnabled = Interface.LoadBoolean( "MobilesOnScreenRedEnabled", false)
	if (MobilesOnScreen.RedEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="GreenDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.FRIEND]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" ,GetStringFromTid(1010562) )		
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	SnapUtils.SnappableWindows[windowName] = true
	MobilesOnScreen.GreenEnabled = Interface.LoadBoolean( "MobilesOnScreenGreenEnabled", false)
	if (MobilesOnScreen.GreenEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	windowName ="OrangeDockspot"
	local color = NameColor.TextColors[NameColor.Notoriety.ENEMY]
	CreateWindowFromTemplate( windowName, "DockPointTemplate", "Root" )
	WindowSetTintColor(windowName .. "ShowViewTitleBar", color.r, color.g, color.b)
	LabelSetText(windowName .."ShowViewName" , GetStringFromTid(1154821) )			
	WindowUtils.RestoreWindowPosition(windowName, false)
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(windowName .."ShowViewName" ,  "UO_DefaultText", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	MobilesOnScreen.OrangeEnabled = Interface.LoadBoolean( "MobilesOnScreenOrangeEnabled", false)
	SnapUtils.SnappableWindows[windowName] = true
	if (MobilesOnScreen.OrangeEnabled) then
		WindowSetShowing(windowName, true)
	else
		WindowSetShowing(windowName, false)
	end
	
	WindowUtils.RestoreWindowPosition("YellowDockspot", false)
	WindowUtils.RestoreWindowPosition("GreyDockspot", false)
	WindowUtils.RestoreWindowPosition("BlueDockspot", false)
	WindowUtils.RestoreWindowPosition("RedDockspot", false)
	WindowUtils.RestoreWindowPosition("GreenDockspot", false)
	WindowUtils.RestoreWindowPosition("OrangeDockspot", false)
	
	WindowSetScale("YellowDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("GreyDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("BlueDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("RedDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("GreenDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	WindowSetScale("OrangeDockspot", SystemData.Settings.Interface.customUiScale * 0.80)
	PetWindow.UpdatePet()
end

function MobilesOnScreen.GetVisible(ignoreMain)
	if (ignoreMain == nil) then
		ignoreMain = false
	end
	if (DoesWindowNameExist("YellowDockspot") and WindowGetShowing("YellowDockspot")) then
		return true
	end
	
	if (DoesWindowNameExist("GreyDockspot") and WindowGetShowing("GreyDockspot")) then
		return true
	end
	if (DoesWindowNameExist("BlueDockspot") and WindowGetShowing("BlueDockspot")) then
		return true
	end
	if (DoesWindowNameExist("RedDockspot") and WindowGetShowing("RedDockspot")) then
		return true
	end
	if (DoesWindowNameExist("GreenDockspot") and WindowGetShowing("GreenDockspot")) then
		return true
	end
	if (DoesWindowNameExist("OrangeDockspot") and WindowGetShowing("OrangeDockspot")) then
		return true
	end
	
	if (not MobilesOnScreen.Hidden and not ignoreMain) then
		return true
	end
	return false
end

function MobilesOnScreen.OnMouseDrag()
	if ( not MobilesOnScreen.locked) then
		SnapUtils.StartWindowSnap("MobilesOnScreenWindow")
	end
end
function MobilesOnScreen.Shutdown()

	MobilesOnScreen.SaveFilterSettings()
	WindowUtils.SaveWindowPosition("MobilesOnScreenWindow")
	WindowUtils.SaveWindowPosition("MobilesOnScreenOptionsWindow")	
	SnapUtils.SnappableWindows["MobilesOnScreenWindow"] = nil
	
	if MobilesOnScreen.YellowEnabled then
		WindowUtils.SaveWindowPosition("YellowDockspot")
	end
	if MobilesOnScreen.GreyEnabled then
		WindowUtils.SaveWindowPosition("GreyDockspot")
	end
	if MobilesOnScreen.BlueEnabled then
		WindowUtils.SaveWindowPosition("BlueDockspot")
	end
	if MobilesOnScreen.RedEnabled then
		WindowUtils.SaveWindowPosition("RedDockspot")
	end
	if MobilesOnScreen.GreenEnabled then
		WindowUtils.SaveWindowPosition("GreenDockspot")
	end
	if MobilesOnScreen.OrangeEnabled then
		WindowUtils.SaveWindowPosition("OrangeDockspot")
	end
end

function MobilesOnScreen.OnSlide( curPos )
	local bar = SystemData.ActiveWindow.name
	local barName = string.gsub(SystemData.ActiveWindow.name, "SliderBar", "")
	local barVal = 0
	if (barName == "UpdateLimit") then
		barVal =  tonumber(string.sub(tostring(SliderBarGetCurrentPosition(bar )),1, 4))
		LabelSetText(barName .. "Val", L"" .. barVal .. L"s")
	else
		barVal = math.floor( 20 * SliderBarGetCurrentPosition(bar ) )
		LabelSetText(barName .. "Val", L"" .. barVal)
	end
	
	if (barName == "UnsortedLimit") then
		MobilesOnScreen.UnsortedLimit = barVal
	elseif (barName == "YellowLimit") then
		MobilesOnScreen.YellowLimit = barVal
	elseif (barName == "GreyLimit") then
		MobilesOnScreen.GreyLimit = barVal
	elseif (barName == "BlueLimit") then
		MobilesOnScreen.BlueLimit = barVal
	elseif (barName == "RedLimit") then
		MobilesOnScreen.RedLimit = barVal
	elseif (barName == "GreenLimit") then
		MobilesOnScreen.GreenLimit = barVal
	elseif (barName == "OrangeLimit") then
		MobilesOnScreen.OrangeLimit = barVal
	elseif (barName == "UpdateLimit") then
		MobilesOnScreen.UpdateLimit = barVal
	elseif (barName == "windowOffset") then
		MobilesOnScreen.windowOffset = barVal
	end
	
end

function MobilesOnScreen.ReloadFilterSettings()
	--Reloads the Filter Settings and sets them in the Window
	-- None must be negative in order to work with the other filters
	MobilesOnScreen.SavedFilter[1] = false
	for i = 2, table.getn(MobilesOnScreen.Filter) do
		MobilesOnScreen.SavedFilter[i] = Interface.LoadBoolean( "MoSFilter"..i, true )
		ButtonSetPressedFlag("FilterCheckButton_"..i.."Button", MobilesOnScreen.SavedFilter[i]) 
	end
end

function MobilesOnScreen.UpdateFilterSettings()
	for i = 2, table.getn(MobilesOnScreen.Filter) do
		ButtonSetPressedFlag("FilterCheckButton_"..i.."Button", MobilesOnScreen.SavedFilter[i]) 
	end
	local defaultLimit = 20
	SliderBarSetCurrentPosition("UnsortedLimitSliderBar",  MobilesOnScreen.UnsortedLimit / defaultLimit )
	LabelSetText("UnsortedLimitVal", L"" .. MobilesOnScreen.UnsortedLimit )
	SliderBarSetCurrentPosition("YellowLimitSliderBar",  MobilesOnScreen.YellowLimit / defaultLimit )
	LabelSetText("YellowLimitVal", L"" .. MobilesOnScreen.YellowLimit )
	SliderBarSetCurrentPosition("GreyLimitSliderBar",  MobilesOnScreen.GreyLimit / defaultLimit )
	LabelSetText("GreyLimitVal", L"" .. MobilesOnScreen.GreyLimit )
	SliderBarSetCurrentPosition("BlueLimitSliderBar",  MobilesOnScreen.BlueLimit / defaultLimit )
	LabelSetText("BlueLimitVal", L"" .. MobilesOnScreen.BlueLimit )
	SliderBarSetCurrentPosition("RedLimitSliderBar",  MobilesOnScreen.RedLimit / defaultLimit )
	LabelSetText("RedLimitVal", L"" .. MobilesOnScreen.RedLimit )
	SliderBarSetCurrentPosition("GreenLimitSliderBar",  MobilesOnScreen.GreenLimit / defaultLimit )
	LabelSetText("GreenLimitVal", L"" .. MobilesOnScreen.GreenLimit )
	SliderBarSetCurrentPosition("OrangeLimitSliderBar",  MobilesOnScreen.OrangeLimit / defaultLimit )
	LabelSetText("OrangeLimitVal", L"" .. MobilesOnScreen.OrangeLimit )
	SliderBarSetCurrentPosition("UpdateLimitSliderBar",  MobilesOnScreen.UpdateLimit )
	LabelSetText("UpdateLimitVal", L"" .. MobilesOnScreen.UpdateLimit .. L"s")
	SliderBarSetCurrentPosition("windowOffsetSliderBar",  MobilesOnScreen.windowOffset / defaultLimit )
	LabelSetText("windowOffsetVal", L"" .. MobilesOnScreen.windowOffset )

end

function MobilesOnScreen.SaveFilterSettings()
	for i = 2, table.getn(MobilesOnScreen.Filter) do
		MobilesOnScreen.SavedFilter[i] = ButtonGetPressedFlag("FilterCheckButton_"..i.."Button") 
		Interface.SaveBoolean( "MoSFilter"..i, MobilesOnScreen.SavedFilter[i] )
	end
	
	if ( WindowGetShowing("BlueDockspot") and MobilesOnScreen.SavedFilter[2] == false) then
		WindowSetShowing("BlueDockspot", false)
		MobilesOnScreen.BlueEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenBlueEnabled", MobilesOnScreen.BlueEnabled  )
	end
	if (WindowGetShowing("GreenDockspot") and MobilesOnScreen.SavedFilter[3] == false) then
		WindowSetShowing("GreenDockspot", false)
		MobilesOnScreen.GreenEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenGreenEnabled", MobilesOnScreen.GreenEnabled  )
	end
	if (WindowGetShowing("GreyDockspot") and MobilesOnScreen.SavedFilter[4] == false and MobilesOnScreen.SavedFilter[5] == false) then
		WindowSetShowing("GreyDockspot", false)
		MobilesOnScreen.GreyEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenGreyEnabled", MobilesOnScreen.GreyEnabled  )
	end
	if (WindowGetShowing("OrangeDockspot") and MobilesOnScreen.SavedFilter[6] == false) then
		WindowSetShowing("OrangeDockspot", false)
		MobilesOnScreen.OrangeEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenOrangeEnabled", MobilesOnScreen.OrangeEnabled  )
	end
	if (WindowGetShowing("RedDockspot") and MobilesOnScreen.SavedFilter[7] == false) then
		WindowSetShowing("RedDockspot", false)
		MobilesOnScreen.RedEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenRedEnabled", MobilesOnScreen.RedEnabled  )
	end
	if (WindowGetShowing("YellowDockspot") and MobilesOnScreen.SavedFilter[8] == false) then
		WindowSetShowing("YellowDockspot", false)
		MobilesOnScreen.YellowEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenYellowEnabled", MobilesOnScreen.YellowEnabled  )
	end
	
	local defaultLimit = 20
	MobilesOnScreen.UnsortedLimit = math.floor( defaultLimit * SliderBarGetCurrentPosition("UnsortedLimitSliderBar" ) )

	MobilesOnScreen.YellowLimit = math.floor( defaultLimit * SliderBarGetCurrentPosition("YellowLimitSliderBar" ) )

	MobilesOnScreen.GreyLimit = math.floor( defaultLimit * SliderBarGetCurrentPosition("GreyLimitSliderBar" ) )

	MobilesOnScreen.BlueLimit = math.floor( defaultLimit * SliderBarGetCurrentPosition("BlueLimitSliderBar" ) )

	MobilesOnScreen.RedLimit = math.floor( defaultLimit * SliderBarGetCurrentPosition("RedLimitSliderBar" ) )

	MobilesOnScreen.GreenLimit = math.floor( defaultLimit * SliderBarGetCurrentPosition("GreenLimitSliderBar" ) )

	MobilesOnScreen.OrangeLimit = math.floor( defaultLimit * SliderBarGetCurrentPosition("OrangeLimitSliderBar" ) )

	MobilesOnScreen.UpdateLimit = tonumber(string.sub(tostring(SliderBarGetCurrentPosition("UpdateLimitSliderBar" )),1, 4))

	MobilesOnScreen.windowOffset = math.floor( defaultLimit * SliderBarGetCurrentPosition("windowOffsetSliderBar" ) )


	Interface.SaveNumber("UnsortedLimit", MobilesOnScreen.UnsortedLimit )
	Interface.SaveNumber("YellowLimit", MobilesOnScreen.YellowLimit )
	Interface.SaveNumber("GreyLimit", MobilesOnScreen.GreyLimit )
	Interface.SaveNumber("BlueLimit", MobilesOnScreen.BlueLimit )
	Interface.SaveNumber("RedLimit", MobilesOnScreen.RedLimit )
	Interface.SaveNumber("GreenLimit", MobilesOnScreen.GreenLimit )
	Interface.SaveNumber("OrangeLimit", MobilesOnScreen.OrangeLimit )
	Interface.SaveNumber("MobilesOnScreenUpdateLimit", MobilesOnScreen.UpdateLimit )
	Interface.SaveNumber("MobilesOnScreenOffset", MobilesOnScreen.windowOffset )
	
	MobileHealthBar.Forced = true
	for mob, value in pairs(MobileHealthBar.hasWindow) do
		if (MobilesOnScreen.IsPet(mob)) then
			continue
		end
		if (MobileHealthBar.hasWindow[mob]) then
			continue
		end
		if (not MobileHealthBar.Handled[mob]) then
			if (MobilesOnScreen.UnSorted[mob] or MobilesOnScreen.MobilesYellow[mob] or 	MobilesOnScreen.MobilesGrey[mob] or	MobilesOnScreen.MobilesBlue[mob] or	MobilesOnScreen.MobilesRed[mob] or	MobilesOnScreen.MobilesGreen[mob] or	MobilesOnScreen.MobilesOrange[mob] ) then
				
				MobileHealthBar.CloseWindowByMobileId(mob)
				MobileHealthBar.Handled[mob] = false
			end
		end
	end
	MobileHealthBar.Forced = nil
	MobilesOnScreen.UnsortedWindows = 0
	MobilesOnScreen.YellowWindows = 0
	MobilesOnScreen.GreyWindows = 0
	MobilesOnScreen.BlueWindows = 0
	MobilesOnScreen.RedWindows = 0
	MobilesOnScreen.GreenWindows = 0
	MobilesOnScreen.OrangeWindows = 0
	MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.OnFilterOkayButton()
	WindowSetShowing("MobilesOnScreenOptionsWindow", false)
end

function MobilesOnScreen.OnFilterHidden()
	MobilesOnScreen.SaveFilterSettings()
	-- Clears the whole MoS table
	MobilesOnScreen.Refilter()
end


function MobilesOnScreen.Refilter()
		MobilesOnScreen.Clear()

		MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.Sort()
	
	for mobileId, value in pairs(MobileHealthBar.hasWindow) do
		if not MobileHealthBar.hasWindow[mobileId] then
			continue
		end
		if (MobilesOnScreen.IsPet(mobileId)) then
			continue
		end
		MobilesOnScreen.AddHealthbar(mobileId)
	end
			
	MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.Clear()
	for nn, mob in pairs(MobilesOnScreen.MobilesSort) do
		if (MobilesOnScreen.IsPet(mob)) then
			continue
		end
		local windowName = "MobileHealthBar_"..mob
		if (not MobileHealthBar.Handled[mob] and DoesWindowExist(windowName)) then
			MobileHealthBar.CloseWindowByMobileId(mob)
		end
	end
	
	MobileHealthBar.Forced = nil
	MobilesOnScreen.UnsortedWindows = 0
	MobilesOnScreen.YellowWindows = 0
	MobilesOnScreen.GreyWindows = 0
	MobilesOnScreen.BlueWindows = 0
	MobilesOnScreen.RedWindows = 0
	MobilesOnScreen.GreenWindows = 0
	MobilesOnScreen.OrangeWindows = 0
	
	MobilesOnScreen.UnSorted = {}
	MobilesOnScreen.MobilesYellow = {}
	MobilesOnScreen.MobilesGrey = {}
	MobilesOnScreen.MobilesBlue = {}
	MobilesOnScreen.MobilesRed = {}
	MobilesOnScreen.MobilesGreen = {}
	MobilesOnScreen.MobilesOrange = {}

	MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.ShowPetToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154827))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	WindowSetAlpha(SystemData.ActiveWindow.name,1)
end

function MobilesOnScreen.ShowPetToolTipEnd()
	WindowSetAlpha(SystemData.ActiveWindow.name,0.5)
end

function MobilesOnScreen.HidePetToolTip()
	Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1154828))
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
	WindowSetAlpha(SystemData.ActiveWindow.name,1)
end

function MobilesOnScreen.HidePetToolTipEnd()
	WindowSetAlpha(SystemData.ActiveWindow.name,0.5)
end

function MobilesOnScreen.IsPet(mobileId)
	local mobileData = Interface.GetMobileData(mobileId, false)
	if not mobileData then
		return false
	end
	if (MobilesOnScreen.ReversePet[mobileId] ~= nil or (mobileData and mobileData.MyPet)) then
		return true
	end
	return false
end

function MobilesOnScreen.IsFarm(name)
	if (name == nil or name == L"" or name == "") then
		return false
	end
	local convName = string.gsub(WStringToString(name), "^%s*(.-)%s*$", "%1")
	convName = string.lower(convName)
	if (MobilesOnScreen.FarmNames[convName]) then
		return true
	end
	return false
end

function MobilesOnScreen.IgnoredMobile(name)
	if (name == nil or name == L"" or name == "") then
		return true
	end
	return wstring.find(name, L"A Mannequin") ~= nil or wstring.find(name, L"The Parrot") ~= nil
end

function MobilesOnScreen.IsSummon(name, mobileId)
	if (name == nil or name == L"" or name == "") then
		return false
	end
	if type(name) == "wstring" then 
		name = WStringToString(name)
	end
	if name and mobileId then
		if MobilesOnScreen.IsPet(mobileId) then --only for personal summons			
			local summonNameFix = string.gsub(name, "^%s*(.-)%s*$","%1")
			summonNameFix = string.lower(summonNameFix)
			local org_summonNameFix = string.lower(summonNameFix)			
			if summonNameFix == "a revenant" then	
				if Interface.LastSpell ~= 114 then 
					return false
				end				
			elseif summonNameFix == "an energy vortex" then	
				if Interface.LastSpell ~= 58 then 
					return false
				end
			elseif summonNameFix == "a blade spirit" then	
				if Interface.LastSpell ~= 33 then 
					return false
				end
			elseif summonNameFix == "an earth elemental" then
				if Interface.LastSpell ~= 62 then 
					return false
				end
			elseif summonNameFix == "an air elemental" then
				if Interface.LastSpell ~= 60 then 
					return false
				end	
			elseif summonNameFix == "a water elemental" then
				if Interface.LastSpell ~= 64 then 
					return false
				end	
			elseif summonNameFix == "a fire elemental" then	
				if Interface.LastSpell ~= 63 then 
					return false
				end
			elseif summonNameFix == "a rising colossus" then	
				if Interface.LastSpell ~= 693 then 
					return false
				end
			elseif summonNameFix == "an animated weapon" then
				if Interface.LastSpell ~= 684 then 
					return false
				end
			
			elseif summonNameFix == "a nature's fury" then	
				if Interface.LastSpell ~= 606 then 
					return false
				end			
			elseif summonNameFix == "an imp"  then	
				if Interface.LastSpell ~= 608 then 
					return false
				end		
			end	
			if not CreaturesDB.SummonTimes[summonNameFix] or Interface.LastSpell == 40 then
				if Interface.LastSpell == 607 then
					if (CreaturesDB.IsPixie(summonNameFix)) then
						summonNameFix="fey"
					end
				end				
				if Interface.LastSpell == 40 then
					summonNameFix="summon creature"
				end				
				if Interface.LastSpell == 61 then
					if (CreaturesDB.IsDaemon(summonNameFix)) and not CreaturesDB.SummonTimes[summonNameFix] then
						summonNameFix="daemon"
					end
				end				
				local PlayerName = tostring(wstring.lower(wstring.trim(WindowData.MobileName[WindowData.PlayerStatus.PlayerId].MobName)))
				local props = ItemProperties.GetObjectProperties( mobileId, nil, "Mobiles on screen - check summon")
				if Interface.LastSpell == 508 then
					if string.find(PlayerName, summonNameFix) and (not props or #props == 1) and not CreaturesDB.SummonTimes[summonNameFix] then
						summonNameFix = "mirror image"
					end
				end
				if WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId] then
					local taliId = WindowData.Paperdoll[WindowData.PlayerStatus.PlayerId][12].slotId
					if taliId ~= 0 and Interface.LastItem == taliId then
						if not string.find(PlayerName, summonNameFix) and (not props or #props == 1) and not CreaturesDB.SummonTimes[summonNameFix]  then
							summonNameFix = "talisman summon"
						end
					end
				end				
			end
			if CreaturesDB.SummonTimes[summonNameFix] then
				return true, summonNameFix
			end
		end
	end
	local convName = ""
	if (type(name) == "wstring") then
		convName =string.gsub(tostring(name), "^%s*(.-)%s*$", "%1")
	else
		convName =string.gsub(name, "^%s*(.-)%s*$", "%1")
	end
	convName = string.lower(convName)
				
	if (MobilesOnScreen.Summons[convName]) then
		return true, convName
	end
	return false
end

function MobilesOnScreen.AddHealthbar(mobileId)
	local data = WindowData.MobileName[mobileId]
	if (data) then
		local passa = true
		
		if (not MobilesOnScreen.SavedFilter[9] and MobilesOnScreen.IsFarm(data.MobName)) then
			passa = false
		end
		if (not MobilesOnScreen.SavedFilter[10] and MobilesOnScreen.IsSummon(data.MobName, mobileId)) then
			passa = false
		end
		if (not MobilesOnScreen.IsPet(mobileId) and MobilesOnScreen.GetVisible() and not MobileHealthBar.windowDisabled[mobileId] and IsMobile(mobileId) and passa) then			
			local noto = data.Notoriety+1
			if (not MobilesOnScreen.SavedFilter[noto]) then
				return false
			end			
			local added = false
			if (( noto == NameColor.Notoriety.NONE or noto == NameColor.Notoriety.CANATTACK or noto == NameColor.Notoriety.CRIMINAL) and DoesWindowNameExist("GreyDockspot") and WindowGetShowing("GreyDockspot")) then
				if (table.getn(MobilesOnScreen.MobilesGrey) < MobilesOnScreen.GreyLimit) then
					table.insert(MobilesOnScreen.MobilesGrey,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.INNOCENT and DoesWindowNameExist("BlueDockspot") and WindowGetShowing("BlueDockspot")) then
				if ( table.getn(MobilesOnScreen.MobilesBlue) < MobilesOnScreen.BlueLimit) then
					table.insert(MobilesOnScreen.MobilesBlue,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.FRIEND  and DoesWindowNameExist("GreenDockspot") and WindowGetShowing("GreenDockspot")) then
				if (table.getn(MobilesOnScreen.MobilesGreen) < MobilesOnScreen.GreenLimit) then
					table.insert(MobilesOnScreen.MobilesGreen,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.ENEMY and DoesWindowNameExist("OrangeDockspot") and WindowGetShowing("OrangeDockspot")) then
				if (table.getn(MobilesOnScreen.MobilesOrange) < MobilesOnScreen.OrangeLimit) then
					table.insert(MobilesOnScreen.MobilesOrange,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.MURDERER and DoesWindowNameExist("RedDockspot") and WindowGetShowing("RedDockspot")) then
				if ( table.getn(MobilesOnScreen.MobilesRed) < MobilesOnScreen.RedLimit) then
					table.insert(MobilesOnScreen.MobilesRed,mobileId)
					added = true
				end
			elseif ( noto == NameColor.Notoriety.INVULNERABLE and DoesWindowNameExist("YellowDockspot") and WindowGetShowing("YellowDockspot")) then
				if (table.getn(MobilesOnScreen.MobilesYellow) < MobilesOnScreen.YellowLimit) then
					table.insert(MobilesOnScreen.MobilesYellow,mobileId)
					added = true
				end
			elseif ( not MobilesOnScreen.Hidden and MobilesOnScreen.SavedFilter[noto] and table.getn(MobilesOnScreen.UnSorted) < MobilesOnScreen.UnsortedLimit) then
				table.insert(MobilesOnScreen.UnSorted,mobileId)
				added = true
			end
			return added
		end
	end
	return false
end

function MobilesOnScreen.RemoveHealthBar(mobileId)
	MobileHealthBar.CloseWindowByMobileId(mobileId)
end

function MobilesOnScreen.SlowUpdate(timePassed)
	MobilesOnScreen.delta = MobilesOnScreen.delta + timePassed	
	if (MobilesOnScreen.delta > MobilesOnScreen.UpdateLimit or MobilesOnScreen.AnchorUpdateRequest) then
		MobilesOnScreen.UpdateAnchors()
		PetWindow.UpdatePet()
	end
end

function MobilesOnScreen.HandleAnchors()	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.UnsortedWindows = 0	
	for i=1, table.getn(MobilesOnScreen.UnSorted) do
		local mob = MobilesOnScreen.UnSorted[i]

		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] == true or not WindowGetShowing(windowName)) then
			continue
		end
		if (i <= MobilesOnScreen.UnsortedLimit+1) then
			bars = bars + 1
			MobilesOnScreen.UnsortedWindows = MobilesOnScreen.UnsortedWindows + 1
			-- anchor management
			local parent = "MobilesOnScreenWindow"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.UnSorted[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)
			if ( bars == 1 ) then				
				WindowAddAnchor(windowName, "bottomleft", showName .. "TitleBar", "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end			
			unsortedPrev = mob
		end
	end

	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.YellowWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesYellow) do
		local mob = MobilesOnScreen.MobilesYellow[i]
		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] == true or not WindowGetShowing(windowName)) then
			continue
		end
		if (i <= MobilesOnScreen.YellowLimit+1) then
			bars = bars + 1
			MobilesOnScreen.YellowWindows = MobilesOnScreen.YellowWindows + 1
			-- anchor management
			local parent = "YellowDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesYellow[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end

	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.GreyWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesGrey) do
		local mob = MobilesOnScreen.MobilesGrey[i]
		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] == true or not WindowGetShowing(windowName)) then
			continue
		end

		if (i <= MobilesOnScreen.GreyLimit+1) then
			bars = bars + 1
			MobilesOnScreen.GreyWindows = MobilesOnScreen.GreyWindows + 1
			-- anchor management
			local parent = "GreyDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesGrey[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.BlueWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesBlue) do
		local mob = MobilesOnScreen.MobilesBlue[i]

		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] == true or not WindowGetShowing(windowName)) then
			continue
		end
		
		if (i <= MobilesOnScreen.BlueLimit+1) then
			bars = bars + 1
			MobilesOnScreen.BlueWindows = MobilesOnScreen.BlueWindows + 1
			-- anchor management
			local parent = "BlueDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesBlue[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.RedWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesRed) do
		local mob = MobilesOnScreen.MobilesRed[i]

		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] == true or not WindowGetShowing(windowName)) then
			continue
		end
		
		if (i <= MobilesOnScreen.RedLimit+1) then
			bars = bars + 1
			MobilesOnScreen.RedWindows = MobilesOnScreen.RedWindows + 1
			-- anchor management
			local parent = "RedDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesRed[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.GreenWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesGreen) do
		local mob = MobilesOnScreen.MobilesGreen[i]

		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] == true or not WindowGetShowing(windowName)) then
			continue
		end
		
		if (i <= MobilesOnScreen.GreenLimit+1) then
			bars = bars + 1
			MobilesOnScreen.GreenWindows = MobilesOnScreen.GreenWindows + 1
			-- anchor management
			local parent = "GreenDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesGreen[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
	local bars = 0
	local unsortedPrev = 0
	MobilesOnScreen.OrangeWindows = 0
	for i=1, table.getn(MobilesOnScreen.MobilesOrange) do
		local mob = MobilesOnScreen.MobilesOrange[i]
		local windowName = "MobileHealthBar_"..mob
		if (not DoesWindowNameExist(windowName) or MobileHealthBar.Handled[mob] == true or not WindowGetShowing(windowName)) then
			continue
		end
		i = i +1
		
		if (i <= MobilesOnScreen.OrangeLimit+1) then
			bars = bars + 1
			MobilesOnScreen.OrangeWindows = MobilesOnScreen.OrangeWindows + 1
			-- anchor management
			local parent = "OrangeDockspot"
			local showName = parent.."ShowView"
			local windowPrev = "MobileHealthBar_"..unsortedPrev
			if not DoesWindowNameExist(windowPrev) and i > 1 then
				local found = false
				for j = i-1, 1, -1 do
					windowPrev = "MobileHealthBar_"..MobilesOnScreen.MobilesOrange[j]
					if not DoesWindowNameExist(windowPrev) then
						found = true
						break
					end
				end
				if not found then
					windowPrev = showName.."TitleBar"
				end
			end
			WindowClearAnchors(windowName)

			if ( bars == 1 ) then
				WindowAddAnchor(windowName, "bottomleft", showName, "topleft", 0, 0 )
			else
				WindowAddAnchor(windowName, "bottomleft", windowPrev, "topleft", 0, MobilesOnScreen.windowOffset )
			end
			unsortedPrev = mob
		end
	end
	
end

function MobilesOnScreen.SortByDistance()
	local pos = 1
	while pos < #MobilesOnScreen.MobilesSort do
		if (pos == 1 or GetDistanceFromPlayer(MobilesOnScreen.MobilesSort[pos]) >= GetDistanceFromPlayer(MobilesOnScreen.MobilesSort[pos-1])) then
			pos = pos + 1
		else
			local swap = MobilesOnScreen.MobilesSort[pos]
			MobilesOnScreen.MobilesSort[pos] = MobilesOnScreen.MobilesSort[pos-1]
			MobilesOnScreen.MobilesSort[pos-1] = swap
			pos = pos - 1
		end
	end
	MobileHealthBar.CloseAllHealthbars(true)
end

function MobilesOnScreen.UpdateAnchors()
	if (Interface.TimeSinceLogin < 1) then
		return
	end
	if (MobilesOnScreen.delta < MobilesOnScreen.UpdateLimit) then
		MobilesOnScreen.AnchorUpdateRequest = true
		return
	end
	MobilesOnScreen.delta = 0
	MobilesOnScreen.AnchorUpdateRequest = false
	
	MobilesOnScreen.UnSorted = {}
	MobilesOnScreen.MobilesYellow = {}
	MobilesOnScreen.MobilesGrey = {}
	MobilesOnScreen.MobilesBlue = {}
	MobilesOnScreen.MobilesRed = {}
	MobilesOnScreen.MobilesGreen = {}
	MobilesOnScreen.MobilesOrange = {}	
	
	if (MobilesOnScreen.DistanceSort) then
		MobilesOnScreen.SortByDistance()
	end
	
	for i, mobileId in pairsByKeys(MobilesOnScreen.MobilesSort) do
		-- ignoring: extracted bars, pets, not mobiles, disabled healthbars

		if (not mobileId or MobileHealthBar.Handled[mobileId] == true or MobilesOnScreen.IsPet(mobileId)) then
			if not DoesWindowNameExist("MobileHealthBar_"..mobileId) then
				UnregisterWindowData(WindowData.MobileName.Type, mobileId)
			end
			continue
		end

		if ( not IsMobile(mobileId) or MobileHealthBar.windowDisabled[mobileId]) then
			MobilesOnScreen.RemoveHealthBar(mobileId)
			continue
		end
		RegisterWindowData(WindowData.MobileName.Type, mobileId)
		local data = WindowData.MobileName[mobileId]
		if (not data) then -- missing data
			MobilesOnScreen.RemoveHealthBar(mobileId)
			continue
		end
		-- and not wstring.find(wstring.lower(data.MobName), wstring.lower(MobilesOnScreen.STRFilter))
		if (MobilesOnScreen.STRFilter ~= "" ) then -- filter
			local found = false
			for cf in wstring.gmatch(MobilesOnScreen.STRFilter, L"[^|]+") do
				if (wstring.find(wstring.lower(data.MobName), wstring.lower(cf))) then
					found = true
				end
			end
			if (not found ) then
				MobilesOnScreen.RemoveHealthBar(mobileId)
				continue
			end
		end
		
		local windowName = "MobileHealthBar_"..mobileId
		
		local isVisible = GetDistanceFromPlayer(mobileId) < 22
				
		if (not isVisible) then
			if (DoesWindowNameExist(windowName)) then
				MobilesOnScreen.RemoveHealthBar(mobileId)
			end
			continue
		end
		local noto = data.Notoriety+1
		-- let's check if the filters allow this mobile
		local added = false
		if not MobilesOnScreen.IgnoredMobile(data.MobName) then
			added = MobilesOnScreen.AddHealthbar(mobileId)
		end
		if (added and not DoesWindowNameExist(windowName)) then
			MobileHealthBar.Forced = true
			MobileHealthBar.CreateHealthBar(mobileId)
			MobileHealthBar.Forced = nil
		elseif (not added) then
			MobilesOnScreen.RemoveHealthBar(mobileId)
		end		
	end	
	MobilesOnScreen.HandleAnchors()	
end	

function MobilesOnScreen.Dockspot_OnLButtonUp()
	WindowSetMoving(WindowUtils.GetActiveDialog(),false)
end

function MobilesOnScreen.Dockspot_OnLButtonDown()
	if (not MobilesOnScreen.Dockspotlocked) then
		WindowSetMoving(WindowUtils.GetActiveDialog(),true)
		SnapUtils.StartWindowSnap(WindowUtils.GetActiveDialog())
	end
end

function MobilesOnScreen.HidePet()
	local windowName = "MobilesOnScreenWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	WindowSetAlpha(hideName .. "ShowButton",0.5)
	WindowSetAlpha(hideName .. "ShowButtonR",0.5)
	
	WindowSetShowing(showName, false)
	WindowSetShowing(hideName, true)
	
	SnapUtils.SnappableWindows[showName] = nil
	
	MobilesOnScreen.Hidden = true
	Interface.SaveBoolean( "MobilesOnScreenWindowVisible", false )
	
	if (not MobilesOnScreen.GetVisible()) then
		MobilesOnScreen.Clear()
	else
		for mob, value in pairs(MobileHealthBar.Handled) do
			if (MobilesOnScreen.IsPet(mob)) then
				continue
			end
			if (MobilesOnScreen.UnSorted[mob] and not MobileHealthBar.Handled[mob]) then
				MobileHealthBar.CloseWindowByMobileId(mob)
				MobilesOnScreen.UnSorted[mob] = nil
				MobilesOnScreen.UnsortedWindows = MobilesOnScreen.UnsortedWindows -1
			end
		end
		MobilesOnScreen.UpdateAnchors()
	end
end

function MobilesOnScreen.ShowPet()
	local windowName = "MobilesOnScreenWindow"
	local showName = windowName.."ShowView"
	local hideName = windowName.."HideView"
	
	WindowSetAlpha(showName .. "HideButton",0.5)
	WindowSetAlpha(showName .. "HideButtonR",0.5)
	
	WindowSetShowing(showName, true)
	WindowSetShowing(hideName, false)
	
	SnapUtils.SnappableWindows[showName] = true
	
	MobilesOnScreen.Hidden = false
	Interface.SaveBoolean( "MobilesOnScreenWindowVisible", true )
	MobilesOnScreen.UpdateAnchors()
end

function MobilesOnScreen.HideAll()
	local windowName = "MobilesOnScreenWindow"
	WindowSetShowing(windowName, false)
end

function MobilesOnScreen.ShowWindow()
	local windowName = "MobilesOnScreenWindow"
	WindowSetShowing(windowName, true)
end

function MobilesOnScreen.LockTooltip()
	local windowname = WindowUtils.GetActiveDialog()

	if ( MobilesOnScreen.locked  ) then
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111696))
	else
		Tooltips.CreateTextOnlyTooltip(SystemData.ActiveWindow.name, GetStringFromTid(1111697))
	end
	
	Tooltips.Finalize()
	Tooltips.AnchorTooltip( Tooltips.ANCHOR_WINDOW_TOP )
end

function MobilesOnScreen.LockMe()
	local windowname = "MobilesOnScreenWindow"
		
	MobilesOnScreen.locked = not MobilesOnScreen.locked
	Interface.SaveBoolean( "LockMobilesOnScreen", MobilesOnScreen.locked )
	WindowSetMovable(windowname, not MobilesOnScreen.locked )
	
	local texture = "UO_Core"
	if ( MobilesOnScreen.locked) then		
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end

end


function MobilesOnScreen.Lock()
	local windowname = WindowGetId(WindowUtils.GetActiveDialog())
	if  MobilesOnScreen.Hidden then
		if(MobilesOnScreen.locked) then
			ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1111696),0,"Lock",1,false)
		else
		   ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1111697),0,"Lock",1,false)
		end
	end
	
	if(MobilesOnScreen.DistanceSort) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154829),0,"ToggleSortDistance",1,false)
	else
	   ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154830),0,"ToggleSortDistance",1,false)
	end
	
	local enabled = 0
	if (not MobilesOnScreen.GetVisible(true)) then
		enabled = 1
	end

	if(MobilesOnScreen.Dockspotlocked) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154831),enabled,"Lockdockspot",1,false)
	else
	   ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154832),enabled,"Lockdockspot",1,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[8] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.YellowEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154833),enabled,"yellowDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154834),enabled,"yellowDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[4] == false and MobilesOnScreen.SavedFilter[5] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.GreyEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154835),enabled,"greyDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154836),enabled,"greyDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[2] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.BlueEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154837),enabled,"blueDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154838),enabled,"blueDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[7] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.RedEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154839),enabled,"redDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154840),enabled,"redDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[3] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.GreenEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154841),enabled,"greenDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154842),enabled,"greenDockspotOff",2,false)
	end
	
	enabled = 0
	if (MobilesOnScreen.SavedFilter[6] == false) then
		enabled = 1
	end
	
	if (not MobilesOnScreen.OrangeEnabled) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154843),enabled,"orangeDockspotOn",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154844),enabled,"orangeDockspotOff",2,false)
	end
	
	
	if (MobilesOnScreen.CloseLeft) then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154845),0,"closeRight",2,false)
	else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154846),0,"closeLeft",2,false)
	end

	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"nil",2, false)
    
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154847),0,"reset",2,false)
	ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154848),0,"clear",2,false)
	
	ContextMenu.CreateLuaContextMenuItemWithString(L"",0,"nil",2, false)
	
	if (MobilesOnScreen.STRFilter == "") then
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1062476),0,"setfilter",2, false)
    else
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154850),0,"addfilter",2, false)
		ContextMenu.CreateLuaContextMenuItemWithString(GetStringFromTid(1154849),0,"removefilter",2, false)
    end
	ContextMenu.ActivateLuaContextMenu(MobilesOnScreen.ContextMenuCallback)
end

function MobilesOnScreen.ButtonRotation()
	local showName = "MobilesOnScreenWindowShowView"
	local hideName = "MobilesOnScreenWindowHideView"
		
	if MobilesOnScreen.CloseLeft then
		WindowSetShowing(showName .. "HideButtonR", false)
		WindowSetShowing(showName .. "HideButton", true)
		WindowSetShowing(hideName .. "ShowButtonR", false)
		WindowSetShowing(hideName .. "ShowButton", true)
		WindowClearAnchors(hideName .. "Name")
		WindowAddAnchor(hideName .. "Name", "bottomleft", hideName, "topleft", 10, -20)
	else
		WindowSetShowing(showName .. "HideButtonR", true)
		WindowSetShowing(showName .. "HideButton", false)
		WindowSetShowing(hideName .. "ShowButtonR", true)
		WindowSetShowing(hideName .. "ShowButton", false)
		WindowClearAnchors(hideName .. "Name")

		WindowAddAnchor(hideName .. "Name", "bottomright", hideName, "topright", 0, -20)
	end
end

function MobilesOnScreen.SetFilter(j, newval)	
	if j == 2 then
		MobilesOnScreen.STRFilter = newval
	elseif j == 3 then
		MobilesOnScreen.STRFilter = MobilesOnScreen.STRFilter .. L"|" .. newval
	end
end

function MobilesOnScreen.ContextMenuCallback( returnCode, param )
	local windowName = "MobilesOnScreenWindow"
	if ( returnCode=="Lock" ) then
		MobilesOnScreen.locked = not MobilesOnScreen.locked
		Interface.SaveBoolean( "LockMobilesOnScreen", MobilesOnScreen.locked )
		WindowSetMovable(windowName, not MobilesOnScreen.locked )
	end
	if ( returnCode=="Lockdockspot" ) then
		MobilesOnScreen.Dockspotlocked = not MobilesOnScreen.Dockspotlocked
		Interface.SaveBoolean( "DockspotlockedMobilesOnScreen", MobilesOnScreen.Dockspotlocked )
		WindowSetMovable(windowName, not MobilesOnScreen.Dockspotlocked )
	end
	if ( returnCode=="reset" ) then
		WindowClearAnchors(windowName)
		WindowAddAnchor(windowName,"topleft","Root","topleft",0,100)
	end
	
	if (returnCode == "setfilter") then
		local rdata = {title=GetStringFromTid(1062476), subtitle=GetStringFromTid(1154851), callfunction=MobilesOnScreen.SetFilter, id=2}
		RenameWindow.Create(rdata)
	elseif (returnCode == "addfilter") then
		local rdata = {title=GetStringFromTid(1062476), subtitle=GetStringFromTid(1154851), callfunction=MobilesOnScreen.SetFilter, id=3}
		RenameWindow.Create(rdata)
	elseif (returnCode == "removefilter") then
		MobilesOnScreen.STRFilter = ""
	end
	
	if ( returnCode=="ToggleSortDistance" ) then
		MobilesOnScreen.DistanceSort = not MobilesOnScreen.DistanceSort
		Interface.SaveBoolean( "MobilesOnScreenDistanceSort", MobilesOnScreen.DistanceSort  )
	end	
	if ( returnCode=="closeRight" ) then
		MobilesOnScreen.CloseLeft = false
		Interface.SaveBoolean( "MobilesOnScreenCloseLeft", MobilesOnScreen.CloseLeft  )
		WindowClearAnchors("MobilesOnScreenWindowHideView")
		WindowAddAnchor("MobilesOnScreenWindowHideView", "topright", "MobilesOnScreenWindow", "topright", 0, 0 )
		MobilesOnScreen.ButtonRotation()
	elseif ( returnCode=="closeLeft" ) then
		MobilesOnScreen.CloseLeft = true 
		Interface.SaveBoolean( "MobilesOnScreenCloseLeft", MobilesOnScreen.CloseLeft  )
		WindowClearAnchors("MobilesOnScreenWindowHideView")
		WindowAddAnchor("MobilesOnScreenWindowHideView", "topleft", "MobilesOnScreenWindow", "topleft", 0, 0 )
		MobilesOnScreen.ButtonRotation()
	end	
	if ( returnCode=="yellowDockspotOn" ) then
		MobilesOnScreen.YellowEnabled = true
		Interface.SaveBoolean( "MobilesOnScreenYellowEnabled", MobilesOnScreen.YellowEnabled  )
		DockSpotFirstAnchoring("YellowDockspot")
		WindowSetShowing("YellowDockspot", MobilesOnScreen.YellowEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="yellowDockspotOff" ) then
		MobilesOnScreen.YellowEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenYellowEnabled", MobilesOnScreen.YellowEnabled  )
		WindowSetShowing("YellowDockspot", MobilesOnScreen.YellowEnabled)
		MobilesOnScreen.Sort()
	end	
	if ( returnCode=="greyDockspotOn" ) then
		MobilesOnScreen.GreyEnabled = true
		Interface.SaveBoolean( "MobilesOnScreenGreyEnabled", MobilesOnScreen.GreyEnabled  )
		DockSpotFirstAnchoring("GreyDockspot")
		WindowSetShowing("GreyDockspot", MobilesOnScreen.GreyEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="greyDockspotOff" ) then
		MobilesOnScreen.GreyEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenGreyEnabled", MobilesOnScreen.GreyEnabled  )
		WindowSetShowing("GreyDockspot", MobilesOnScreen.GreyEnabled)
		MobilesOnScreen.Sort()
	end	
	if ( returnCode=="blueDockspotOn" ) then
		MobilesOnScreen.BlueEnabled = true
		Interface.SaveBoolean( "MobilesOnScreenBlueEnabled", MobilesOnScreen.BlueEnabled  )
		DockSpotFirstAnchoring("BlueDockspot")
		WindowSetShowing("BlueDockspot", MobilesOnScreen.BlueEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="blueDockspotOff" ) then
		MobilesOnScreen.BlueEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenBlueEnabled", MobilesOnScreen.BlueEnabled  )
		WindowSetShowing("BlueDockspot", MobilesOnScreen.BlueEnabled)
		MobilesOnScreen.Sort()
	end	
	if ( returnCode=="redDockspotOn" ) then
		MobilesOnScreen.RedEnabled = true
		Interface.SaveBoolean( "MobilesOnScreenRedEnabled", MobilesOnScreen.RedEnabled  )
		DockSpotFirstAnchoring("RedDockspot")
		WindowSetShowing("RedDockspot", MobilesOnScreen.RedEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="redDockspotOff" ) then
		MobilesOnScreen.RedEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenRedEnabled", MobilesOnScreen.RedEnabled  )
		WindowSetShowing("RedDockspot", MobilesOnScreen.RedEnabled)
		MobilesOnScreen.Sort()
	end	
	if ( returnCode=="greenDockspotOn" ) then
		MobilesOnScreen.GreenEnabled = true
		Interface.SaveBoolean( "MobilesOnScreenGreenEnabled", MobilesOnScreen.GreenEnabled  )
		DockSpotFirstAnchoring("GreenDockspot")
		WindowSetShowing("GreenDockspot", MobilesOnScreen.GreenEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="greenDockspotOff" ) then
		MobilesOnScreen.GreenEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenGreenEnabled", MobilesOnScreen.GreenEnabled  )
		WindowSetShowing("GreenDockspot", MobilesOnScreen.GreenEnabled)
		MobilesOnScreen.Sort()
	end	
	if ( returnCode=="orangeDockspotOn" ) then
		MobilesOnScreen.OrangeEnabled = true
		Interface.SaveBoolean( "MobilesOnScreenOrangeEnabled", MobilesOnScreen.OrangeEnabled  )
		DockSpotFirstAnchoring("OrangeDockspot")
		WindowSetShowing("OrangeDockspot", MobilesOnScreen.OrangeEnabled)
		MobilesOnScreen.Sort()
	end
	if ( returnCode=="orangeDockspotOff" ) then
		MobilesOnScreen.OrangeEnabled = false
		Interface.SaveBoolean( "MobilesOnScreenOrangeEnabled", MobilesOnScreen.OrangeEnabled  )
		WindowSetShowing("OrangeDockspot", MobilesOnScreen.OrangeEnabled)
		MobilesOnScreen.Sort()
	end	
	if ( returnCode=="clear" ) then
		MobilesOnScreen.Clear()
	end
end

function MobilesOnScreen.ReloadSettings()
	MobilesOnScreen.locked = Interface.LoadBoolean( "LockMobilesOnScreen", MobilesOnScreen.locked)
	MobilesOnScreen.Dockspotlocked = Interface.LoadBoolean( "DockspotlockedMobilesOnScreen", false )
	WindowSetMovable("MobilesOnScreenWindow", not MobilesOnScreen.locked)
	local visible = Interface.LoadBoolean( "MobilesOnScreenWindowVisible", false )	
	if (visible) then
		MobilesOnScreen.ShowPet()
	else
		MobilesOnScreen.HidePet()
	end	
	local windowname = "MobilesOnScreenWindow"		
	local texture = "UO_Core"
	if ( MobilesOnScreen.locked  ) then		
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 69,341)
		ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 92,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 92,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 92,341)
	else
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_NORMAL, texture, 117,341)
		ButtonSetTexture(windowname.."Lock",InterfaceCore.ButtonStates.STATE_NORMAL_HIGHLITE, texture, 142,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED, texture, 142,341)
		ButtonSetTexture(windowname.."Lock", InterfaceCore.ButtonStates.STATE_PRESSED_HIGHLITE, texture, 142,341)		
	end	
		
end

function DockSpotFirstAnchoring(toAnchor)
	if WindowUtils.CanRestorePosition(toAnchor) then
		WindowUtils.RestoreWindowPosition(toAnchor, false)
	else
		WindowClearAnchors(toAnchor)
		if string.find(toAnchor, "Yellow") then
			WindowAddAnchor(toAnchor, "topright", "MobilesOnScreenWindowShowView", "topleft", 0, 0 )
		elseif string.find(toAnchor, "Grey") then
			WindowAddAnchor(toAnchor, "topright", "MobilesOnScreenWindowShowView", "topleft", 160, 0 )
		elseif string.find(toAnchor, "Blue") then
			WindowAddAnchor(toAnchor, "topright", "MobilesOnScreenWindowShowView", "topleft", 320, 0 )
		elseif string.find(toAnchor, "Red") then
			WindowAddAnchor(toAnchor, "topright", "MobilesOnScreenWindowShowView", "topleft", 480, 0 )
		elseif string.find(toAnchor, "Green") then
			WindowAddAnchor(toAnchor, "topright", "MobilesOnScreenWindowShowView", "topleft", 640, 0 )
		elseif string.find(toAnchor, "Orange") then
			WindowAddAnchor(toAnchor, "topright", "MobilesOnScreenWindowShowView", "topleft", 800, 0 )
		end
		
		local x, y= WindowGetOffsetFromParent(toAnchor)
		WindowClearAnchors(toAnchor)
		WindowSetOffsetFromParent(toAnchor, x,y)
	end
end