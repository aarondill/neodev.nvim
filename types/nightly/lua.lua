---@meta



-- Invokes |vim-function| or |user-function| {func} with arguments {...}.
-- See also |vim.fn|.
-- Equivalent to: 
-- ```lua
--     vim.fn[func]({...})
-- ```
--- @param func fun()
function vim.call(func, ...) end

-- Run diff on strings {a} and {b}. Any indices returned by this function,
-- either directly or via callback arguments, are 1-based.
-- 
-- Examples: 
-- ```lua
-- 
--      vim.diff('a\n', 'b\nc\n')
--      -- =>
--      -- @ -1 +1,2 @
--      -- -a
--      -- +b
--      -- +c
-- 
--      vim.diff('a\n', 'b\nc\n', {result_type = 'indices'})
--      -- =>
--      -- {
--      --   {1, 1, 1, 2}
--      -- }
-- ```
-- 
-- Parameters: ~
--   • {a}     (string) First string to compare
--   • {b}     (string) Second string to compare
--   • {opts}  table<string,any> Optional parameters:
--             • `on_hunk` (callback): Invoked for each hunk in the diff. Return a
--               negative number to cancel the callback for any remaining
--               hunks. Args:
--               • `start_a` (integer): Start line of hunk in {a}.
--               • `count_a` (integer): Hunk size in {a}.
--               • `start_b` (integer): Start line of hunk in {b}.
--               • `count_b` (integer): Hunk size in {b}.
-- 
--             • `result_type` (string): Form of the returned diff:
--               • "unified": (default) String in unified format.
--               • "indices": Array of hunk locations. Note: This option is
--                 ignored if `on_hunk` is used.
-- 
--             • `linematch` (boolean|integer): Run linematch on the
--               resulting hunks from xdiff. When integer, only hunks upto
--               this size in lines are run through linematch. Requires
--               `result_type = indices`, ignored otherwise.
--             • `algorithm` (string): Diff algorithm to use. Values:
--               • "myers" the default algorithm
--               • "minimal" spend extra time to generate the smallest
--                 possible diff
--               • "patience" patience diff algorithm
--               • "histogram" histogram diff algorithm
-- 
--             • `ctxlen` (integer): Context length
--             • `interhunkctxlen` (integer): Inter hunk context length
--             • `ignore_whitespace` (boolean): Ignore whitespace
--             • `ignore_whitespace_change` (boolean): Ignore whitespace
--               change
--             • `ignore_whitespace_change_at_eol` (boolean) Ignore
--               whitespace change at end-of-line.
--             • `ignore_cr_at_eol` (boolean) Ignore carriage return at
--               end-of-line
--             • `ignore_blank_lines` (boolean) Ignore blank lines
--             • `indent_heuristic` (boolean): Use the indent heuristic for
--               the internal diff library.
-- 
-- Return: ~
--     string|table|nil See {opts.result_type}. `nil` if {opts.on_hunk} is
--     given.
--- @param opts table<string, any>
function vim.diff(a, b, opts) end

-- The result is a String, which is the text {str} converted from encoding
-- {from} to encoding {to}. When the conversion fails `nil` is returned. When
-- some characters could not be converted they are replaced with "?". The
-- encoding names are whatever the iconv() library function can accept, see
-- ":Man 3 iconv".
-- 
-- Parameters: ~
--   • {str}   (string) Text to convert
--   • {from}  (number) Encoding of {str}
--   • {to}    (number) Target encoding
--   • {opts}  table<string,any>|nil
-- 
-- Return: ~
--     (string|nil) Converted string if conversion succeeds, `nil` otherwise.
--- @param str string
--- @param from number
--- @param to number
--- @param opts table<string, any>
function vim.iconv(str, from, to, opts) end

