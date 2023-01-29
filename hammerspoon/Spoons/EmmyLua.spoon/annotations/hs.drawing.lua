--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- DEPRECATED. Primitives for drawing on the screen in various ways.
--
-- hs.drawing is now deprecated and will be removed in a future release. Its functionality is now implemented by hs.canvas and you should migrate your code to using that directly. The API docs for hs.drawing remain here as a convenience.
---@class hs.drawing
local M = {}
hs.drawing = M

-- Get the alpha level of the window containing the hs.drawing object.
--
-- Parameters:
--  * None
--
-- Returns:
--  * The current alpha level for the hs.drawing object
---@return number
function M:alpha() end

-- Creates a new image object with the icon of a given app
--
-- Parameters:
--  * sizeRect - A rect-table containing the location/size of the image. If the size values are -1 then the image will be displayed at the icon's native size
--  * bundleID - A string containing the bundle identifier of an app (e.g. "com.apple.Safari")
--
-- Returns:
--  * An `hs.drawing` object, or nil if an error occurs
function M.appImage(sizeRect, bundleID, ...) end

-- Creates a new arc object
--
-- Parameters:
--  * centerPoint - A point-table containing the center of the circle used to define the arc
--  * radius      - The radius of the circle used to define the arc
--  * startAngle  - The starting angle of the arc, measured in degrees clockwise from the y-axis.
--  * endAngle    - The ending angle of the arc, measured in degrees clockwise from the y-axis.
--
-- Returns:
--  * An `hs.drawing` object, or nil if an error occurs
--
-- Notes:
--  * This constructor is actually a wrapper for the `hs.drawing.ellipticalArc` constructor.
function M.arc(centerPoint, radius, startAngle, endAngle, ...) end

-- Returns the current behavior of the hs.drawing object with respect to Spaces and Exposé for the object.
--
-- Parameters:
--  * None
--
-- Returns:
--  * The numeric representation of the current behaviors for the hs.drawing object
---@return number
function M:behavior() end

-- Returns a table of the labels for the current behaviors of the object.
--
-- Parameters:
--  * None
--
-- Returns:
--  * Returns a table of the labels for the current behaviors with respect to Spaces and Exposé for the object.
function M:behaviorAsLabels() end

-- Places the drawing object on top of normal windows
--
-- Parameters:
--  * aboveEverything - An optional boolean value that controls how far to the front the drawing should be placed. `true` to place the drawing on top of all windows (including the dock and menubar), `false` to place the drawing above normal windows, but below the dock and menubar. Defaults to `false`.
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * As of macOS Sierra and later, if you want a `hs.drawing` object to appear above full-screen windows you must hide the Hammerspoon Dock icon first using: `hs.dockicon.hide()`
function M:bringToFront(aboveEverything, ...) end

-- Creates a new circle object
--
-- Parameters:
--  * sizeRect - A rect-table containing the location/size of the circle
--
-- Returns:
--  * An `hs.drawing` object, or nil if an error occurs
function M.circle(sizeRect, ...) end

-- Get or set whether or not clicking on a drawing with a click callback defined should bring all of Hammerspoon's open windows to the front.
--
-- Parameters:
--  * flag - an optional boolean indicating whether or not clicking on a drawing with a click callback function defined should activate Hammerspoon and bring its windows forward.  Defaults to true.
--
-- Returns:
--  * If a setting value is provided, the drawing object is returned; if no argument is provided, the current setting is returned.
--
-- Notes:
--  * Setting this to false changes a drawing object's AXsubrole value and may affect the results of filters defined for hs.window.filter, depending upon how they are defined.
function M:clickCallbackActivating(_false, ...) end

-- Set the screen area in which the drawing contents are visible.
--
-- Parameters:
--  * rect - an optional rectangle specifying the visible area of the screen where the drawing's contents are visible.  If an explicit `nil` is specified, no clipping rectangle is set.  Defaults to nil
--
-- Returns:
--  * if an argument is provided, returns the drawing object; otherwise the current value is returned.
--
-- Notes:
--  * This method can be used to specify the area of the display where this drawing should be visible.  If any portion of the drawing extends beyond this rectangle, the image is clipped so that only the portion within this rectangle is visible.
--  * The rectangle defined by this method is independant of the drawing's actual frame -- if you move the drawing with [hs.drawing:setFrame](#setFrame) or [hs.drawing:setTopLeft](#setTopLeft), this rectangle retains its current value.
--
--  * This method does not work for image objects at present.
function M:clippingRectangle(rect, ...) end

