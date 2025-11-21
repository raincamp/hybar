--[[
---@class panel : frame
---@field config_panel frame


---@class config : table
---@field OnDefault fun(self: config)
---@field InitializeVisuals fun(self: config)
---@field parent_panel frame


---@class util : table
---@field SystemMsg fun(msg: string)
---@field SystemMsgEm fun()
---@field SimpleRound fun(num: number, step: number): number
---@field Text fun(parent: frame, text: string, font: string): fontstring
---@field Frame fun(type: string, name: string, parent: frame, template: string?): frame
---@field Checkbox fun(parent: frame, id: string, x: number, y: number, val: string): CheckButton
---@field Slider fun(parent: frame, id: string, x: number, y: number, width: number?, minVal: number, maxVal: number, step: number, label: string?): Slider
---@field Button fun(parent: frame, id: string, x: number, y: number, width: number?, height: number?, text: string?): Button
]] --