-- Returns true if the code is executing as part of a "fast" event handler,
-- where most of the API is disabled. These are low-level events (e.g.
-- |lua-loop-callbacks|) which can be invoked whenever Nvim polls for input.
-- When this is `false` most API functions are callable (but may be subject
-- to other restrictions such as |textlock|).
function vim.in_fast_event() end

-- Decodes (or "unpacks") the JSON-encoded {str} to a Lua object.
-- 
-- • Decodes JSON "null" as |vim.NIL| (controllable by {opts}, see below).
-- • Decodes empty object as |vim.empty_dict()|.
-- • Decodes empty array as `{}` (empty Lua table).
-- 
-- Example: 
-- ```lua
-- 
--  :lua vim.print(vim.json.decode('{"bar":[],"foo":{},"zub":null}'))
--  --> { bar = {}, foo = vim.empty_dict(), zub = vim.NIL }
-- 
-- ```
--  Parameters: ~ • {str} Stringified JSON data. • {opts} Options map keys: •
-- luanil: { object: bool, array: bool } • `luanil.object=true` converts `null` in JSON objects to Lua `nil` instead of `vim.NIL` . • `luanil.array=true` converts `null` in JSON arrays to Lua `nil` instead of `vim.NIL` .
-- 
-- Parameters: ~
--   • {str}   (string)
--   • {opts}  table<string,|nil any
-- ```lua
-- 
-- Return: ~
--     any
-- ```
--- @param str string
--- @param opts table<string, any>
function vim.json.decode(str, opts) end

-- Encodes (or "packs") Lua object {obj} as JSON in a Lua string.
-- 
-- Parameters: ~
--   • {obj}  any
-- 
-- Return: ~
--     (string)
function vim.json.encode(obj) end

-- Decodes (or "unpacks") the msgpack-encoded {str} to a Lua object.
-- 
-- Parameters: ~
--   • {str}  (string)
--- @param str string
function vim.mpack.decode(str) end

-- Encodes (or "packs") Lua object {obj} as msgpack in a Lua string.
function vim.mpack.encode(obj) end

-- Parse the Vim regex {re} and return a regex object. Regexes are "magic"
-- and case-sensitive by default, regardless of 'magic' and 'ignorecase'.
-- They can be controlled with flags, see |/magic| and |/ignorecase|.
-- 
-- Parameters: ~
--   • {re}  (string)
-- 
-- Return: ~
--     vim.regex
function vim.regex(re) end

-- Sends {event} to {channel} via |RPC| and returns immediately. If {channel}
-- is 0, the event is broadcast to all channels.
-- 
-- This function also works in a fast callback |lua-loop-callbacks|.
-- 
-- Parameters: ~
--   • {channel}  (integer)
--   • {method}   (string)
--   • {args}     any[]|nil
--   • {...}      any|nil
--- @param args any[]
function vim.rpcnotify(channel, method, args, ...) end

-- Sends a request to {channel} to invoke {method} via |RPC| and blocks until
-- a response is received.
-- 
-- Note: NIL values as part of the return value is represented as |vim.NIL|
-- special value
-- 
-- Parameters: ~
--   • {channel}  (integer)
--   • {method}   (string)
--   • {args}     any[]|nil
--   • {...}      any|nil
--- @param args any[]
function vim.rpcrequest(channel, method, args, ...) end

-- Schedules {callback} to be invoked soon by the main event-loop. Useful to
-- avoid |textlock| or other temporary restrictions.
-- 
-- Parameters: ~
--   • {callback}  fun()
--- @param callback fun()
function vim.schedule(callback) end

