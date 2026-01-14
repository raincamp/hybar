local _, _hyb = ...

if _hyb.animations then return end

---@class animations : table
---@field FadeIn fun(frame: frame, duration: number?, onFinished: function?)
---@field FadeOut fun(frame: frame, duration: number?, onFinished: function?)
---@field StopFade fun(frame: frame)
local animations = {}

-- Default animation duration in seconds
local DEFAULT_DURATION = 0.3

-- Cache for animation groups per frame
local animationCache = {}

---Get or create animation group for a frame
---@param frame frame
---@return AnimationGroup
local function GetAnimationGroup(frame)
	if animationCache[frame] then
		return animationCache[frame]
	end

	local ag = frame:CreateAnimationGroup()
	local alpha = ag:CreateAnimation("Alpha")

	-- Store reference to alpha animation
	ag.alpha = alpha

	animationCache[frame] = ag
	return ag
end

---Fade a frame in (alpha 0 to 1)
---@param frame frame The frame to fade in
---@param duration number? Duration in seconds (default 0.3)
---@param onFinished function? Callback when animation completes
function animations.FadeIn(frame, duration, onFinished)
	local ag = GetAnimationGroup(frame)

	-- Stop any existing animation
	ag:Stop()

	local alpha = ag.alpha
	alpha:SetFromAlpha(0)
	alpha:SetToAlpha(1)
	alpha:SetDuration(duration or DEFAULT_DURATION)
	alpha:SetSmoothing("OUT")

	-- Set frame visible and start from 0
	frame:SetAlpha(0)
	frame:Show()

	-- Handle completion
	ag:SetScript("OnFinished", function()
		frame:SetAlpha(1)
		if onFinished then
			onFinished()
		end
	end)

	ag:Play()
end

---Fade a frame out (alpha 1 to 0)
---@param frame frame The frame to fade out
---@param duration number? Duration in seconds (default 0.3)
---@param onFinished function? Callback when animation completes
function animations.FadeOut(frame, duration, onFinished)
	local ag = GetAnimationGroup(frame)

	-- Stop any existing animation
	ag:Stop()

	local alpha = ag.alpha
	alpha:SetFromAlpha(1)
	alpha:SetToAlpha(0)
	alpha:SetDuration(duration or DEFAULT_DURATION)
	alpha:SetSmoothing("IN")

	-- Ensure frame starts fully visible
	frame:SetAlpha(1)

	-- Handle completion
	ag:SetScript("OnFinished", function()
		frame:SetAlpha(0)
		frame:Hide()
		if onFinished then
			onFinished()
		end
	end)

	ag:Play()
end

---Stop any running fade animation on a frame
---@param frame frame The frame to stop animating
function animations.StopFade(frame)
	if animationCache[frame] then
		animationCache[frame]:Stop()
	end
end

-- Cache for flash textures per frame
local flashTextureCache = {}

---Flash a frame with a brief highlight effect
---@param frame frame The frame to flash
---@param color table? RGB color {r, g, b} (default cyan)
---@param duration number? Duration in seconds (default 0.2)
function animations.Flash(frame, color, duration)
	color = color or { 0, 1, 1 }
	duration = duration or 0.2

	-- Get or create flash texture
	local flashTexture = flashTextureCache[frame]
	if not flashTexture then
		flashTexture = frame:CreateTexture(nil, "OVERLAY")
		flashTexture:SetAllPoints(frame)
		flashTexture:SetBlendMode("ADD")
		flashTextureCache[frame] = flashTexture
	end

	-- Set color and show
	flashTexture:SetColorTexture(color[1], color[2], color[3], 0.5)
	flashTexture:Show()

	-- Get or create animation group for flash
	local flashAnim = flashTexture.flashAnim
	if not flashAnim then
		flashAnim = flashTexture:CreateAnimationGroup()
		local fadeOut = flashAnim:CreateAnimation("Alpha")
		fadeOut:SetFromAlpha(0.5)
		fadeOut:SetToAlpha(0)
		fadeOut:SetSmoothing("OUT")
		flashAnim.fadeOut = fadeOut
		flashTexture.flashAnim = flashAnim
	end

	flashAnim:Stop()
	flashAnim.fadeOut:SetDuration(duration)
	flashAnim:SetScript("OnFinished", function()
		flashTexture:Hide()
	end)
	flashAnim:Play()
end

_hyb.animations = animations
