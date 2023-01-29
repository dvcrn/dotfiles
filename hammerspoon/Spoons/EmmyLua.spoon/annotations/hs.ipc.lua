--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Provides Hammerspoon with the ability to create both local and remote message ports for inter-process communication.
--
-- The most common use of this module is to provide support for the command line tool `hs` which can be added to your terminal shell environment with [hs.ipc.cliInstall](#cliInstall).  The command line tool will not work unless the `hs.ipc` module is loaded first, so it is recommended that you add `require("hs.ipc")` to your Hammerspoon `init.lua` file (usually located at ~/.hammerspoon/init.lua) so that it is always available when Hammerspoon is running.
--
-- This module is based heavily on code from Mjolnir by [Steven Degutis](https://github.com/sdegutis/).
---@class hs.ipc
local M = {}
hs.ipc = M

-- Get or set the terminal escape codes used to produce colorized output in the `hs` command line tool
--
-- Parameters:
--  * colors - an optional table or explicit nil specifying the colors to use when colorizing output for the command line tool.  If you specify an explicit nil, the colors will revert to their defaults.  If you specify a table it must contain one or more of the following keys with the terminal key sequence as a string for the value:
--    * initial - this color is used for the initial tagline when starting the command line tool and for output to the Hammerspoon console that is redirected to the instance.  Defaults to "\27[35m" (foreground magenta).
--    * input   - this color is used for input typed in by the user into the cli instance.  Defaults to "\27[33m" (foreground yellow).
--    * output  - this color is used for output generated by the commands executed within the instance and the results returned.  Defaults to "\27[36m" (foreground cyan).
--    * error   - this color is used for lua errors generated by the commands executed within the instance.  Defaults to "\27[31m" (foreground red).
--
-- Returns:
--  * a table describing the colors used when colorizing output in the `hs` command line tool.
--
-- Notes:
--  * For a brief intro into terminal colors, you can visit a web site like this one [http://jafrog.com/2013/11/23/colors-in-terminal.html](http://jafrog.com/2013/11/23/colors-in-terminal.html)
--  * Lua doesn't support octal escapes in it's strings, so use `\x1b` or `\27` to indicate the `escape` character e.g. `ipc.cliSetColors{ initial = "", input = "\27[33m", output = "\27[38;5;11m" }`
--
--  * Changes made with this function are saved with `hs.settings` with the following labels and will persist through a reload or restart of Hammerspoon: "ipc.cli.color_initial", "ipc.cli.color_input", "ipc.cli.color_output", and "ipc.cli.color_error"
function M.cliColors(colors, ...) end

-- See [hs.ipc.cliColors](#cliColors).
function M.cliGetColors() end

-- Installs the `hs` command line tool
--
-- Parameters:
--  * path - An optional string containing a path to install the tool in. Defaults to `/usr/local`
--  * silent - An optional boolean indicating whether or not to print errors to the Hammerspoon Console
--
-- Returns:
--  * A boolean, true if the tool was successfully installed, otherwise false
--
-- Notes:
--  * If this function fails, it is likely that you have some old/broken symlinks. You can use `hs.ipc.cliUninstall()` to forcibly tidy them up
--  * You may need to pre-create `/usr/local/bin` and `/usr/local/share/man/man1` in a terminal using sudo, and adjust permissions so your login user can write to them
---@return boolean
function M.cliInstall(path, silent, ...) end

-- See [hs.ipc.cliColors](#cliColors).
function M.cliResetColors() end

-- Get or set whether or not the command line tool saves a history of the commands you type.
--
-- Parameters:
--  * state - an optional boolean (default false) specifying whether or not a history of the commands you type into the command line tool should be saved between sessions.
--
-- Returns:
--  * the current, possibly changed, value
--
-- Notes:
--  * If this is enabled, your history is saved in `hs.configDir .. ".cli.history"`, which is usually "~/.hammerspoon/.cli.history".
--  * If you have multiple invocations of the command line tool running at the same time, only the history of the last one cleanly exited is saved; this is a limitation of the readline wrapper Apple has provided for libedit and at present no workaround is known.
--
--  * Changes made with this function are saved with `hs.settings` with the label "ipc.cli.saveHistory" and will persist through a reload or restart of Hammerspoon.
---@return boolean
function M.cliSaveHistory(state, ...) end

-- Get or set whether the maximum number of commands saved when command line tool history saving is enabled.
--
-- Parameters:
--  * size - an optional integer (default 1000) specifying the maximum number of commands to save when [hs.ipc.cliSaveHistory](#cliSaveHistory) is set to true.
--
-- Returns:
--  * the current, possibly changed, value
--
-- Notes:
--  * When [hs.ipc.cliSaveHistory](#cliSaveHistory) is enabled, your history is saved in `hs.configDir .. ".cli.history"`, which is usually "~/.hammerspoon/.cli.history".
--  * If you have multiple invocations of the command line tool running at the same time, only the history of the last one cleanly exited is saved; this is a limitation of the readline wrapper Apple has provided for libedit and at present no workaround is known.
--
--  * Changes made with this function are saved with `hs.settings` with the label "ipc.cli.historyLimit" and will persist through a reload or restart of Hammerspoon.
---@return number
function M.cliSaveHistorySize(size, ...) end

-- See [hs.ipc.cliColors](#cliColors).
function M.cliSetColors(table, ...) end

-- Gets the status of the `hs` command line tool
--
-- Parameters:
--  * path - An optional string containing a path to look for the `hs` tool. Defaults to `/usr/local`
--  * silent - An optional boolean indicating whether or not to print errors to the Hammerspoon Console
--
-- Returns:
--  * A boolean, true if the `hs` command line tool is correctly installed, otherwise false
---@return boolean
function M.cliStatus(path, silent, ...) end

-- Uninstalls the `hs` command line tool
--
-- Parameters:
--  * path - An optional string containing a path to remove the tool from. Defaults to `/usr/local`
--  * silent - An optional boolean indicating whether or not to print errors to the Hammerspoon Console
--
-- Returns:
--  * A boolean, true if the tool was successfully removed, otherwise false
--
-- Notes:
--  * This function used to be very conservative and refuse to remove symlinks it wasn't sure about, but now it will unconditionally remove whatever it finds at `path/bin/hs` and `path/share/man/man1/hs.1`. This is more likely to be useful in situations where this command is actually needed (please open an Issue on GitHub if you disagree!)
---@return boolean
function M.cliUninstall(path, silent, ...) end

-- Deletes the ipcObject, stopping it as well if necessary
--
-- Parameters:
--  * None
--
-- Returns:
--  * None
function M:delete() end

-- Returns whether or not the ipcObject represents a remote or local port
--
-- Parameters:
--  * None
--
-- Returns:
--  * true if the object is a remote port, otherwise false
--
-- Notes:
--  * a remote port can send messages at any time to a local port; a local port can only respond to messages from a remote port
---@return boolean
function M:isRemote() end

-- Returns whether or not the ipcObject port is still valid or not
--
-- Parameters:
--  * None
--
-- Returns:
--  * true if the object is a valid port, otherwise false
---@return boolean
function M:isValid() end

-- Create a new local ipcObject for receiving and responding to messages from a remote port
--
-- Parameters:
--  * name - a string acting as the message port name.
--  * fn   - the callback function which will receive messages.
--
-- Returns:
--  * the ipc object
--
-- Notes:
--  * a remote port can send messages at any time to a local port; a local port can only respond to messages from a remote port
function M.localPort(name, fn, ...) end

-- Returns the name the ipcObject uses for its port when active
--
-- Parameters:
--  * None
--
-- Returns:
--  * the port name as a string
---@return string
function M:name() end

-- Create a new remote ipcObject for sending messages asynchronously to a local port
--
-- Parameters:
--  * name - a string acting as the message port name.
--
-- Returns:
--  * the ipc object
--
-- Notes:
--  * a remote port can send messages at any time to a local port; a local port can only respond to messages from a remote port
function M.remotePort(name, ...) end

-- Sends a message from a remote port to a local port
--
-- Parameters:
--  * data        - any data type which is to be sent to the local port.  The data will be converted into its string representation
--  * msgID       - an integer message ID
--  * waitTimeout - an optional number, default 2.0, representing the number of seconds the method will wait to send the message and then wait for a response.  The method *may* block up to twice this number of seconds, though usually it will be shorter.
--  * oneWay      -  an optional boolean, default false, indicating whether or not to wait for a response.  It this is true, the second returned argument will be nil.
--
-- Returns:
--  * status   - a boolean indicathing whether or not the local port responded before the timeout (true) or if an error or timeout occurred waiting for the response (false)
--  * response - the response from the local port, usually a string, but may be nil if there was no response returned.  If status is false, will contain an error message describing the error.
function M:sendMessage(data, msgID, waitTimeout, oneWay, ...) end

