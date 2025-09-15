--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local HttpService = game:GetService("HttpService");
local OrionLib = {Elements={},ThemeObjects={},Connections={},Flags={},Themes={Default={Main=Color3.fromRGB(0, 0, 0),Second=Color3.fromRGB(0, 0, 0),Stroke=Color3.fromRGB(124, 255, 124),Divider=Color3.fromRGB(60, 60, 60),Text=Color3.fromRGB(124, 255, 124),TextDark=Color3.fromRGB(124, 255, 124)}},SelectedTheme="Default",Folder=nil,SaveCfg=false};
local Icons = {};
local Success, Response = pcall(function()
	Icons = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/kigredns/icos/refs/heads/main/icons.json")).icons;
end);
if not Success then
	warn("\nOrion Library - Failed to load Feather Icons. Error code: " .. Response .. "\n");
end
local function GetIcon(IconName)
	if (Icons[IconName] ~= nil) then
		return Icons[IconName];
	else
		return nil;
	end
end
local Orion = Instance.new("ScreenGui");
Orion.Name = "Orion";
if syn then
	syn.protect_gui(Orion);
	Orion.Parent = game.CoreGui;
else
	Orion.Parent = gethui() or game.CoreGui;
end
OrionLib.IsRunning = function(self)
	if gethui then
		return Orion.Parent == gethui();
	else
		return Orion.Parent == game:GetService("CoreGui");
	end
end;
local function AddConnection(Signal, Function)
	local FlatIdent_95CAC = 0;
	local SignalConnect;
	while true do
		if (FlatIdent_95CAC == 1) then
			table.insert(OrionLib.Connections, SignalConnect);
			return SignalConnect;
		end
		if (FlatIdent_95CAC == 0) then
			if not OrionLib:IsRunning() then
				return;
			end
			SignalConnect = Signal:Connect(Function);
			FlatIdent_95CAC = 1;
		end
	end
end
task.spawn(function()
	local FlatIdent_8D327 = 0;
	while true do
		if (FlatIdent_8D327 == 0) then
			while (OrionLib:IsRunning()) do
				wait();
			end
			for _, Connection in next, OrionLib.Connections do
				Connection:Disconnect();
			end
			break;
		end
	end
end);
local function MakeDraggable(DragPoint, Main)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false;
		AddConnection(DragPoint.InputBegan, function(Input)
			if ((Input.UserInputType == Enum.UserInputType.MouseButton1) or (Input.UserInputType == Enum.UserInputType.Touch)) then
				Dragging = true;
				MousePos = Input.Position;
				FramePos = Main.Position;
				Input.Changed:Connect(function()
					if (Input.UserInputState == Enum.UserInputState.End) then
						Dragging = false;
					end
				end);
			end
		end);
		AddConnection(DragPoint.InputChanged, function(Input)
			if ((Input.UserInputType == Enum.UserInputType.MouseMovement) or (Input.UserInputType == Enum.UserInputType.Touch)) then
				DragInput = Input;
			end
		end);
		AddConnection(UserInputService.InputChanged, function(Input)
			if ((Input == DragInput) and Dragging) then
				local FlatIdent_24A02 = 0;
				local Delta;
				while true do
					if (FlatIdent_24A02 == 1) then
						Main.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y);
						break;
					end
					if (FlatIdent_24A02 == 0) then
						Delta = Input.Position - MousePos;
						TweenService:Create(Main, TweenInfo.new(0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position=UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play();
						FlatIdent_24A02 = 1;
					end
				end
			end
		end);
	end);
end
local function Create(Name, Properties, Children)
	local FlatIdent_89ECE = 0;
	local Object;
	while true do
		if (FlatIdent_89ECE == 1) then
			for i, v in next, Children or {} do
				v.Parent = Object;
			end
			return Object;
		end
		if (FlatIdent_89ECE == 0) then
			Object = Instance.new(Name);
			for i, v in next, Properties or {} do
				Object[i] = v;
			end
			FlatIdent_89ECE = 1;
		end
	end
end
local function CreateElement(ElementName, ElementFunction)
	OrionLib.Elements[ElementName] = function(...)
		return ElementFunction(...);
	end;
end
local function MakeElement(ElementName, ...)
	local FlatIdent_1743D = 0;
	local NewElement;
	while true do
		if (FlatIdent_1743D == 0) then
			NewElement = OrionLib.Elements[ElementName](...);
			return NewElement;
		end
	end
end
local function SetProps(Element, Props)
	local FlatIdent_7366E = 0;
	while true do
		if (0 == FlatIdent_7366E) then
			table.foreach(Props, function(Property, Value)
				Element[Property] = Value;
			end);
			return Element;
		end
	end
end
local function SetChildren(Element, Children)
	local FlatIdent_43862 = 0;
	while true do
		if (0 == FlatIdent_43862) then
			table.foreach(Children, function(_, Child)
				Child.Parent = Element;
			end);
			return Element;
		end
	end
end
local function Round(Number, Factor)
	local Result = math.floor((Number / Factor) + (math.sign(Number) * 0.5)) * Factor;
	if (Result < 0) then
		Result = Result + Factor;
	end
	return Result;
end
local function ReturnProperty(Object)
	local FlatIdent_8F047 = 0;
	while true do
		if (2 == FlatIdent_8F047) then
			if (Object:IsA("ImageLabel") or Object:IsA("ImageButton")) then
				return "ImageColor3";
			end
			break;
		end
		if (FlatIdent_8F047 == 1) then
			if Object:IsA("UIStroke") then
				return "Color";
			end
			if (Object:IsA("TextLabel") or Object:IsA("TextBox")) then
				return "TextColor3";
			end
			FlatIdent_8F047 = 2;
		end
		if (FlatIdent_8F047 == 0) then
			if (Object:IsA("Frame") or Object:IsA("TextButton")) then
				return "BackgroundColor3";
			end
			if Object:IsA("ScrollingFrame") then
				return "ScrollBarImageColor3";
			end
			FlatIdent_8F047 = 1;
		end
	end
end
local function AddThemeObject(Object, Type)
	local FlatIdent_104D4 = 0;
	while true do
		if (FlatIdent_104D4 == 1) then
			Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Type];
			return Object;
		end
		if (FlatIdent_104D4 == 0) then
			if not OrionLib.ThemeObjects[Type] then
				OrionLib.ThemeObjects[Type] = {};
			end
			table.insert(OrionLib.ThemeObjects[Type], Object);
			FlatIdent_104D4 = 1;
		end
	end
end
local function SetTheme()
	for Name, Type in pairs(OrionLib.ThemeObjects) do
		for _, Object in pairs(Type) do
			Object[ReturnProperty(Object)] = OrionLib.Themes[OrionLib.SelectedTheme][Name];
		end
	end
end
local function PackColor(Color)
	return {R=(Color.R * 255),G=(Color.G * 255),B=(Color.B * 255)};
end
local function UnpackColor(Color)
	return Color3.fromRGB(Color.R, Color.G, Color.B);
end
local function LoadCfg(Config)
	local Data = HttpService:JSONDecode(Config);
	table.foreach(Data, function(a, b)
		if OrionLib.Flags[a] then
			spawn(function()
				if (OrionLib.Flags[a].Type == "Colorpicker") then
					OrionLib.Flags[a]:Set(UnpackColor(b));
				else
					OrionLib.Flags[a]:Set(b);
				end
			end);
		else
			warn("Orion Library Config Loader - Could not find ", a, b);
		end
	end);
end
local function SaveCfg(Name)
	local FlatIdent_A9A3 = 0;
	local Data;
	while true do
		if (FlatIdent_A9A3 == 0) then
			Data = {};
			for i, v in pairs(OrionLib.Flags) do
				if v.Save then
					if (v.Type == "Colorpicker") then
						Data[i] = PackColor(v.Value);
					else
						Data[i] = v.Value;
					end
				end
			end
			break;
		end
	end
end
local WhitelistedMouse = {Enum.UserInputType.MouseButton1,Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3,Enum.UserInputType.Touch};
local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape};
local function CheckKey(Table, Key)
	for _, v in next, Table do
		if (v == Key) then
			return true;
		end
	end