-- Check {str} for spelling errors. Similar to the Vimscript function
-- |spellbadword()|.
-- 
-- Note: The behaviour of this function is dependent on: 'spelllang',
-- 'spellfile', 'spellcapcheck' and 'spelloptions' which can all be local to
-- the buffer. Consider calling this with |nvim_buf_call()|.
-- 
-- Example: 
-- ```lua
-- 
--      vim.spell.check("the quik brown fox")
--      -- =>
--      -- {
--      --     {'quik', 'bad', 5}
--      -- }
-- ```
-- 
-- Parameters: ~
--   • {str}  (string)
-- 
-- Return: ~
--     `{[1]: string, [2]: string, [3]: string}[]` List of tuples with three items:
--     • The badly spelled word.
--     • The type of the spelling error: "bad" spelling mistake "rare" rare
--       word "local" word only valid in another region "caps" word should
--       start with Capital
--     • The position in {str} where the word begins.
--- @param str string
function vim.spell.check(str) end

-- Convert UTF-32 or UTF-16 {index} to byte index. If {use_utf16} is not
-- supplied, it defaults to false (use UTF-32). Returns the byte index.
-- 
-- Invalid UTF-8 and NUL is treated like by |vim.str_byteindex()|. An {index}
-- in the middle of a UTF-16 sequence is rounded upwards to the end of that
-- sequence.
-- 
-- Parameters: ~
--   • {str}        (string)
--   • {index}      (number)
--   • {use_utf16}  any|nil
--- @param str string
--- @param index number
function vim.str_byteindex(str, index, use_utf16) end

-- Gets the distance (in bytes) from the last byte of the codepoint
-- (character) that {index} points to.
-- 
-- Examples: 
-- ```lua
-- 
--  -- The character 'æ' is stored as the bytes '\xc3\xa6' (using UTF-8)
-- 
--  -- Returns 0 because the index is pointing at the last byte of a character
--  vim.str_utf_end('æ', 2)
-- 
--  -- Returns 1 because the index is pointing at the penultimate byte of a character
--  vim.str_utf_end('æ', 1)
-- ```
-- 
-- Parameters: ~
--   • {str}    (string)
--   • {index}  (number)
-- 
-- Return: ~
--     (number)
--- @param str string
--- @param index number
function vim.str_utf_end(str, index) end

-- Gets a list of the starting byte positions of each UTF-8 codepoint in the
-- given string.
-- 
-- Embedded NUL bytes are treated as terminating the string.
-- 
-- Parameters: ~
--   • {str}  (string)
-- 
-- Return: ~
--     (table)
--- @param str string
function vim.str_utf_pos(str) end

-- Gets the distance (in bytes) from the starting byte of the codepoint
-- (character) that {index} points to.
-- 
-- The result can be added to {index} to get the starting byte of a
-- character.
-- 
-- Examples: 
-- ```lua
-- 
--  -- The character 'æ' is stored as the bytes '\xc3\xa6' (using UTF-8)
-- 
--  -- Returns 0 because the index is pointing at the first byte of a character
--  vim.str_utf_start('æ', 1)
-- 
--  -- Returns -1 because the index is pointing at the second byte of a character
--  vim.str_utf_start('æ', 2)
-- ```
-- 
-- Parameters: ~
--   • {str}    (string)
--   • {index}  (number)
-- 
-- Return: ~
--     (number)
--- @param str string
--- @param index number
function vim.str_utf_start(str, index) end

-- Convert byte index to UTF-32 and UTF-16 indices. If {index} is not
-- supplied, the length of the string is used. All indices are zero-based.
-- 
-- Embedded NUL bytes are treated as terminating the string. Invalid UTF-8
-- bytes, and embedded surrogates are counted as one code point each. An
-- {index} in the middle of a UTF-8 sequence is rounded upwards to the end of
-- that sequence.
-- 
-- Parameters: ~
--   • {str}    (string)
--   • {index}  (number|nil)
-- 
-- Return (multiple): ~
--     (integer) UTF-32 index
--     (integer) UTF-16 index
--- @param str string
--- @param index number
function vim.str_utfindex(str, index) end

-- Compares strings case-insensitively.
-- 
-- Parameters: ~
--   • {a}  (string)
--   • {b}  (string)
-- 
-- Return: ~
--     0|1|-1 if strings are equal, {a} is greater than {b} or {a} is lesser
--     than {b}, respectively.
function vim.stricmp(a, b) end

