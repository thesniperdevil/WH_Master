--# assume global class LOG
--# assume global class BUTTON
--# assume global class TEXT
--# assume global class IMAGE
--# assume global class TEXT_BUTTON
--# assume global class FRAME
--# assume global class TEXT_BOX
--# assume global class LIST_VIEW
--# assume global class DUMMY
--# assume global class UTIL
--# assume global class COMPONENTS

--# type global COMPONENT_TYPE = 
--# TEXT | IMAGE | BUTTON | TEXT_BUTTON | FRAME | TEXT_BOX | LIST_VIEW | DUMMY

--# type global BUTTON_TYPE = 
--# "CIRCULAR" | "SQUARE" | "CIRCULAR_TOGGLE" | "SQUARE_TOGGLE"

--# type global TEXT_BUTTON_TYPE = 
--# "TEXT" | "TEXT_TOGGLE" | "TEXT_TOGGLE_SMALL"

--# type global TEXT_TYPE = 
--# "NORMAL" | "WRAPPED" | "TITLE" | "HEADER"


--# assume global class CONTAINER
--# assume global class GAP
--# assume global class FLOW_LAYOUT

--# type global LAYOUT = FLOW_LAYOUT

--# type global FLOW_LAYOUT_TYPE = "VERTICAL" | "HORIZONTAL"

--# type global LIST_SCROLL_DIRECTION = "VERTICAL" | "HORIZONTAL"

--# assume global Log: LOG
--# assume global Text: TEXT
--# assume global Image: IMAGE
--# assume global Button: BUTTON
--# assume global TextButton: TEXT_BUTTON
--# assume global Frame: FRAME
--# assume global TextBox: TEXT_BOX
--# assume global ListView: LIST_VIEW
--# assume global Util: UTIL
--# assume global FlowLayout: FLOW_LAYOUT
--# assume global Dummy: DUMMY
--# assume global Container: CONTAINER

--# assume global TABLES: map<string, map<string, WHATEVER>>
--# assume global write_log: boolean

--# assume LOG.write: function(str: string)

--object creation functions
--# assume BUTTON.new: function(name: string, parent: WHATEVER, form: BUTTON_TYPE, imagePath: string) --> BUTTON
--# assume FRAME.new: function(name: string) --> FRAME
--# assume IMAGE.new: function(name: string, parent: WHATEVER, imagepath: string) --> IMAGE
--# assume TEXT.new: function(name: string, parent: WHATEVER, form: TEXT_TYPE, text: string) --> TEXT
--# assume LIST_VIEW.new: function(name: string, parent: WHATEVER, scroll:LIST_SCROLL_DIRECTION) --> LIST_VIEW
--# assume FLOW_LAYOUT.VERTICAL: FLOW_LAYOUT
--# assume FLOW_LAYOUT.HORIZONTAL: FLOW_LAYOUT
--# assume CONTAINER.new: function(layout: LAYOUT) --> CONTAINER

--utility
--# assume UTIL.getComponentWithName: function(name: string) --> COMPONENT_TYPE
--# assume UTIL.centreComponentOnScreen: function(component: WHATEVER)
--# assume UTIL.centreComponentOnComponent: function(component: WHATEVER, other_component: WHATEVER)    




--button
--# assume BUTTON.MoveTo: method(xPos: number, yPos: number)
--# assume BUTTON.Move: method(XMove: number, yMove: number)
--# assume BUTTON.PositionRelativeTo: method(component: WHATEVER, xDiff: number, yDiff: number)
--# assume BUTTON.Scale: method(factor:number)
--# assume BUTTON.Resize: method(width: number, height: number)
--# assume BUTTON.SetVisible: method(visible: boolean)
--# assume BUTTON.Visible: method() --> boolean
--# assume BUTTON.Position: method() --> (number, number)
--# assume BUTTON.Bounds: method() --> (number, number)
--# assume BUTTON.GetContentComponent: method() --> CA_UIC
--# assume BUTTON.GetPositioningComponent: method() --> CA_UIC
--# assume BUTTON.Delete: method()
--# assume BUTTON.ClearSound: method()
--# assume BUTTON.SetState: method(state: string)
--# assume BUTTON.CurrentState: method() --> string
--# assume BUTTON.IsSelected: method() --> boolean
--# assume BUTTON.RegisterForClick: method(callback: function(context: WHATEVER?))
--# assume BUTTON.SetImage: method(path: string)
--# assume BUTTON.SetDisabled: method(disabled: boolean)

--frame
--# assume FRAME.MoveTo: method(xPos: number, yPos: number)
--# assume FRAME.Move: method(xMove: number, yMove: number)
--# assume FRAME.PositionRelativeTo: method(component: WHATEVER, xDiff: number, yDiff: number)
--# assume FRAME.Scale: method(factor: number)
--# assume FRAME.Position: method() --> (number, number)
--# assume FRAME.Bounds: method() --> (number, number)
--# assume FRAME.XPos: method() --> number
--# assume FRAME.YPos: method() --> number
--# assume FRAME.Width: method() --> number
--# assume FRAME.Height: method() --> number
--# assume FRAME.SetVisible: method(visible: boolean)
--# assume FRAME.Visible: method() --> boolean
--# assume FRAME.GetContentComponent: method() --> CA_UIC
--# assume FRAME.GetPositioningComponent: method() --> CA_UIC
--# assume FRAME.Delete: method()
--# assume FRAME.AddComponent: method(component: CA_UIC | COMPONENT_TYPE)
--# assume FRAME.SetTitle: method(title: string)
--# assume FRAME.AddCloseButton: method(callback: function, cross: WHATEVER?)
--# assume FRAME.GetContentPanel: method() --> CA_UIC

--image
--# assume IMAGE.Resize: method(width: number, height: number)
--# assume IMAGE.PositionRelativeTo: method(component: WHATEVER, xDiff: number, yDiff: number)
--# assume IMAGE.Scale: method(factor: number)
--# assume IMAGE.Move: method(xMove: number, yMove: number)
--text
--# assume TEXT.PositionRelativeTo: method(component: WHATEVER, xDiff: number, yDiff: number)
--# assume TEXT.SetText: method(str: string)
--# assume TEXT.Bounds: method() --> (number, number)
--# assume TEXT.Resize: method(x: number, y: number)
--container
--# assume CONTAINER.AddComponent: method(component: WHATEVER)
--# assume CONTAINER.GetContentComponent: method() --> CA_UIC
--# assume CONTAINER.AddGap: method(num: number)
--# assume CONTAINER.PositionRelativeTo: method(component: WHATEVER, xDiff: number, yDiff: number)

--listview
--# assume LIST_VIEW.AddComponent: method(component: WHATEVER)
--# assume LIST_VIEW.AddContainer: method(container: CONTAINER)
--# assume LIST_VIEW.Bounds: method() --> (number, number)
--# assume LIST_VIEW.Scale: method(factor: number)
--# assume LIST_VIEW.Resize: method(x: number, y: number)