end
CreateElement("Corner", function(Scale, Offset)
	local Corner = Create("UICorner", {CornerRadius=UDim.new(Scale or 0, Offset or 10)});
	return Corner;
end);
CreateElement("Stroke", function(Color, Thickness)
	local Stroke = Create("UIStroke", {Color=(Color or Color3.fromRGB(255, 255, 255)),Thickness=(Thickness or 1)});
	return Stroke;
end);
CreateElement("List", function(Scale, Offset)
	local FlatIdent_40CF = 0;
	local List;
	while true do
		if (FlatIdent_40CF == 0) then
			List = Create("UIListLayout", {SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(Scale or 0, Offset or 0)});
			return List;
		end
	end
end);
CreateElement("Padding", function(Bottom, Left, Right, Top)
	local FlatIdent_49AED = 0;
	local Padding;
	while true do
		if (FlatIdent_49AED == 0) then
			Padding = Create("UIPadding", {PaddingBottom=UDim.new(0, Bottom or 4),PaddingLeft=UDim.new(0, Left or 4),PaddingRight=UDim.new(0, Right or 4),PaddingTop=UDim.new(0, Top or 4)});
			return Padding;
		end
	end
end);
CreateElement("TFrame", function()
	local TFrame = Create("Frame", {BackgroundTransparency=1});
	return TFrame;
end);
CreateElement("Frame", function(Color)
	local FlatIdent_99389 = 0;
	local Frame;
	while true do
		if (FlatIdent_99389 == 0) then
			Frame = Create("Frame", {BackgroundColor3=(Color or Color3.fromRGB(255, 255, 255)),BorderSizePixel=0});
			return Frame;
		end
	end
end);
CreateElement("RoundFrame", function(Color, Scale, Offset)
	local Frame = Create("Frame", {BackgroundColor3=(Color or Color3.fromRGB(255, 255, 255)),BorderSizePixel=0}, {Create("UICorner", {CornerRadius=UDim.new(Scale, Offset)})});
	return Frame;
end);
CreateElement("Button", function()
	local FlatIdent_8CEDF = 0;
	local Button;
	while true do
		if (FlatIdent_8CEDF == 0) then
			Button = Create("TextButton", {Text="",AutoButtonColor=false,BackgroundTransparency=1,BorderSizePixel=0});
			return Button;
		end
	end
end);
CreateElement("ScrollFrame", function(Color, Width)
	local FlatIdent_33EA4 = 0;
	local ScrollFrame;
	while true do
		if (FlatIdent_33EA4 == 0) then
			ScrollFrame = Create("ScrollingFrame", {BackgroundTransparency=1,MidImage="rbxassetid://124481197674432",BottomImage="rbxassetid://124481197674432",TopImage="rbxassetid://124481197674432",ScrollBarImageColor3=Color,BorderSizePixel=0,ScrollBarThickness=Width,Size=UDim2.new(1, 0, 1, 0),CanvasSize=UDim2.new(0, 0, 0, 0)});
			return ScrollFrame;
		end
	end
end);
CreateElement("Image", function(ImageID)
	local FlatIdent_25DF3 = 0;
	local ImageNew;
	while true do
		if (FlatIdent_25DF3 == 1) then
			return ImageNew;
		end
		if (FlatIdent_25DF3 == 0) then
			ImageNew = Create("ImageLabel", {Image=ImageID,BackgroundTransparency=1});
			if (GetIcon(ImageID) ~= nil) then
				ImageNew.Image = GetIcon(ImageID);
			end
			FlatIdent_25DF3 = 1;
		end
	end
end);
CreateElement("ImageButton", function(ImageID)
	local FlatIdent_66799 = 0;
	local Image;
	while true do
		if (FlatIdent_66799 == 0) then
			Image = Create("ImageButton", {Image=ImageID,BackgroundTransparency=1});
			return Image;
		end
	end
end);
CreateElement("Label", function(Text, TextSize, Transparency)
	local FlatIdent_295EB = 0;
	local Label;
	while true do
		if (FlatIdent_295EB == 0) then
			Label = Create("TextLabel", {Text=(Text or ""),TextColor3=Color3.fromRGB(251, 255, 124),TextTransparency=(Transparency or 0),TextSize=(TextSize or 15),Font=Enum.Font.FredokaOne,RichText=true,BackgroundTransparency=1,TextXAlignment=Enum.TextXAlignment.Left});
			return Label;
		end
	end
end);
local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), {SetProps(MakeElement("List"), {HorizontalAlignment=Enum.HorizontalAlignment.Center,SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Bottom,Padding=UDim.new(0, 5)})}), {Position=UDim2.new(1, -25, 1, -25),Size=UDim2.new(0, 300, 1, -25),AnchorPoint=Vector2.new(1, 1),Parent=Orion});
OrionLib.MakeNotification = function(self, NotificationConfig)
	spawn(function()
		NotificationConfig.Name = NotificationConfig.Name or "Notification";
		NotificationConfig.Content = NotificationConfig.Content or "Test";
		NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://124481197674432";
		NotificationConfig.Time = NotificationConfig.Time or 15;
		local NotificationParent = SetProps(MakeElement("TFrame"), {Size=UDim2.new(1, 0, 0, 0),AutomaticSize=Enum.AutomaticSize.Y,Parent=NotificationHolder});
		local NotificationFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(25, 25, 24), 0, 10), {Parent=NotificationParent,Size=UDim2.new(1, 0, 0, 0),Position=UDim2.new(1, -55, 0, 0),AutomaticSize=Enum.AutomaticSize.Y}), {MakeElement("Stroke", Color3.fromRGB(251, 255, 124), 1.2),MakeElement("Padding", 12, 12, 12, 12),SetProps(MakeElement("Image", NotificationConfig.Image), {Size=UDim2.new(0, 20, 0, 20),ImageColor3=Color3.fromRGB(251, 255, 124),Name="Icon"}),SetProps(MakeElement("Label", NotificationConfig.Name, 15), {Size=UDim2.new(1, -30, 0, 20),Position=UDim2.new(0, 30, 0, 0),Font=Enum.Font.FredokaOne,Name="Title"}),SetProps(MakeElement("Label", NotificationConfig.Content, 14), {Size=UDim2.new(1, 0, 0, 0),Position=UDim2.new(0, 0, 0, 25),Font=Enum.Font.FredokaOne,Name="ismail",AutomaticSize=Enum.AutomaticSize.Y,TextColor3=Color3.fromRGB(251, 255, 124),TextWrapped=true})});
		TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position=UDim2.new(0, 0, 0, 0)}):Play();
		wait(NotificationConfig.Time - 0.88);
		TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency=1}):Play();
		TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency=0.2}):Play();
		wait(0.3);
		TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency=0.9}):Play();
		TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency=0.4}):Play();
		TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency=0.5}):Play();
		wait(0.05);
		NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0), "In", "Quint", 0.8, true);
		wait(1.35);
		NotificationFrame:Destroy();
	end);
end;
OrionLib.Init = function(self)
	if OrionLib.SaveCfg then
		pcall(function()
			if isfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt") then
				LoadCfg(readfile(OrionLib.Folder .. "/" .. game.GameId .. ".txt"));
				OrionLib:MakeNotification({Name="ismail x",Content=("ماتقدر تغلق سكربت " .. game.GameId .. "."),Time=5});
			end
		end);
	end