-- Attach to ui events, similar to |nvim_ui_attach()| but receive events as
-- Lua callback. Can be used to implement screen elements like popupmenu or
-- message handling in Lua.
-- 
-- {options} should be a dictionary-like table, where `ext_...` options
-- should be set to true to receive events for the respective external
-- element.
-- 
-- {callback} receives event name plus additional parameters. See
-- |ui-popupmenu| and the sections below for event format for respective
-- events.
-- 
-- WARNING: This api is considered experimental. Usability will vary for
-- different screen elements. In particular `ext_messages` behavior is
-- subject to further changes and usability improvements. This is expected to
-- be used to handle messages when setting 'cmdheight' to zero (which is
-- likewise experimental).
-- 
-- Example (stub for a |ui-popupmenu| implementation): 
-- ```lua
-- 
--    ns = vim.api.nvim_create_namespace('my_fancy_pum')
-- 
--    vim.ui_attach(ns, {ext_popupmenu=true}, function(event, ...)
--      if event == "popupmenu_show" then
--        local items, selected, row, col, grid = ...
--        print("display pum ", #items)
--      elseif event == "popupmenu_select" then
--        local selected = ...
--        print("selected", selected)
--      elseif event == "popupmenu_hide" then
--        print("FIN")
--      end
--    end)
-- ```
-- 
-- Parameters: ~
--   • {ns}        (integer)
--   • {options}   table<string, any
-- ```lua
--   • {callback}  fun()
-- ```
--- @param ns number
--- @param options table<string, any>
--- @param callback fun()
function vim.ui_attach(ns, options, callback) end

-- Detach a callback previously attached with |vim.ui_attach()| for the given
-- namespace {ns}.
-- 
-- Parameters: ~
--   • {ns}  (integer)
--- @param ns number
function vim.ui_detach(ns) end

-- Wait for {time} in milliseconds until {callback} returns `true`.
-- 
-- Executes {callback} immediately and at approximately {interval}
-- milliseconds (default 200). Nvim still processes other events during this
-- time.
-- 
-- Examples: 
-- ```lua
-- 
--  ---
--  -- Wait for 100 ms, allowing other events to process
--  vim.wait(100, function() end)
-- 
--  ---
--  -- Wait for 100 ms or until global variable set.
--  vim.wait(100, function() return vim.g.waiting_for_var end)
-- 
--  ---
--  -- Wait for 1 second or until global variable set, checking every ~500 ms
--  vim.wait(1000, function() return vim.g.waiting_for_var end, 500)
-- 
--  ---
--  -- Schedule a function to set a value in 100ms
--  vim.defer_fn(function() vim.g.timer_result = true end, 100)
-- 
--  -- Would wait ten seconds if results blocked. Actually only waits  100 ms
--  if vim.wait(10000, function() return vim.g.timer_result end) then
--    print('Only waiting a little bit of time!')
--  end
-- ```
-- 
-- Parameters: ~
--   • {time}       (integer) Number of milliseconds to wait
--   • {callback}   fun():|nil boolean Optional callback. Waits until
--                  {callback} returns true
--   • {interval}   (integer|nil) (Approximate) number of milliseconds to
--                  wait between polls
--   • {fast_only}  (boolean|nil) If true, only |api-fast| events will be
--                  processed. If called from while in an |api-fast| event,
--                  will automatically be set to `true`.
-- 
-- Return: ~
--     boolean, nil|-1|-2
--     • If {callback} returns `true` during the {time}: `true, nil`
--     • If {callback} never returns `true` during the {time}: `false, -1`
--     • If {callback} is interrupted during the {time}: `false, -2`
--     • If {callback} errors, the error is raised.
--- @param time number
--- @param condition? fun(): boolean
--- @param interval? number
--- @param fast_only? boolean
--- @return boolean, nil|number
function vim.wait(time, condition, interval, fast_only) end