-- Returns a table containing the default font, size, color, and paragraphStyle used by `hs.drawing` for text drawing objects.
--
-- Parameters:
--  * None
--
-- Returns:
--  * a table containing the default style attributes `hs.drawing` uses for text drawing objects in the `hs.styledtext` attributes table format.
--
-- Notes:
--  * This method returns the default font, size, color, and paragraphStyle used by `hs.drawing` for text objects.  If you modify a drawing object's defaults with `hs.drawing:setColor`, `hs.drawing:setTextFont`, or `hs.drawing:setTextSize`, the changes will not be reflected by this function.
function M.defaultTextStyle() end

-- Destroys the drawing object
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
--
-- Notes:
--  * This method immediately destroys the drawing object. If you want it to fade out, use `:hide()` first, with some suitable time, and `hs.timer.doAfter()` to schedule the `:delete()` call
function M:delete() end

-- Tells the OS X window server to pause updating the physical displays for a short while.
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
--
-- Notes:
--  * This method can be used to allow multiple changes which are being made to the users display appear as if they all occur simultaneously by holding off on updating the screen on the regular schedule.
--  * This method should always be balanced with a call to [hs.drawing.enableScreenUpdates](#enableScreenUpdates) when your updates have been completed.  Failure to do so will be logged in the system logs.
--  * The window server will only allow you to pause updates for up to 1 second.  This prevents a rogue or hung process from locking the systems display completely.  Updates will be resumed when [hs.drawing.enableScreenUpdates](#enableScreenUpdates) is encountered or after 1 second, whichever comes first.
--  * The underlying OS function for disabling screen updates is deprecated.
function M.disableScreenUpdates() end

-- Creates a new elliptical arc object
--
-- Parameters:
--  * sizeRect    - A rect-table containing the location and size of the ellipse used to define the arc
--  * startAngle  - The starting angle of the arc, measured in degrees clockwise from the y-axis.
--  * endAngle    - The ending angle of the arc, measured in degrees clockwise from the y-axis.
--
-- Returns:
--  * An `hs.drawing` object, or nil if an error occurs
function M.ellipticalArc(sizeRect, startAngle, endAngle, ...) end

-- Tells the OS X window server to resume updating the physical displays after a previous pause.
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
--
-- Notes:
--  * In conjunction with [hs.drawing.disableScreenUpdates](#disableScreenUpdates), this method can be used to allow multiple changes which are being made to the users display appear as if they all occur simultaneously by holding off on updating the screen on the regular schedule.
--  * The window server will only allow you to pause updates for up to 1 second.  This prevents a rogue or hung process from locking the systems display completely.  Updates will be resumed when this function is encountered  or after 1 second, whichever comes first.
--  * The underlying OS function for enabling screen updates is deprecated.
function M.enableScreenUpdates() end

-- Gets the frame of a drawingObject in absolute coordinates
--
-- Parameters:
--  * None
--
-- Returns:
--  * An `hs.geometry` object containing the frame of the drawing object
---@return hs.geometry
function M:frame() end

-- Gets the text of a drawing object as an `hs.styledtext` object
--
-- Parameters:
--  * None
--
-- Returns:
--  * an `hs.styledtext` object
--
-- Notes:
--  * This method should only be used on text drawing objects
function M:getStyledText() end

-- Get the size of the rectangle necessary to fully render the text with the specified style so that is will be completely visible.
--
-- Parameters:
--  * styledTextObject - an object created with the hs.styledtext module or its table representation (see `hs.styledtext`).
--  * textStyle - an optional table containing one or more of the following keys to set for the text of the drawing object (if textStyle is nil or missing, the `hs.drawing` defaults are used):
--
-- Returns:
--  * sizeTable - a table containing the Height and Width necessary to fully display the text drawing object, or nil if an error occurred
--
-- Notes:
--  * This function assumes the default values specified for any key which is not included in the provided textStyle.
--  * The size returned is an approximation and may return a width that is off by about 4 points.  Use the returned size as a minimum starting point. Sometimes using the "clip" or "truncateMiddle" lineBreak modes or "justified" alignment will fit, but its safest to add in your own buffer if you have the space in your layout.
--  * Multi-line text (separated by a newline or return) is supported.  The height will be for the multiple lines and the width returned will be for the longest line.
--  * The following simplified style format is supported for use with `hs.drawing:setText` and `hs.drawing.setTextStyle`.
--   * theText   - the text which is to be displayed.
--   * textStyle - a table containing one or more of the following keys to set for the text of the drawing object (if textStyle is nil or missing, the `hs.drawing` defaults are used):
--     * font      - the name of the font to use (default: the system font)
--     * size      - the font point size to use (default: 27.0)
--     * color     - ignored, but accepted for compatibility with `hs.drawing:setTextStyle()`
--     * alignment - a string of one of the following indicating the texts alignment within the drawing objects frame:
--       * "left"      - the text is visually left aligned.
--       * "right"     - the text is visually right aligned.
--       * "center"    - the text is visually center aligned.
--       * "justified" - the text is justified
--       * "natural"   - (default) the natural alignment of the text’s script
--     * lineBreak - a string of one of the following indicating how to wrap text which exceeds the drawing object's frame:
--       * "wordWrap"       - (default) wrap at word boundaries, unless the word itself doesn’t fit on a single line
--       * "charWrap"       - wrap before the first character that doesn’t fit
--       * "clip"           - do not draw past the edge of the drawing object frame
--       * "truncateHead"   - the line is displayed so that the end fits in the frame and the missing text at the beginning of the line is indicated by an ellipsis
--       * "truncateTail"   - the line is displayed so that the beginning fits in the frame and the missing text at the end of the line is indicated by an ellipsis
--       * "truncateMiddle" - the line is displayed so that the beginning and end fit in the frame and the missing text in the middle is indicated by an ellipsis
function M.getTextDrawingSize(styledTextObject_or_theText, textStyle, ...) end

-- Hides the drawing object
--
-- Parameters:
--  * fadeOut - An optional number of seconds over which to fade out the drawing object. Defaults to zero
--
-- Returns:
--  * The drawing object
function M:hide(fadeOutTime, ...) end

-- Creates a new image object
--
-- Parameters:
--  * sizeRect - A rect-table containing the location/size of the image
--  * imageData - This can be either:
--   * An `hs.image` object
--   * A string containing a path to an image file
--   * A string beginning with `ASCII:` which signifies that the rest of the string is interpreted as a special form of ASCII diagram, which will be rendered to an image. See the notes below for information about the special format of ASCII diagram.
--
-- Returns:
--  * An `hs.drawing` object, or nil if an error occurs
--  * Paths relative to the PWD of Hammerspoon (typically ~/.hammerspoon/) will work, but paths relative to the UNIX homedir character, `~` will not
--  * Animated GIFs are supported. They're not super friendly on your CPU, but they work
--
-- Notes:
--  * To use the ASCII diagram image support, see http://cocoamine.net/blog/2015/03/20/replacing-photoshop-with-nsstring/ and be sure to preface your ASCII diagram with the special string `ASCII:`
function M.image(sizeRect, imageData, ...) end

-- Get or set the alignment of an image that doesn't fully fill the drawing objects frame.
--
-- Parameters:
--  * type - an optional string value which should match one of the following (default is center):
--    * topLeft      - the image's top left corner will match the drawing frame's top left corner
--    * top          - the image's top match the drawing frame's top and will be centered horizontally
--    * topRight     - the image's top right corner will match the drawing frame's top right corner
--    * left         - the image's left side will match the drawing frame's left side and will be centered vertically
--    * center       - the image will be centered vertically and horizontally within the drawing frame
--    * right        - the image's right side will match the drawing frame's right side and will be centered vertically
--    * bottomLeft   - the image's bottom left corner will match the drawing frame's bottom left corner
--    * bottom       - the image's bottom match the drawing frame's bottom and will be centered horizontally
--    * bottomRight  - the image's bottom right corner will match the drawing frame's bottom right corner
--
-- Returns:
--  * If a setting value is provided, the drawing object is returned; if no argument is provided, the current setting is returned.
function M:imageAlignment(type, ...) end

-- Get or set whether or not an animated GIF image should cycle through its animation.
--
-- Parameters:
--  * flag - an optional boolean flag indicating whether or not an animated GIF image should cycle through its animation.  Defaults to true.
--
-- Returns:
--  * If a setting value is provided, the drawing object is returned; if no argument is provided, the current setting is returned.
function M:imageAnimates(flag, ...) end

-- Get or set what type of frame should be around the drawing frame of the image.
--
-- Parameters:
--  * type - an optional string value which should match one of the following (default is none):
--    * none   - no frame is drawing around the drawingObject's frameRect
--    * photo  - a thin black outline with a white background and a dropped shadow.
--    * bezel  - a gray, concave bezel with no background that makes the image look sunken.
--    * groove - a thin groove with a gray background that looks etched around the image.
--    * button - a convex bezel with a gray background that makes the image stand out in relief, like a button.
--
-- Returns:
--  * If a setting value is provided, the drawing object is returned; if no argument is provided, the current setting is returned.
--
-- Notes:
--  * Apple considers the photo, groove, and button style frames "stylistically obsolete" and if a frame is required, recommend that you use the bezel style or draw your own to more closely match the OS look and feel.
function M:imageFrame(type, ...) end

-- Get or set how an image is scaled within the frame of a drawing object containing an image.
--
-- Parameters:
--  * type - an optional string value which should match one of the following (default is scaleProportionally):
--    * shrinkToFit         - shrink the image, preserving the aspect ratio, to fit the drawing frame only if the image is larger than the drawing frame.
--    * scaleToFit          - shrink or expand the image to fully fill the drawing frame.  This does not preserve the aspect ratio.
--    * none                - perform no scaling or resizing of the image.
--    * scalePropertionally - shrink or expand the image to fully fill the drawing frame, preserving the aspect ration.
--
-- Returns:
--  * If a setting value is provided, the drawing object is returned; if no argument is provided, the current setting is returned.
function M:imageScaling(type, ...) end

-- Creates a new line object
--
-- Parameters:
--  * originPoint - A point-table containing the co-ordinates of the starting point of the line
--  * endPoint - A point-table containing the co-ordinates of the end point of the line
--
-- Returns:
--  * An `hs.drawing` object, or nil if an error occurs
function M.line(originPoint, endPoint, ...) end

-- Moves drawing object above drawing object2, or all drawing objects in the same presentation level, if object2 is not provided.
--
-- Parameters:
--  * Optional drawing object to place the drawing object above.
--
-- Returns:
--  * The `hs.drawing` object
function M:orderAbove(object2, ...) end

-- Moves drawing object below drawing object2, or all drawing objects in the same presentation level, if object2 is not provided.
--
-- Parameters:
--  * Optional drawing object to place the drawing object below.
--
-- Returns:
--  * The `hs.drawing` object
function M:orderBelow(object2, ...) end

-- Creates a new rectangle object
--
-- Parameters:
--  * sizeRect - A rect-table containing the location/size of the rectangle
--
-- Returns:
--  * An `hs.drawing` object, or nil if an error occurs
function M.rectangle(sizeRect, ...) end

-- Rotates an image clockwise around its center
--
-- Parameters:
--  * angle - the angle in degrees to rotate the image around its center in a clockwise direction.
--
-- Returns:
--  * The drawing object
--
-- Notes:
-- * This method works by rotating the image view within its drawing window.  This means that an image which completely fills its viewing area will most likely be cropped in some places.  Best results are achieved with images that have clear space around their edges or with `hs.drawing.imageScaling` set to "none".
function M:rotateImage(angle, ...) end

-- Places the drawing object behind normal windows, between the desktop wallpaper and desktop icons
--
-- Parameters:
--  * None
--
-- Returns:
--  * The drawing object
function M:sendToBack() end

-- Sets the alpha level of the window containing the hs.drawing object.
--
-- Parameters:
--  * level - the alpha level (0.0 - 1.0) to set the object to
--
-- Returns:
--  * The `hs.drawing` object
function M:setAlpha(level, ...) end

-- Changes the starting and ending angles for an arc drawing object
--
-- Parameters:
--  * startAngle  - The starting angle of the arc, measured in degrees clockwise from the y-axis.
--  * endAngle    - The ending angle of the arc, measured in degrees clockwise from the y-axis.
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on arc drawing objects
function M:setArcAngles(startAngle, endAngle, ...) end

-- Sets the window behaviors represented by the number provided for the window containing the hs.drawing object.
--
-- Parameters:
--  * behavior - the numeric representation of the behaviors to set for the window of the object
--
-- Returns:
--  * The `hs.drawing` object
function M:setBehavior(behavior, ...) end

-- Sets the window behaviors based upon the labels specified in the table provided.
--
-- Parameters:
--  * a table of label strings or numbers.  Recognized values can be found in `hs.drawing.windowBehaviors`.
--
-- Returns:
--  * The `hs.drawing` object
function M:setBehaviorByLabels(table, ...) end

-- Sets a callback for mouseUp and mouseDown click events
--
-- Parameters:
--  * mouseUpFn - A function, can be nil, that will be called when the drawing object is clicked on and the mouse button is released. If this argument is nil, any existing callback is removed.
--  * mouseDownFn - A function, can be nil, that will be called when the drawing object is clicked on and the mouse button is first pressed down. If this argument is nil, any existing callback is removed.
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * No distinction is made between the left, right, or other mouse buttons -- they all invoke the same up or down function.  If you need to determine which specific button was pressed, use `hs.eventtap.checkMouseButtons()` within your callback to check.
function M:setClickCallback(mouseUpFn, mouseDownFn, ...) end

-- Sets whether or not to fill a drawing object
--
-- Parameters:
--  * doFill - A boolean, true to fill the drawing object, false to not fill
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on line, rectangle, circle, or arc drawing objects
function M:setFill(doFill, ...) end

-- Sets the fill color of a drawing object
--
-- Parameters:
--  * color - a color table as described in `hs.drawing.color`
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on rectangle, circle, or arc drawing objects
--  * Calling this method will remove any gradient fill colors previously set with `hs.drawing:setFillGradient()`
function M:setFillColor(color, ...) end

-- Sets the fill gradient of a drawing object
--
-- Parameters:
--  * startColor - A table containing color component values between 0.0 and 1.0 for each of the keys:
--    * red (default 0.0)
--    * green (default 0.0)
--    * blue (default 0.0)
--    * alpha (default 1.0)
--  * endColor - A table containing color component values between 0.0 and 1.0 for each of the keys:
--    * red (default 0.0)
--    * green (default 0.0)
--    * blue (default 0.0)
--    * alpha (default 1.0)
--  * angle - A number representing the angle of the gradient, measured in degrees, counter-clockwise, from the left of the drawing object
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on rectangle, circle, or arc drawing objects
--  * Calling this method will remove any fill color previously set with `hs.drawing:setFillColor()`
function M:setFillGradient(startColor, endColor, angle, ...) end

-- Sets the frame of the drawingObject in absolute coordinates
--
-- Parameters:
--  * rect - A rect-table containing the co-ordinates and size that should be applied to the drawingObject
--
-- Returns:
--  * The drawing object
function M:setFrame(rect, ...) end

-- Sets the image of a drawing object
--
-- Parameters:
--  * image - An `hs.image` object
--
-- Returns:
--  * The drawing object
function M:setImage(image, ...) end

-- Sets the image of a drawing object from an ASCII representation
--
-- Parameters:
--  * ascii - A string containing the ASCII image to render
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * To use the ASCII diagram image support, see http://cocoamine.net/blog/2015/03/20/replacing-photoshop-with-nsstring
function M:setImageASCII(ascii, ...) end

-- Sets the image path of a drawing object
--
-- Parameters:
--  * imagePath - A string containing the path to an image file
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on an image drawing object
--  * Paths relative to the PWD of Hammerspoon (typically ~/.hammerspoon/) will work, but paths relative to the UNIX homedir character, `~` will not
--  * Animated GIFs are supported. They're not super friendly on your CPU, but they work
function M:setImageFromPath(imagePath, ...) end

-- Sets the window level more precisely than sendToBack and bringToFront.
--
-- Parameters:
--  * theLevel - the level specified as a number or as a string where this object should be drawn.  If it is a string, it must match one of the keys in `hs.drawing.windowLevels`.
--
-- Returns:
--  * the drawing object
--
-- Notes:
--  * see the notes for `hs.drawing.windowLevels`
--  * These levels may be unable to explicitly place drawing objects around full-screen macOS windows
function M:setLevel(theLevel, ...) end

-- Sets the radii of the corners of a rectangle drawing object
--
-- Parameters:
--  * xradius - A number containing the radius of each corner along the x-axis
--  * yradius - A number containing the radius of each corner along the y-axis
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on rectangle drawing objects
--  * If either radius value is greater than half the width/height (as appropriate) of the rectangle, the value will be clamped at half the width/height
--  * If either (or both) radius values are 0, the rectangle will be drawn without rounded corners
function M:setRoundedRectRadii(xradius, yradius, ...) end

-- Resizes a drawing object
--
-- Parameters:
--  * size - A size-table containing the width and height the drawing object should be resized to
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * If this is called on an `hs.drawing.text` object, only its window will be resized. If you also want to change the font size, use `:setTextSize()`
function M:setSize(size, ...) end

-- Sets whether or not to stroke a drawing object
--
-- Parameters:
--  * doStroke - A boolean, true to stroke the drawing object, false to not stroke
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on line, rectangle, circle, or arc drawing objects
function M:setStroke(doStroke, ...) end

-- Sets the stroke color of a drawing object
--
-- Parameters:
--  * color - a color table as described in `hs.drawing.color`
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on line, rectangle, circle, or arc drawing objects
function M:setStrokeColor(color, ...) end

-- Sets the stroke width of a drawing object
--
-- Parameters:
--  * width - A number containing the width in points to stroke a drawing object
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on line, rectangle, circle, or arc drawing objects
function M:setStrokeWidth(width, ...) end

-- Sets the text of a drawing object from an `hs.styledtext` object
--
-- Parameters:
--  * message - Any of the types supported by `hs.styledtext`.  See `hs.styledtext` for more details.
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on text drawing objects
function M:setStyledText(message, ...) end

-- Sets the text of a drawing object
--
-- Parameters:
--  * message - A string containing the text to display
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on text drawing objects
--  * If the text of the drawing object is emptied (i.e. "") then style changes may be lost.  Use a placeholder such as a space (" ") or hide the object if style changes need to be saved but the text should disappear for a while.
function M:setText(message, ...) end

-- Sets the default text color for a drawing object
--
-- Parameters:
--  * color - a color table as described in `hs.drawing.color`
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be called on text drawing objects
--  * This method changes the font color for portions of an `hs.drawing` text object which do not have a specific font set in their attributes list (see `hs.styledtext` for more details).
function M:setTextColor(color, ...) end

-- Sets the default font for a drawing object
--
-- Parameters:
--  * fontname - A string containing the name of the font to use
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on text drawing objects
--  * This method changes the font for portions of an `hs.drawing` text object which do not have a specific font set in their attributes list (see `hs.styledtext` for more details).
function M:setTextFont(fontname, ...) end

-- Sets the default text size for a drawing object
--
-- Parameters:
--  * size - A number containing the font size to use
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on text drawing objects
--  * This method changes the font size for portions of an `hs.drawing` text object which do not have a specific font set in their attributes list (see `hs.styledtext` for more details).
function M:setTextSize(size, ...) end

-- Sets some simple style parameters for the entire text of a drawing object.  For more control over style including having multiple styles within a single text object, use `hs.styledtext` and `hs.drawing:setStyledText` instead.
--
-- Parameters:
--  * textStyle - an optional table containing one or more of the following keys to set for the text of the drawing object (if the table is nil or left out, the style is reset to the `hs.drawing` defaults):
--    * font      - the name of the font to use (default: the system font)
--    * size      - the font point size to use (default: 27.0)
--    * color     - a color table as described in `hs.drawing.color`
--    * alignment - a string of one of the following indicating the texts alignment within the drawing objects frame:
--      * "left"      - the text is visually left aligned.
--      * "right"     - the text is visually right aligned.
--      * "center"    - the text is visually center aligned.
--      * "justified" - the text is justified
--      * "natural"   - (default) the natural alignment of the text’s script
--    * lineBreak - a string of one of the following indicating how to wrap text which exceeds the drawing object's frame:
--      * "wordWrap"       - (default) wrap at word boundaries, unless the word itself doesn’t fit on a single line
--      * "charWrap"       - wrap before the first character that doesn’t fit
--      * "clip"           - do not draw past the edge of the drawing object frame
--      * "truncateHead"   - the line is displayed so that the end fits in the frame and the missing text at the beginning of the line is indicated by an ellipsis
--      * "truncateTail"   - the line is displayed so that the beginning fits in the frame and the missing text at the end of the line is indicated by an ellipsis
--      * "truncateMiddle" - the line is displayed so that the beginning and end fit in the frame and the missing text in the middle is indicated by an ellipsis
--
-- Returns:
--  * The drawing object
--
-- Notes:
--  * This method should only be used on text drawing objects
--  * If the text of the drawing object is currently empty (i.e. "") then style changes may be lost.  Use a placeholder such as a space (" ") or hide the object if style changes need to be saved but the text should disappear for a while.
--  * Only the keys specified are changed.  To reset an object to all of its defaults, call this method with an explicit nil as its only parameter (e.g. `hs.drawing:setTextStyle(nil)`
--  * The font, font size, and font color can also be set by their individual specific methods as well; this method is provided so that style components can be stored and applied collectively, as well as used by `hs.drawing.getTextDrawingSize()` to determine the proper rectangle size for a textual drawing object.
function M:setTextStyle(textStyle, ...) end

-- Moves the drawingObject to a given point
--
-- Parameters:
--  * point - A point-table containing the absolute co-ordinates the drawing object should be moved to
--
-- Returns:
--  * The drawing object
function M:setTopLeft(point, ...) end

-- Displays the drawing object
--
-- Parameters:
--  * fadeInTime - An optional number of seconds over which to fade in the drawing object. Defaults to zero
--
-- Returns:
--  * The drawing object
function M:show(fadeInTime, ...) end

-- Creates a new text object
--
-- Parameters:
--  * sizeRect - A rect-table containing the location/size of the text
--  * message - A string containing the text to be displayed.   May also be any of the types supported by `hs.styledtext`.  See `hs.styledtext` for more details.
--
-- Returns:
--  * An `hs.drawing` object, or nil if an error occurs
function M.text(sizeRect, message, ...) end

-- Array of window behavior labels for determining how an hs.drawing object is handled in Spaces and Exposé
--
-- * default           -- The window can be associated to one space at a time.
-- * canJoinAllSpaces  -- The window appears in all spaces. The menu bar behaves this way.
-- * moveToActiveSpace -- Making the window active does not cause a space switch; the window switches to the active space.
--
-- Only one of these may be active at a time:
--
-- * managed           -- The window participates in Spaces and Exposé. This is the default behavior if windowLevel is equal to NSNormalWindowLevel.
-- * transient         -- The window floats in Spaces and is hidden by Exposé. This is the default behavior if windowLevel is not equal to NSNormalWindowLevel.
-- * stationary        -- The window is unaffected by Exposé; it stays visible and stationary, like the desktop window.
--
-- Notes:
--  * This table has a __tostring() metamethod which allows listing it's contents in the Hammerspoon console by typing `hs.drawing.windowBehaviors`.
---@type table
M.windowBehaviors = {}

-- A table of predefined window levels usable with `hs.drawing:setLevel(...)`
--
-- Predefined levels are:
--  * _MinimumWindowLevelKey - lowest allowed window level
--  * desktop
--  * desktopIcon            - `hs.drawing:sendToBack()` is equivalent to this - 1
--  * normal                 - normal application windows
--  * tornOffMenu
--  * floating               - equivalent to `hs.drawing:bringToFront(false)`, where "Always Keep On Top" windows are usually set
--  * modalPanel             - modal alert dialog
--  * utility
--  * dock                   - level of the Dock
--  * mainMenu               - level of the Menubar
--  * status
--  * popUpMenu              - level of a menu when displayed (open)
--  * overlay
--  * help
--  * dragging
--  * screenSaver            - equivalent to `hs.drawing:bringToFront(true)`
--  * assistiveTechHigh
--  * cursor
--  * _MaximumWindowLevelKey - highest allowed window level
--
-- Notes:
--  * This table has a __tostring() metamethod which allows listing it's contents in the Hammerspoon console by typing `hs.drawing.windowLevels`.
--  * These key names map to the constants used in CoreGraphics to specify window levels and may not actually be used for what the name might suggest. For example, tests suggest that an active screen saver actually runs at a level of 2002, rather than at 1000, which is the window level corresponding to kCGScreenSaverWindowLevelKey.
--  * Each drawing level is sorted separately and `hs.drawing:orderAbove(...)` and hs.drawing:orderBelow(...)` only arrange windows within the same level.
--  * If you use Dock hiding (or in 10.11, Menubar hiding) please note that when the Dock (or Menubar) is popped up, it is done so with an implicit orderAbove, which will place it above any items you may also draw at the Dock (or MainMenu) level.
--
--  * A drawing object with a [hs.drawing:setClickCallback](#setClickCallback) function can only reliably receive mouse click events when its window level is at `hs.drawing.windowLevels.desktopIcon` + 1 or higher.
M.windowLevels = nil