end;
OrionLib.MakeWindow = function(self, WindowConfig)
	local FirstTab = true;
	local Minimized = false;
	local Loaded = false;
	local UIHidden = false;
	WindowConfig = WindowConfig or {};
	WindowConfig.Name = WindowConfig.Name or "Orion Library";
	WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name;
	WindowConfig.SaveConfig = WindowConfig.SaveConfig or false;
	WindowConfig.HidePremium = WindowConfig.HidePremium or false;
	if (WindowConfig.IntroEnabled == nil) then
		WindowConfig.IntroEnabled = true;
	end
	WindowConfig.IntroToggleIcon = WindowConfig.IntroToggleIcon or "rbxassetid://7743870134";
	WindowConfig.IntroText = WindowConfig.IntroText or "Orion Library";
	WindowConfig.CloseCallback = WindowConfig.CloseCallback or function()
	end;
	WindowConfig.ShowIcon = WindowConfig.ShowIcon or false;
	WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://7743870134";
	WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://7743870134";
	OrionLib.Folder = WindowConfig.ConfigFolder;
	OrionLib.SaveCfg = WindowConfig.SaveConfig;
	if WindowConfig.SaveConfig then
		if not isfolder(WindowConfig.ConfigFolder) then
			makefolder(WindowConfig.ConfigFolder);
		end
	end
	local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {Size=UDim2.new(1, 0, 1, -50)}), {MakeElement("List"),MakeElement("Padding", 8, 0, 0, 8)}), "Divider");
	AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16);
	end);
	local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {Size=UDim2.new(0.5, 0, 1, 0),Position=UDim2.new(0.5, 0, 0, 0),BackgroundTransparency=1}), {AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), {Position=UDim2.new(0, 9, 0, 6),Size=UDim2.new(0, 18, 0, 18)}), "Text")});
	local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {Size=UDim2.new(0.5, 0, 1, 0),BackgroundTransparency=1}), {AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), {Position=UDim2.new(0, 9, 0, 6),Size=UDim2.new(0, 18, 0, 18),Name="Ico"}), "Text")});
	local DragPoint = SetProps(MakeElement("TFrame"), {Size=UDim2.new(1, 0, 0, 50)});
	local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {Size=UDim2.new(0, 150, 1, -50),Position=UDim2.new(0, 0, 0, 50)}), {AddThemeObject(SetProps(MakeElement("Frame"), {Size=UDim2.new(1, 0, 0, 10),Position=UDim2.new(0, 0, 0, 0)}), "Second"),AddThemeObject(SetProps(MakeElement("Frame"), {Size=UDim2.new(0, 10, 1, 0),Position=UDim2.new(1, -10, 0, 0)}), "Second"),AddThemeObject(SetProps(MakeElement("Frame"), {Size=UDim2.new(0, 1, 1, 0),Position=UDim2.new(1, -1, 0, 0)}), "Stroke"),TabHolder,SetChildren(SetProps(MakeElement("TFrame"), {Size=UDim2.new(1, 0, 0, 50),Position=UDim2.new(0, 0, 1, -50)}), {AddThemeObject(SetProps(MakeElement("Frame"), {Size=UDim2.new(1, 0, 0, 1)}), "Stroke"),SetChildren(SetProps(MakeElement("TFrame"), {AnchorPoint=Vector2.new(0, 0.5),Size=UDim2.new(0, 32, 0, 32),Position=UDim2.new(0, 10, 0.5, 0)}), {AddThemeObject(MakeElement("Stroke"), "Stroke"),MakeElement("Corner", 1)}),AddThemeObject(SetProps(MakeElement("Label", "BY Ismail X", (WindowConfig.HidePremium and 14) or 13), {Size=UDim2.new(1, -60, 0, 13),Position=((WindowConfig.HidePremium and UDim2.new(0, 50, 0, 19)) or UDim2.new(0, 50, 0, 12)),Font=Enum.Font.FredokaOne,ClipsDescendants=true}), "Text"),AddThemeObject(SetProps(MakeElement("Label", "", 12), {Size=UDim2.new(1, -60, 0, 12),Position=UDim2.new(0, 50, 1, -25),Visible=not WindowConfig.HidePremium}), "TextDark")})}), "Second");
	local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), {Size=UDim2.new(1, -30, 2, 0),Position=UDim2.new(0, 25, 0, -24),Font=Enum.Font.FredokaOne,TextSize=20}), "Text");
	local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {Size=UDim2.new(1, 0, 0, 1),Position=UDim2.new(0, 0, 1, -1)}), "Stroke");
	local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {Parent=Orion,Position=UDim2.new(0.5, -307, 0.5, -172),Size=UDim2.new(0, 615, 0, 344),ClipsDescendants=true}), {SetChildren(SetProps(MakeElement("TFrame"), {Size=UDim2.new(1, 0, 0, 50),Name="TopBar"}), {WindowName,WindowTopBarLine,AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {Size=UDim2.new(0, 70, 0, 30),Position=UDim2.new(1, -90, 0, 10)}), {AddThemeObject(MakeElement("Stroke"), "Stroke"),AddThemeObject(SetProps(MakeElement("Frame"), {Size=UDim2.new(0, 1, 1, 0),Position=UDim2.new(0.5, 0, 0, 0)}), "Stroke"),CloseBtn,MinimizeBtn}), "Second")}),DragPoint,WindowStuff}), "Main");
	if WindowConfig.ShowIcon then
		local FlatIdent_981A3 = 0;
		local WindowIcon;
		while true do
			if (FlatIdent_981A3 == 1) then
				WindowIcon.Parent = MainWindow.TopBar;
				break;
			end
			if (FlatIdent_981A3 == 0) then
				WindowName.Position = UDim2.new(0, 50, 0, -24);
				WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), {Size=UDim2.new(0, 20, 0, 20),Position=UDim2.new(0, 25, 0, 15)});
				FlatIdent_981A3 = 1;
			end
		end
	end
	MakeDraggable(DragPoint, MainWindow);
	local MobileReopenButton = SetChildren(SetProps(MakeElement("Button"), {Parent=Orion,Size=UDim2.new(0, 40, 0, 40),Position=UDim2.new(0.5, -20, 0, 20),BackgroundTransparency=0.2,BackgroundColor3=OrionLib.Themes[OrionLib.SelectedTheme].Main,Visible=false}), {AddThemeObject(SetProps(MakeElement("Image", WindowConfig.IntroToggleIcon or "http://www.roblox.com/asset/?id=8834748103"), {AnchorPoint=Vector2.new(0.5, 0.5),Position=UDim2.new(0.5, 0, 0.5, 0),Size=UDim2.new(0.7, 0, 0.7, 0)}), "Text"),MakeElement("Corner", 1)});
	AddConnection(CloseBtn.MouseButton1Up, function()
		MainWindow.Visible = false;
		MobileReopenButton.Visible = true;
		UIHidden = true;
		OrionLib:MakeNotification({Name="Interface Hidden",Content="Tap Left Control to reopen the interface",Time=5});
		WindowConfig.CloseCallback();
	end);
	AddConnection(UserInputService.InputBegan, function(Input)
		if ((Input.KeyCode == Enum.KeyCode.LeftControl) and (UIHidden == true)) then
			local FlatIdent_52551 = 0;
			while true do
				if (FlatIdent_52551 == 0) then
					MainWindow.Visible = true;
					MobileReopenButton.Visible = false;
					break;
				end
			end
		end
	end);
	AddConnection(MobileReopenButton.Activated, function()
		local FlatIdent_287B5 = 0;
		while true do
			if (FlatIdent_287B5 == 0) then
				MainWindow.Visible = true;
				MobileReopenButton.Visible = false;
				break;
			end
		end
	end);
	AddConnection(MinimizeBtn.MouseButton1Up, function()
		local FlatIdent_4CC24 = 0;
		while true do
			if (FlatIdent_4CC24 == 0) then
				if Minimized then
					local FlatIdent_207CC = 0;
					while true do
						if (FlatIdent_207CC == 1) then
							wait(0.02);
							MainWindow.ClipsDescendants = false;
							FlatIdent_207CC = 2;
						end
						if (2 == FlatIdent_207CC) then
							WindowStuff.Visible = true;
							WindowTopBarLine.Visible = true;
							break;
						end
						if (FlatIdent_207CC == 0) then
							TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size=UDim2.new(0, 615, 0, 344)}):Play();
							MinimizeBtn.Ico.Image = "rbxassetid://7072719338";
							FlatIdent_207CC = 1;
						end
					end
				else
					local FlatIdent_8A742 = 0;
					while true do
						if (FlatIdent_8A742 == 1) then
							MinimizeBtn.Ico.Image = "rbxassetid://7072720870";
							TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size=UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play();
							FlatIdent_8A742 = 2;
						end
						if (0 == FlatIdent_8A742) then
							MainWindow.ClipsDescendants = true;
							WindowTopBarLine.Visible = false;
							FlatIdent_8A742 = 1;
						end
						if (FlatIdent_8A742 == 2) then
							wait(0.1);
							WindowStuff.Visible = false;
							break;
						end
					end
				end
				Minimized = not Minimized;
				break;
			end
		end
	end);
	local function LoadSequence()
		MainWindow.Visible = false;
		local LoadSequenceLogo = SetProps(MakeElement("Image", WindowConfig.IntroIcon), {Parent=Orion,AnchorPoint=Vector2.new(0.5, 0.5),Position=UDim2.new(0.5, 0, 0.4, 0),Size=UDim2.new(0, 28, 0, 28),ImageColor3=Color3.fromRGB(255, 255, 255),ImageTransparency=1});
		local LoadSequenceText = SetProps(MakeElement("Label", WindowConfig.IntroText, 14), {Parent=Orion,Size=UDim2.new(1, 0, 1, 0),AnchorPoint=Vector2.new(0.5, 0.5),Position=UDim2.new(0.5, 19, 0.5, 0),TextXAlignment=Enum.TextXAlignment.Center,Font=Enum.Font.FredokaOne,TextTransparency=1});
		TweenService:Create(LoadSequenceLogo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency=0,Position=UDim2.new(0.5, 0, 0.5, 0)}):Play();
		wait(0.8);
		TweenService:Create(LoadSequenceLogo, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position=UDim2.new(0.5, -(LoadSequenceText.TextBounds.X / 2), 0.5, 0)}):Play();
		wait(0.3);
		TweenService:Create(LoadSequenceText, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency=0}):Play();
		wait(2);
		TweenService:Create(LoadSequenceText, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency=1}):Play();
		MainWindow.Visible = true;
		LoadSequenceLogo:Destroy();
		LoadSequenceText:Destroy();
	end
	if WindowConfig.IntroEnabled then
		LoadSequence();
	end
	local TabFunction = {};
	TabFunction.MakeTab = function(self, TabConfig)
		TabConfig = TabConfig or {};
		TabConfig.Name = TabConfig.Name or "Tab";
		TabConfig.Icon = TabConfig.Icon or "";
		TabConfig.PremiumOnly = TabConfig.PremiumOnly or false;
		local TabFrame = SetChildren(SetProps(MakeElement("Button"), {Size=UDim2.new(1, 0, 0, 30),Parent=TabHolder}), {AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {AnchorPoint=Vector2.new(0, 0.5),Size=UDim2.new(0, 18, 0, 18),Position=UDim2.new(0, 10, 0.5, 0),ImageTransparency=0.4,Name="Ico"}), "Text"),AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {Size=UDim2.new(1, -35, 1, 0),Position=UDim2.new(0, 35, 0, 0),Font=Enum.Font.FredokaOne,TextTransparency=0.4,Name="Title"}), "Text")});
		if (GetIcon(TabConfig.Icon) ~= nil) then
			TabFrame.Ico.Image = GetIcon(TabConfig.Icon);
		end
		local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {Size=UDim2.new(1, -150, 1, -50),Position=UDim2.new(0, 150, 0, 50),Parent=MainWindow,Visible=false,Name="ItemContainer"}), {MakeElement("List", 0, 6),MakeElement("Padding", 15, 10, 10, 15)}), "Divider");
		AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + 30);
		end);
		if FirstTab then
			local FlatIdent_5F1CB = 0;
			while true do
				if (FlatIdent_5F1CB == 0) then
					FirstTab = false;
					TabFrame.Ico.ImageTransparency = 0;
					FlatIdent_5F1CB = 1;
				end
				if (FlatIdent_5F1CB == 2) then
					Container.Visible = true;
					break;
				end
				if (FlatIdent_5F1CB == 1) then
					TabFrame.Title.TextTransparency = 0;
					TabFrame.Title.Font = Enum.Font.FredokaOne;
					FlatIdent_5F1CB = 2;
				end
			end
		end
		AddConnection(TabFrame.MouseButton1Click, function()
			local FlatIdent_1A54 = 0;
			while true do
				if (FlatIdent_1A54 == 2) then
					TabFrame.Title.Font = Enum.Font.FredokaOne;
					Container.Visible = true;
					break;
				end
				if (FlatIdent_1A54 == 1) then
					TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency=0}):Play();
					TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency=0}):Play();
					FlatIdent_1A54 = 2;
				end
				if (0 == FlatIdent_1A54) then
					for _, Tab in next, TabHolder:GetChildren() do
						if Tab:IsA("TextButton") then
							local FlatIdent_494F6 = 0;
							while true do
								if (FlatIdent_494F6 == 0) then
									Tab.Title.Font = Enum.Font.FredokaOne;
									TweenService:Create(Tab.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency=0.4}):Play();
									FlatIdent_494F6 = 1;
								end
								if (FlatIdent_494F6 == 1) then
									TweenService:Create(Tab.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency=0.4}):Play();
									break;
								end
							end
						end
					end
					for _, ItemContainer in next, MainWindow:GetChildren() do
						if (ItemContainer.Name == "ItemContainer") then
							ItemContainer.Visible = false;
						end
					end
					FlatIdent_1A54 = 1;
				end
			end
		end);
		local function GetElements(ItemParent)
			local ElementFunction = {};
			ElementFunction.AddLabel = function(self, Text)
				local FlatIdent_5EE26 = 0;
				local LabelFrame;
				local LabelFunction;
				while true do
					if (FlatIdent_5EE26 == 1) then
						LabelFunction.Set = function(self, ToChange)
							LabelFrame.Content.Text = ToChange;
						end;
						return LabelFunction;
					end
					if (FlatIdent_5EE26 == 0) then
						LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {Size=UDim2.new(1, 0, 0, 30),BackgroundTransparency=0.2,Parent=ItemParent}), {AddThemeObject(SetProps(MakeElement("Label", Text, 15), {Size=UDim2.new(1, -12, 1, 0),Position=UDim2.new(0, 12, 0, 0),Font=Enum.Font.FredokaOne,Name="Content"}), "Text"),AddThemeObject(MakeElement("Stroke"), "Stroke")}), "Second");
						LabelFunction = {};
						FlatIdent_5EE26 = 1;
					end
				end
			end;
			ElementFunction.AddParagraph = function(self, Text, Content)
				Text = Text or "Text";
				Content = Content or "Content";
				local ParagraphFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {Size=UDim2.new(1, 0, 0, 30),BackgroundTransparency=0.2,Parent=ItemParent}), {AddThemeObject(SetProps(MakeElement("Label", Text, 15), {Size=UDim2.new(1, -12, 0, 14),Position=UDim2.new(0, 12, 0, 10),Font=Enum.Font.FredokaOne,Name="Title"}), "Text"),AddThemeObject(SetProps(MakeElement("Label", "", 13), {Size=UDim2.new(1, -24, 0, 0),Position=UDim2.new(0, 12, 0, 26),Font=Enum.Font.FredokaOne,Name="Content",TextWrapped=true}), "TextDark"),AddThemeObject(MakeElement("Stroke"), "Stroke")}), "Second");
				AddConnection(ParagraphFrame.Content:GetPropertyChangedSignal("Text"), function()
					ParagraphFrame.Content.Size = UDim2.new(1, -24, 0, ParagraphFrame.Content.TextBounds.Y);
					ParagraphFrame.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y + 35);
				end);
				ParagraphFrame.Content.Text = Content;
				local ParagraphFunction = {};
				ParagraphFunction.Set = function(self, ToChange)
					ParagraphFrame.Content.Text = ToChange;
				end;
				return ParagraphFunction;
			end;
			ElementFunction.AddButton = function(self, ButtonConfig)
				ButtonConfig = ButtonConfig or {};
				ButtonConfig.Name = ButtonConfig.Name or "Button";
				ButtonConfig.Callback = ButtonConfig.Callback or function()
				end;
				ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587";
				local Button = {};
				local Click = SetProps(MakeElement("Button"), {Size=UDim2.new(1, 0, 1, 0)});
				local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {Size=UDim2.new(1, 0, 0, 33),Parent=ItemParent}), {AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 15), {Size=UDim2.new(1, -12, 1, 0),Position=UDim2.new(0, 12, 0, 0),Font=Enum.Font.FredokaOne,Name="Content"}), "Text"),AddThemeObject(SetProps(MakeElement("Image", ButtonConfig.Icon), {Size=UDim2.new(0, 20, 0, 20),Position=UDim2.new(1, -30, 0, 7)}), "TextDark"),AddThemeObject(MakeElement("Stroke"), "Stroke"),Click}), "Second");
				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 3)}):Play();
				end);
				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play();
				end);
				AddConnection(Click.MouseButton1Up, function()
					local FlatIdent_580CB = 0;
					while true do
						if (FlatIdent_580CB == 0) then
							TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 3)}):Play();
							spawn(function()
								ButtonConfig.Callback();
							end);
							break;
						end
					end
				end);
				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 6, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 6, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 6)}):Play();
				end);
				Button.Set = function(self, ButtonText)
					ButtonFrame.Content.Text = ButtonText;
				end;
				return Button;
			end;
			ElementFunction.AddToggle = function(self, ToggleConfig)
				ToggleConfig = ToggleConfig or {};
				ToggleConfig.Name = ToggleConfig.Name or "Toggle";
				ToggleConfig.Default = ToggleConfig.Default or false;
				ToggleConfig.Callback = ToggleConfig.Callback or function()
				end;
				ToggleConfig.Color = ToggleConfig.Color or Color3.fromRGB(9, 99, 195);
				ToggleConfig.Flag = ToggleConfig.Flag or nil;
				ToggleConfig.Save = ToggleConfig.Save or false;
				local Toggle = {Value=ToggleConfig.Default,Save=ToggleConfig.Save};
				local Click = SetProps(MakeElement("Button"), {Size=UDim2.new(1, 0, 1, 0)});
				local ToggleBox = SetChildren(SetProps(MakeElement("RoundFrame", ToggleConfig.Color, 0, 4), {Size=UDim2.new(0, 24, 0, 24),Position=UDim2.new(1, -24, 0.5, 0),AnchorPoint=Vector2.new(0.5, 0.5)}), {SetProps(MakeElement("Stroke"), {Color=ToggleConfig.Color,Name="Stroke",Transparency=0.5}),SetProps(MakeElement("Image", "rbxassetid://3944680095"), {Size=UDim2.new(0, 20, 0, 20),AnchorPoint=Vector2.new(0.5, 0.5),Position=UDim2.new(0.5, 0, 0.5, 0),ImageColor3=Color3.fromRGB(255, 255, 255),Name="Ico"})});
				local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {Size=UDim2.new(1, 0, 0, 38),Parent=ItemParent}), {AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 15), {Size=UDim2.new(1, -12, 1, 0),Position=UDim2.new(0, 12, 0, 0),Font=Enum.Font.FredokaOne,Name="Content"}), "Text"),AddThemeObject(MakeElement("Stroke"), "Stroke"),ToggleBox,Click}), "Second");
				Toggle.Set = function(self, Value)
					Toggle.Value = Value;
					TweenService:Create(ToggleBox, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=((Toggle.Value and ToggleConfig.Color) or OrionLib.Themes.Default.Divider)}):Play();
					TweenService:Create(ToggleBox.Stroke, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Color=((Toggle.Value and ToggleConfig.Color) or OrionLib.Themes.Default.Stroke)}):Play();
					TweenService:Create(ToggleBox.Ico, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency=((Toggle.Value and 0) or 1),Size=((Toggle.Value and UDim2.new(0, 20, 0, 20)) or UDim2.new(0, 8, 0, 8))}):Play();
					ToggleConfig.Callback(Toggle.Value);
				end;
				Toggle:Set(Toggle.Value);
				AddConnection(Click.MouseEnter, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 3)}):Play();
				end);
				AddConnection(Click.MouseLeave, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play();
				end);
				AddConnection(Click.MouseButton1Up, function()
					local FlatIdent_77172 = 0;
					while true do
						if (FlatIdent_77172 == 1) then
							Toggle:Set(not Toggle.Value);
							break;
						end
						if (FlatIdent_77172 == 0) then
							TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 3)}):Play();
							SaveCfg(game.GameId);
							FlatIdent_77172 = 1;
						end
					end
				end);
				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 6, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 6, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 6)}):Play();
				end);
				if ToggleConfig.Flag then
					OrionLib.Flags[ToggleConfig.Flag] = Toggle;
				end
				return Toggle;
			end;
			ElementFunction.AddSlider = function(self, SliderConfig)
				SliderConfig = SliderConfig or {};
				SliderConfig.Name = SliderConfig.Name or "Slider";
				SliderConfig.Min = SliderConfig.Min or 0;
				SliderConfig.Max = SliderConfig.Max or 100;
				SliderConfig.Increment = SliderConfig.Increment or 1;
				SliderConfig.Default = SliderConfig.Default or 50;
				SliderConfig.Callback = SliderConfig.Callback or function()
				end;
				SliderConfig.ValueName = SliderConfig.ValueName or "";
				SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(0, 0, 0);
				SliderConfig.Flag = SliderConfig.Flag or nil;
				SliderConfig.Save = SliderConfig.Save or false;
				local Slider = {Value=SliderConfig.Default,Save=SliderConfig.Save};
				local Dragging = false;
				local SliderDrag = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {Size=UDim2.new(0, 0, 1, 0),BackgroundTransparency=0.2,ClipsDescendants=true}), {AddThemeObject(SetProps(MakeElement("Label", "value", 13), {Size=UDim2.new(1, -12, 0, 14),Position=UDim2.new(0, 12, 0, 6),Font=Enum.Font.FredokaOne,Name="Value",TextTransparency=0}), "Text")});
				local SliderBar = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 5), {Size=UDim2.new(1, -24, 0, 26),Position=UDim2.new(0, 12, 0, 30),BackgroundTransparency=0.2}), {SetProps(MakeElement("Stroke"), {Color=SliderConfig.Color}),AddThemeObject(SetProps(MakeElement("Label", "value", 13), {Size=UDim2.new(1, -12, 0, 14),Position=UDim2.new(0, 12, 0, 6),Font=Enum.Font.FredokaOne,Name="Value",TextTransparency=0.8}), "Text"),SliderDrag});
				local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(0, 0, 5), 0, 4), {Size=UDim2.new(1, 0, 0, 65),Parent=ItemParent}), {AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 15), {Size=UDim2.new(1, -12, 0, 14),Position=UDim2.new(0, 12, 0, 10),Font=Enum.Font.FredokaOne,Name="Content"}), "Text"),AddThemeObject(MakeElement("Stroke"), "Stroke"),SliderBar}), "Second");
				SliderBar.InputBegan:Connect(function(Input)
					if ((Input.UserInputType == Enum.UserInputType.MouseButton1) or (Input.UserInputType == Enum.UserInputType.Touch)) then
						Dragging = true;
					end
				end);
				SliderBar.InputEnded:Connect(function(Input)
					if ((Input.UserInputType == Enum.UserInputType.MouseButton1) or (Input.UserInputType == Enum.UserInputType.Touch)) then
						Dragging = false;
					end
				end);
				UserInputService.InputChanged:Connect(function(Input)
					if Dragging then
						local FlatIdent_7E707 = 0;
						local SizeScale;
						while true do
							if (FlatIdent_7E707 == 1) then
								SaveCfg(game.GameId);
								break;
							end
							if (FlatIdent_7E707 == 0) then
								SizeScale = math.clamp((Mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1);
								Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale));
								FlatIdent_7E707 = 1;
							end
						end
					end
				end);
				Slider.Set = function(self, Value)
					local FlatIdent_68856 = 0;
					while true do
						if (FlatIdent_68856 == 2) then
							SliderConfig.Callback(self.Value);
							break;
						end
						if (FlatIdent_68856 == 0) then
							self.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max);
							TweenService:Create(SliderDrag, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size=UDim2.fromScale((self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1)}):Play();
							FlatIdent_68856 = 1;
						end
						if (FlatIdent_68856 == 1) then
							SliderBar.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName;
							SliderDrag.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName;
							FlatIdent_68856 = 2;
						end
					end
				end;
				Slider:Set(Slider.Value);
				if SliderConfig.Flag then
					OrionLib.Flags[SliderConfig.Flag] = Slider;
				end
				return Slider;
			end;
			ElementFunction.AddDropdown = function(self, DropdownConfig)
				DropdownConfig = DropdownConfig or {};
				DropdownConfig.Name = DropdownConfig.Name or "Dropdown";
				DropdownConfig.Options = DropdownConfig.Options or {};
				DropdownConfig.Default = DropdownConfig.Default or "";
				DropdownConfig.Callback = DropdownConfig.Callback or function()
				end;
				DropdownConfig.Flag = DropdownConfig.Flag or nil;
				DropdownConfig.Save = DropdownConfig.Save or false;
				local Dropdown = {Value=DropdownConfig.Default,Options=DropdownConfig.Options,Buttons={},Toggled=false,Type="Dropdown",Save=DropdownConfig.Save};
				local MaxElements = 5;
				if not table.find(Dropdown.Options, Dropdown.Value) then
					Dropdown.Value = "...";
				end
				local DropdownList = MakeElement("List");
				local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {DropdownList}), {Parent=ItemParent,Position=UDim2.new(0, 0, 0, 38),Size=UDim2.new(1, 0, 1, -38),ClipsDescendants=true}), "Divider");
				local Click = SetProps(MakeElement("Button"), {Size=UDim2.new(1, 0, 1, 0)});
				local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {Size=UDim2.new(1, 0, 0, 38),Parent=ItemParent,ClipsDescendants=true}), {DropdownContainer,SetProps(SetChildren(MakeElement("TFrame"), {AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {Size=UDim2.new(1, -12, 1, 0),Position=UDim2.new(0, 12, 0, 0),Font=Enum.Font.FredokaOne,Name="Content"}), "Text"),AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {Size=UDim2.new(0, 20, 0, 20),AnchorPoint=Vector2.new(0, 0.5),Position=UDim2.new(1, -30, 0.5, 0),ImageColor3=Color3.fromRGB(240, 240, 240),Name="Ico"}), "TextDark"),AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), {Size=UDim2.new(1, -40, 1, 0),Font=Enum.Font.FredokaOne,Name="Selected",TextXAlignment=Enum.TextXAlignment.Right}), "TextDark"),AddThemeObject(SetProps(MakeElement("Frame"), {Size=UDim2.new(1, 0, 0, 1),Position=UDim2.new(0, 0, 1, -1),Name="Line",Visible=false}), "Stroke"),Click}), {Size=UDim2.new(1, 0, 0, 38),ClipsDescendants=true,Name="F"}),AddThemeObject(MakeElement("Stroke"), "Stroke"),MakeElement("Corner")}), "Second");
				AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y);
				end);
				local function AddOptions(Options)
					for _, Option in pairs(Options) do
						local FlatIdent_6D68E = 0;
						local OptionBtn;
						while true do
							if (FlatIdent_6D68E == 0) then
								OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {MakeElement("Corner", 0, 6),AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), {Position=UDim2.new(0, 8, 0, 0),Size=UDim2.new(1, -8, 1, 0),Name="Title"}), "Text")}), {Parent=DropdownContainer,Size=UDim2.new(1, 0, 0, 28),BackgroundTransparency=1,ClipsDescendants=true}), "Divider");
								AddConnection(OptionBtn.MouseButton1Click, function()
									local FlatIdent_854BA = 0;
									while true do
										if (FlatIdent_854BA == 0) then
											Dropdown:Set(Option);
											SaveCfg(game.GameId);
											break;
										end
									end
								end);
								FlatIdent_6D68E = 1;
							end
							if (FlatIdent_6D68E == 1) then
								Dropdown.Buttons[Option] = OptionBtn;
								break;
							end
						end
					end
				end
				Dropdown.Refresh = function(self, Options, Delete)
					if Delete then
						local FlatIdent_5D802 = 0;
						while true do
							if (FlatIdent_5D802 == 1) then
								table.clear(Dropdown.Buttons);
								break;
							end
							if (FlatIdent_5D802 == 0) then
								for _, v in pairs(Dropdown.Buttons) do
									v:Destroy();
								end
								table.clear(Dropdown.Options);
								FlatIdent_5D802 = 1;
							end
						end
					end
					Dropdown.Options = Options;
					AddOptions(Dropdown.Options);
				end;
				Dropdown.Set = function(self, Value)
					local FlatIdent_43337 = 0;
					while true do
						if (FlatIdent_43337 == 0) then
							if not table.find(Dropdown.Options, Value) then
								local FlatIdent_7126B = 0;
								while true do
									if (0 == FlatIdent_7126B) then
										Dropdown.Value = "...";
										DropdownFrame.F.Selected.Text = Dropdown.Value;
										FlatIdent_7126B = 1;
									end
									if (FlatIdent_7126B == 1) then
										for _, v in pairs(Dropdown.Buttons) do
											local FlatIdent_21CA5 = 0;
											while true do
												if (FlatIdent_21CA5 == 0) then
													TweenService:Create(v, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency=1}):Play();
													TweenService:Create(v.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency=0.4}):Play();
													break;
												end
											end
										end
										return;
									end
								end
							end
							Dropdown.Value = Value;
							FlatIdent_43337 = 1;
						end
						if (FlatIdent_43337 == 1) then
							DropdownFrame.F.Selected.Text = Dropdown.Value;
							for _, v in pairs(Dropdown.Buttons) do
								local FlatIdent_7517F = 0;
								while true do
									if (0 == FlatIdent_7517F) then
										TweenService:Create(v, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency=1}):Play();
										TweenService:Create(v.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency=0.4}):Play();
										break;
									end
								end
							end
							FlatIdent_43337 = 2;
						end
						if (FlatIdent_43337 == 2) then
							TweenService:Create(Dropdown.Buttons[Value], TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency=0.2}):Play();
							TweenService:Create(Dropdown.Buttons[Value].Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency=0}):Play();
							FlatIdent_43337 = 3;
						end
						if (FlatIdent_43337 == 3) then
							return DropdownConfig.Callback(Dropdown.Value);
						end
					end
				end;
				AddConnection(Click.MouseButton1Click, function()
					Dropdown.Toggled = not Dropdown.Toggled;
					DropdownFrame.F.Line.Visible = Dropdown.Toggled;
					TweenService:Create(DropdownFrame.F.Ico, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation=((Dropdown.Toggled and 180) or 0)}):Play();
					if (#Dropdown.Options > MaxElements) then
						TweenService:Create(DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size=((Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28))) or UDim2.new(1, 0, 0, 38))}):Play();
					else
						TweenService:Create(DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size=((Dropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38)) or UDim2.new(1, 0, 0, 38))}):Play();
					end
				end);
				Dropdown:Refresh(Dropdown.Options, false);
				Dropdown:Set(Dropdown.Value);
				if DropdownConfig.Flag then
					OrionLib.Flags[DropdownConfig.Flag] = Dropdown;
				end
				return Dropdown;
			end;
			ElementFunction.AddBind = function(self, BindConfig)
				BindConfig.Name = BindConfig.Name or "Bind";
				BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown;
				BindConfig.Hold = BindConfig.Hold or false;
				BindConfig.Callback = BindConfig.Callback or function()
				end;
				BindConfig.Flag = BindConfig.Flag or nil;
				BindConfig.Save = BindConfig.Save or false;
				local Bind = {Value,Binding=false,Type="Bind",Save=BindConfig.Save};
				local Holding = false;
				local Click = SetProps(MakeElement("Button"), {Size=UDim2.new(1, 0, 1, 0)});
				local BindBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {Size=UDim2.new(0, 24, 0, 24),Position=UDim2.new(1, -12, 0.5, 0),AnchorPoint=Vector2.new(1, 0.5)}), {AddThemeObject(MakeElement("Stroke"), "Stroke"),AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 14), {Size=UDim2.new(1, 0, 1, 0),Font=Enum.Font.FredokaOne,TextXAlignment=Enum.TextXAlignment.Center,Name="Value"}), "Text")}), "Main");
				local BindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {Size=UDim2.new(1, 0, 0, 38),Parent=ItemParent}), {AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 15), {Size=UDim2.new(1, -12, 1, 0),Position=UDim2.new(0, 12, 0, 0),Font=Enum.Font.FredokaOne,Name="Content"}), "Text"),AddThemeObject(MakeElement("Stroke"), "Stroke"),BindBox,Click}), "Second");
				AddConnection(BindBox.Value:GetPropertyChangedSignal("Text"), function()
					TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size=UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)}):Play();
				end);
				AddConnection(Click.InputEnded, function(Input)
					if ((Input.UserInputType == Enum.UserInputType.MouseButton1) or (Input.UserInputType == Enum.UserInputType.Touch)) then
						local FlatIdent_77478 = 0;
						while true do
							if (FlatIdent_77478 == 0) then
								if Bind.Binding then
									return;
								end
								Bind.Binding = true;
								FlatIdent_77478 = 1;
							end
							if (1 == FlatIdent_77478) then
								BindBox.Value.Text = "";
								break;
							end
						end
					end
				end);
				AddConnection(UserInputService.InputBegan, function(Input)
					local FlatIdent_145D2 = 0;
					while true do
						if (FlatIdent_145D2 == 0) then
							if UserInputService:GetFocusedTextBox() then
								return;
							end
							if (((Input.KeyCode.Name == Bind.Value) or (Input.UserInputType.Name == Bind.Value)) and not Bind.Binding) then
								if BindConfig.Hold then
									local FlatIdent_6D884 = 0;
									while true do
										if (0 == FlatIdent_6D884) then
											Holding = true;
											BindConfig.Callback(Holding);
											break;
										end
									end
								else
									BindConfig.Callback();
								end
							elseif Bind.Binding then
								local FlatIdent_5AA23 = 0;
								local Key;
								while true do
									if (FlatIdent_5AA23 == 0) then
										Key = nil;
										pcall(function()
											if not CheckKey(BlacklistedKeys, Input.KeyCode) then
												Key = Input.KeyCode;
											end
										end);
										FlatIdent_5AA23 = 1;
									end
									if (FlatIdent_5AA23 == 2) then
										Bind:Set(Key);
										SaveCfg(game.GameId);
										break;
									end
									if (FlatIdent_5AA23 == 1) then
										pcall(function()
											if (CheckKey(WhitelistedMouse, Input.UserInputType) and not Key) then
												Key = Input.UserInputType;
											end
										end);
										Key = Key or Bind.Value;
										FlatIdent_5AA23 = 2;
									end
								end
							end
							break;
						end
					end
				end);
				AddConnection(UserInputService.InputEnded, function(Input)
					if ((Input.KeyCode.Name == Bind.Value) or (Input.UserInputType.Name == Bind.Value)) then
						if (BindConfig.Hold and Holding) then
							local FlatIdent_1512 = 0;
							while true do
								if (0 == FlatIdent_1512) then
									Holding = false;
									BindConfig.Callback(Holding);
									break;
								end
							end
						end
					end
				end);
				AddConnection(Click.MouseEnter, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 3)}):Play();
				end);
				AddConnection(Click.MouseLeave, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play();
				end);
				AddConnection(Click.MouseButton1Up, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 3)}):Play();
				end);
				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 6, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 6, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 6)}):Play();
				end);
				Bind.Set = function(self, Key)
					Bind.Binding = false;
					Bind.Value = Key or Bind.Value;
					Bind.Value = Bind.Value.Name or Bind.Value;
					BindBox.Value.Text = Bind.Value;
				end;
				Bind:Set(BindConfig.Default);
				if BindConfig.Flag then
					OrionLib.Flags[BindConfig.Flag] = Bind;
				end
				return Bind;
			end;
			ElementFunction.AddTextbox = function(self, TextboxConfig)
				TextboxConfig = TextboxConfig or {};
				TextboxConfig.Name = TextboxConfig.Name or "Textbox";
				TextboxConfig.Default = TextboxConfig.Default or "";
				TextboxConfig.TextDisappear = TextboxConfig.TextDisappear or false;
				TextboxConfig.Callback = TextboxConfig.Callback or function()
				end;
				local Click = SetProps(MakeElement("Button"), {Size=UDim2.new(1, 0, 1, 0)});
				local TextboxActual = AddThemeObject(Create("TextBox", {Size=UDim2.new(1, 0, 1, 0),BackgroundTransparency=1,TextColor3=Color3.fromRGB(255, 255, 255),PlaceholderColor3=Color3.fromRGB(210, 210, 210),PlaceholderText="Input",Font=Enum.Font.FredokaOne,TextXAlignment=Enum.TextXAlignment.Center,TextSize=14,ClearTextOnFocus=false}), "Text");
				local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {Size=UDim2.new(0, 24, 0, 24),Position=UDim2.new(1, -12, 0.5, 0),AnchorPoint=Vector2.new(1, 0.5)}), {AddThemeObject(MakeElement("Stroke"), "Stroke"),TextboxActual}), "Main");
				local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {Size=UDim2.new(1, 0, 0, 38),Parent=ItemParent}), {AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 15), {Size=UDim2.new(1, -12, 1, 0),Position=UDim2.new(0, 12, 0, 0),Font=Enum.Font.FredokaOne,Name="Content"}), "Text"),AddThemeObject(MakeElement("Stroke"), "Stroke"),TextContainer,Click}), "Second");
				AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function()
					TweenService:Create(TextContainer, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size=UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)}):Play();
				end);
				AddConnection(TextboxActual.FocusLost, function()
					local FlatIdent_699E4 = 0;
					while true do
						if (FlatIdent_699E4 == 0) then
							TextboxConfig.Callback(TextboxActual.Text);
							if TextboxConfig.TextDisappear then
								TextboxActual.Text = "";
							end
							break;
						end
					end
				end);
				TextboxActual.Text = TextboxConfig.Default;
				AddConnection(Click.MouseEnter, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 3)}):Play();
				end);
				AddConnection(Click.MouseLeave, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=OrionLib.Themes[OrionLib.SelectedTheme].Second}):Play();
				end);
				AddConnection(Click.MouseButton1Up, function()
					local FlatIdent_5AB84 = 0;
					while true do
						if (FlatIdent_5AB84 == 0) then
							TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 3, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 3)}):Play();
							TextboxActual:CaptureFocus();
							break;
						end
					end
				end);
				AddConnection(Click.MouseButton1Down, function()
					TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3=Color3.fromRGB((OrionLib.Themes[OrionLib.SelectedTheme].Second.R * 255) + 6, (OrionLib.Themes[OrionLib.SelectedTheme].Second.G * 255) + 6, (OrionLib.Themes[OrionLib.SelectedTheme].Second.B * 255) + 6)}):Play();
				end);
			end;
			ElementFunction.AddColorpicker = function(self, ColorpickerConfig)
				ColorpickerConfig = ColorpickerConfig or {};
				ColorpickerConfig.Name = ColorpickerConfig.Name or "Colorpicker";
				ColorpickerConfig.Default = ColorpickerConfig.Default or Color3.fromRGB(255, 255, 255);
				ColorpickerConfig.Callback = ColorpickerConfig.Callback or function()
				end;
				ColorpickerConfig.Flag = ColorpickerConfig.Flag or nil;
				ColorpickerConfig.Save = ColorpickerConfig.Save or false;
				local ColorH, ColorS, ColorV = 1, 1, 1;
				local Colorpicker = {Value=ColorpickerConfig.Default,Toggled=false,Type="Colorpicker",Save=ColorpickerConfig.Save};
				local ColorSelection = Create("ImageLabel", {Size=UDim2.new(0, 18, 0, 18),Position=UDim2.new(select(3, Color3.toHSV(Colorpicker.Value))),ScaleType=Enum.ScaleType.Fit,AnchorPoint=Vector2.new(0.5, 0.5),BackgroundTransparency=1,Image="http://www.roblox.com/asset/?id=4805639000"});
				local HueSelection = Create("ImageLabel", {Size=UDim2.new(0, 18, 0, 18),Position=UDim2.new(0.5, 0, 1 - select(1, Color3.toHSV(Colorpicker.Value))),ScaleType=Enum.ScaleType.Fit,AnchorPoint=Vector2.new(0.5, 0.5),BackgroundTransparency=1,Image="http://www.roblox.com/asset/?id=4805639000"});
				local Color = Create("ImageLabel", {Size=UDim2.new(1, -25, 1, 0),Visible=false,Image="rbxassetid://124481197674432"}, {Create("UICorner", {CornerRadius=UDim.new(0, 5)}),ColorSelection});
				local Hue = Create("Frame", {Size=UDim2.new(0, 20, 1, 0),Position=UDim2.new(1, -20, 0, 0),Visible=false}, {Create("UIGradient", {Rotation=270,Color=ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),ColorSequenceKeypoint.new(0.2, Color3.fromRGB(234, 255, 0)),ColorSequenceKeypoint.new(0.4, Color3.fromRGB(21, 255, 0)),ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 17, 255)),ColorSequenceKeypoint.new(0.9, Color3.fromRGB(255, 0, 251)),ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4))})}),Create("UICorner", {CornerRadius=UDim.new(0, 5)}),HueSelection});
				local ColorpickerContainer = Create("Frame", {Position=UDim2.new(0, 0, 0, 32),Size=UDim2.new(1, 0, 1, -32),BackgroundTransparency=1,ClipsDescendants=true}, {Hue,Color,Create("UIPadding", {PaddingLeft=UDim.new(0, 35),PaddingRight=UDim.new(0, 35),PaddingBottom=UDim.new(0, 10),PaddingTop=UDim.new(0, 17)})});
				local Click = SetProps(MakeElement("Button"), {Size=UDim2.new(1, 0, 1, 0)});
				local ColorpickerBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 4), {Size=UDim2.new(0, 24, 0, 24),Position=UDim2.new(1, -12, 0.5, 0),AnchorPoint=Vector2.new(1, 0.5)}), {AddThemeObject(MakeElement("Stroke"), "Stroke")}), "Main");
				local ColorpickerFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 5), {Size=UDim2.new(1, 0, 0, 38),Parent=ItemParent}), {SetProps(SetChildren(MakeElement("TFrame"), {AddThemeObject(SetProps(MakeElement("Label", ColorpickerConfig.Name, 15), {Size=UDim2.new(1, -12, 1, 0),Position=UDim2.new(0, 12, 0, 0),Font=Enum.Font.FredokaOne,Name="Content"}), "Text"),ColorpickerBox,Click,AddThemeObject(SetProps(MakeElement("Frame"), {Size=UDim2.new(1, 0, 0, 1),Position=UDim2.new(0, 0, 1, -1),Name="Line",Visible=false}), "Stroke")}), {Size=UDim2.new(1, 0, 0, 38),ClipsDescendants=true,Name="F"}),ColorpickerContainer,AddThemeObject(MakeElement("Stroke"), "Stroke")}), "Second");
				AddConnection(Click.MouseButton1Click, function()
					local FlatIdent_98327 = 0;
					while true do
						if (FlatIdent_98327 == 0) then
							Colorpicker.Toggled = not Colorpicker.Toggled;
							TweenService:Create(ColorpickerFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size=((Colorpicker.Toggled and UDim2.new(1, 0, 0, 148)) or UDim2.new(1, 0, 0, 38))}):Play();
							FlatIdent_98327 = 1;
						end
						if (2 == FlatIdent_98327) then
							ColorpickerFrame.F.Line.Visible = Colorpicker.Toggled;
							break;
						end
						if (FlatIdent_98327 == 1) then
							Color.Visible = Colorpicker.Toggled;
							Hue.Visible = Colorpicker.Toggled;
							FlatIdent_98327 = 2;
						end
					end
				end);
				local function UpdateColorPicker()
					local FlatIdent_14716 = 0;
					while true do
						if (1 == FlatIdent_14716) then
							Colorpicker:Set(ColorpickerBox.BackgroundColor3);
							ColorpickerConfig.Callback(ColorpickerBox.BackgroundColor3);
							FlatIdent_14716 = 2;
						end
						if (0 == FlatIdent_14716) then
							ColorpickerBox.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV);
							Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1);
							FlatIdent_14716 = 1;
						end
						if (FlatIdent_14716 == 2) then
							SaveCfg(game.GameId);
							break;
						end
					end
				end
				ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y);
				ColorS = math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X;
				ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y);
				AddConnection(Color.InputBegan, function(input)
					if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
						if ColorInput then
							ColorInput:Disconnect();
						end
						ColorInput = AddConnection(RunService.RenderStepped, function()
							local FlatIdent_1691A = 0;
							local ColorX;
							local ColorY;
							while true do
								if (FlatIdent_1691A == 0) then
									ColorX = math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X;
									ColorY = math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y;
									FlatIdent_1691A = 1;
								end
								if (2 == FlatIdent_1691A) then
									ColorV = 1 - ColorY;
									UpdateColorPicker();
									break;
								end
								if (FlatIdent_1691A == 1) then
									ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0);
									ColorS = ColorX;
									FlatIdent_1691A = 2;
								end
							end
						end);
					end
				end);
				AddConnection(Color.InputEnded, function(input)
					if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
						if ColorInput then
							ColorInput:Disconnect();
						end
					end
				end);
				AddConnection(Hue.InputBegan, function(input)
					if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
						if HueInput then
							HueInput:Disconnect();
						end
						HueInput = AddConnection(RunService.RenderStepped, function()
							local FlatIdent_21E03 = 0;
							local HueY;
							while true do
								if (FlatIdent_21E03 == 1) then
									ColorH = 1 - HueY;
									UpdateColorPicker();
									break;
								end
								if (FlatIdent_21E03 == 0) then
									HueY = math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y;
									HueSelection.Position = UDim2.new(0.5, 0, HueY, 0);
									FlatIdent_21E03 = 1;
								end
							end
						end);
					end
				end);
				AddConnection(Hue.InputEnded, function(input)
					if ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch)) then
						if HueInput then
							HueInput:Disconnect();
						end
					end
				end);
				Colorpicker.Set = function(self, Value)
					local FlatIdent_2C7C4 = 0;
					while true do
						if (FlatIdent_2C7C4 == 0) then
							Colorpicker.Value = Value;
							ColorpickerBox.BackgroundColor3 = Colorpicker.Value;
							FlatIdent_2C7C4 = 1;
						end
						if (1 == FlatIdent_2C7C4) then
							ColorpickerConfig.Callback(Colorpicker.Value);
							break;
						end
					end
				end;
				Colorpicker:Set(Colorpicker.Value);
				if ColorpickerConfig.Flag then
					OrionLib.Flags[ColorpickerConfig.Flag] = Colorpicker;
				end
				return Colorpicker;
			end;
			return ElementFunction;
		end
		local ElementFunction = {};
		ElementFunction.AddSection = function(self, SectionConfig)
			local FlatIdent_2C980 = 0;
			local SectionFrame;
			local SectionFunction;
			while true do
				if (FlatIdent_2C980 == 1) then
					AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
						local FlatIdent_61084 = 0;
						while true do
							if (FlatIdent_61084 == 0) then
								SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31);
								SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y);
								break;
							end
						end
					end);
					SectionFunction = {};
					FlatIdent_2C980 = 2;
				end
				if (FlatIdent_2C980 == 2) then
					for i, v in next, GetElements(SectionFrame.Holder) do
						SectionFunction[i] = v;
					end
					return SectionFunction;
				end
				if (FlatIdent_2C980 == 0) then
					SectionConfig.Name = SectionConfig.Name or "Section";
					SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), {Size=UDim2.new(1, 0, 0, 26),Parent=Container}), {AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {Size=UDim2.new(1, -12, 0, 16),Position=UDim2.new(0, 0, 0, 3),Font=Enum.Font.FredokaOne}), "TextDark"),SetChildren(SetProps(MakeElement("TFrame"), {AnchorPoint=Vector2.new(0, 0),Size=UDim2.new(1, 0, 1, -24),Position=UDim2.new(0, 0, 0, 23),Name="Holder"}), {MakeElement("List", 0, 6)})});
					FlatIdent_2C980 = 1;
				end
			end
		end;
		for i, v in next, GetElements(Container) do
			ElementFunction[i] = v;
		end
		if TabConfig.PremiumOnly then
			local FlatIdent_69D54 = 0;
			while true do
				if (FlatIdent_69D54 == 0) then
					for i, v in next, ElementFunction do
						ElementFunction[i] = function()
						end;
					end
					Container:FindFirstChild("UIListLayout"):Destroy();
					FlatIdent_69D54 = 1;
				end
				if (FlatIdent_69D54 == 1) then
					Container:FindFirstChild("UIPadding"):Destroy();
					SetChildren(SetProps(MakeElement("TFrame"), {Size=UDim2.new(1, 0, 1, 0),Parent=ItemParent}), {AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3610239960"), {Size=UDim2.new(0, 18, 0, 18),Position=UDim2.new(0, 15, 0, 15),ImageTransparency=0.4}), "Text"),AddThemeObject(SetProps(MakeElement("Label", "Unauthorised Access", 14), {Size=UDim2.new(1, -38, 0, 14),Position=UDim2.new(0, 38, 0, 18),TextTransparency=0.4}), "Text"),AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4483345875"), {Size=UDim2.new(0, 56, 0, 56),Position=UDim2.new(0, 84, 0, 110)}), "Text"),AddThemeObject(SetProps(MakeElement("Label", "Premium Features", 14), {Size=UDim2.new(1, -150, 0, 14),Position=UDim2.new(0, 150, 0, 112),Font=Enum.Font.FredokaOne}), "Text"),AddThemeObject(SetProps(MakeElement("Label", "This part of the script is locked to Sirius Premium users. Purchase Premium in the Discord server (discord.gg/sirius)", 12), {Size=UDim2.new(1, -200, 0, 14),Position=UDim2.new(0, 150, 0, 138),TextWrapped=true,TextTransparency=0.4}), "Text")});
					break;
				end
			end
		end
		return ElementFunction;
	end;
	return TabFunction;
end;
local Configs_HUB = {Cor_Hub=Color3.fromRGB(15, 15, 15),Cor_Options=Color3.fromRGB(15, 15, 15),Cor_Stroke=Color3.fromRGB(60, 60, 60),Cor_Text=Color3.fromRGB(240, 240, 240),Cor_DarkText=Color3.fromRGB(140, 140, 140),Corner_Radius=UDim.new(0, 4),Text_Font=Enum.Font.FredokaOne};
local TweenService = game:GetService("TweenService");
local function Create(instance, parent, props)
	local FlatIdent_523B3 = 0;
	local new;
	while true do
		if (FlatIdent_523B3 == 0) then
			new = Instance.new(instance, parent);
			if props then
				table.foreach(props, function(prop, value)
					new[prop] = value;
				end);
			end
			FlatIdent_523B3 = 1;
		end
		if (FlatIdent_523B3 == 1) then
			return new;
		end
	end
end
local function SetProps(instance, props)
	if (instance and props) then
		table.foreach(props, function(prop, value)
			instance[prop] = value;
		end);
	end
	return instance;
end
local function Corner(parent, props)
	local FlatIdent_9851B = 0;
	local new;
	while true do
		if (FlatIdent_9851B == 0) then
			new = Create("UICorner", parent);
			new.CornerRadius = Configs_HUB.Corner_Radius;
			FlatIdent_9851B = 1;
		end
		if (FlatIdent_9851B == 1) then
			if props then
				SetProps(new, props);
			end
			return new;
		end
	end
end
local function Stroke(parent, props)
	local FlatIdent_559FF = 0;
	local new;
	while true do
		if (FlatIdent_559FF == 1) then
			new.ApplyStrokeMode = "Border";
			if props then
				SetProps(new, props);
			end
			FlatIdent_559FF = 2;
		end
		if (FlatIdent_559FF == 2) then
			return new;
		end
		if (FlatIdent_559FF == 0) then
			new = Create("UIStroke", parent);
			new.Color = Configs_HUB.Cor_Stroke;
			FlatIdent_559FF = 1;
		end
	end
end
local function CreateTween(instance, prop, value, time, tweenWait)
	local FlatIdent_340E5 = 0;
	local tween;
	while true do
		if (FlatIdent_340E5 == 1) then
			if tweenWait then
				tween.Completed:Wait();
			end
			break;
		end
		if (FlatIdent_340E5 == 0) then
			tween = TweenService:Create(instance, TweenInfo.new(time, Enum.EasingStyle.Linear), {[prop]=value});
			tween:Play();
			FlatIdent_340E5 = 1;
		end
	end
end
local ScreenGui = Create("ScreenGui", Orion);
local Menu_Notifi = Create("Frame", ScreenGui, {Size=UDim2.new(0, 300, 1, 0),Position=UDim2.new(1, 0, 0, 0),AnchorPoint=Vector2.new(1, 0),BackgroundTransparency=1});
local Padding = Create("UIPadding", Menu_Notifi, {PaddingLeft=UDim.new(0, 25),PaddingTop=UDim.new(0, 25),PaddingBottom=UDim.new(0, 50)});
local ListLayout = Create("UIListLayout", Menu_Notifi, {Padding=UDim.new(0, 15),VerticalAlignment="Bottom"});
OrionLib.MakeNotifi = function(self, Configs)
	local FlatIdent_6E23 = 0;
	local Title;
	local text;
	local timewait;
	local Frame1;
	local Frame2;
	local TextLabel;
	local TextButton;
	local FrameSize;
	while true do
		if (FlatIdent_6E23 == 2) then
			TextLabel = Create("TextLabel", Frame2, {Size=UDim2.new(1, -30, 0, 0),Position=UDim2.new(0, 20, 0, TextButton.Size.Y.Offset + 10),TextSize=15,TextColor3=Configs_HUB.Cor_DarkText,TextXAlignment="Left",TextYAlignment="Top",AutomaticSize="Y",Text=text,Font=Configs_HUB.Text_Font,BackgroundTransparency=1,AutomaticSize=Enum.AutomaticSize.Y,TextWrapped=true});
			FrameSize = Create("Frame", Frame2, {Size=UDim2.new(1, 0, 0, 2),BackgroundColor3=Configs_HUB.Cor_Stroke,Position=UDim2.new(0, 2, 0, 30),BorderSizePixel=0});
			Corner(FrameSize);
			Create("Frame", Frame2, {Size=UDim2.new(0, 0, 0, 5),Position=UDim2.new(0, 0, 1, 5),BackgroundTransparency=1});
			FlatIdent_6E23 = 3;
		end
		if (FlatIdent_6E23 == 1) then
			Frame2 = Create("Frame", Frame1, {Size=UDim2.new(0, Menu_Notifi.Size.X.Offset - 50, 0, 0),BackgroundColor3=Configs_HUB.Cor_Hub,Position=UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0),AutomaticSize="Y"});
			Corner(Frame2);
			TextLabel = Create("TextLabel", Frame2, {Size=UDim2.new(1, 0, 0, 25),Font=Configs_HUB.Text_Font,BackgroundTransparency=1,Text=Title,TextSize=20,Position=UDim2.new(0, 20, 0, 5),TextXAlignment="Left",TextColor3=Configs_HUB.Cor_Text});
			TextButton = Create("TextButton", Frame2, {Text="X",Font=Configs_HUB.Text_Font,TextSize=20,BackgroundTransparency=1,TextColor3=Color3.fromRGB(200, 200, 200),Position=UDim2.new(1, -5, 0, 5),AnchorPoint=Vector2.new(1, 0),Size=UDim2.new(0, 25, 0, 25)});
			FlatIdent_6E23 = 2;
		end
		if (FlatIdent_6E23 == 3) then
			task.spawn(function()
				CreateTween(FrameSize, "Size", UDim2.new(0, 0, 0, 2), timewait, true);
			end);
			TextButton.MouseButton1Click:Connect(function()
				local FlatIdent_47A85 = 0;
				while true do
					if (FlatIdent_47A85 == 1) then
						Frame1:Destroy();
						break;
					end
					if (FlatIdent_47A85 == 0) then
						CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true);
						CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true);
						FlatIdent_47A85 = 1;
					end
				end
			end);
			task.spawn(function()
				CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.5, true);
				CreateTween(Frame2, "Position", UDim2.new(), 0.1, true);
				task.wait(timewait);
				if Frame2 then
					local FlatIdent_1B5ED = 0;
					while true do
						if (FlatIdent_1B5ED == 0) then
							CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true);
							CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true);
							FlatIdent_1B5ED = 1;
						end
						if (FlatIdent_1B5ED == 1) then
							Frame1:Destroy();
							break;
						end
					end
				end
			end);
			break;
		end
		if (FlatIdent_6E23 == 0) then
			Title = Configs.Title or "Title!";
			text = Configs.Text or "Notification content... what will it say??";
			timewait = Configs.Time or 5;
			Frame1 = Create("Frame", Menu_Notifi, {Size=UDim2.new(2, 0, 0, 0),BackgroundTransparency=1,AutomaticSize="Y",Name="Title"});
			FlatIdent_6E23 = 1;
		end
	end
end;
OrionLib.Destroy = function(self)
	Orion:Destroy();
end;
return OrionLib;