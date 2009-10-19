--[[
Abstract Base Classes for Lua
=============================

Copyright (C) Michel Alexandre Salim.  All rights reserved.

This file is under the MIT license; see the included LICENSE.txt file.
--]]

local error, pairs, table = error, pairs, table
-- if loop is available, use its allmembers; if not, use pairs
local allmembers = pcall(require, "loop.cached") and loop.cached.allmembers or pairs


module "abc"

--[[
amethod is *the* abstract method: when writing an abstract base class,
the methods that you require any implementer to override must be set
to abc.amethod.

This is for two reasons:
* abc.verify(c) scans the class c for any occurence of amethod;
* even if the class was never verified, attempting to use amethod will cause
  a run-time error
--]]
function amethod (...) error("Abstract method called.") end

--[[
abc.verify is used to verify a class to see whether any of its members are
abstract. This works on both simple tables as well as LOOP classes; if you
use a different style of class definitions and want it supported, please
file a bug report.
--]]
function verify (c)
   local abstracts = {}
   for field in allmembers(c) do
      if c[field] == amethod then
	 abstracts[#abstracts + 1] = field
      end
   end
   if #abstracts > 0 then
      table.sort(abstracts)
      local errmsg = "Methods " ..
	 table.concat(abstracts, ", ") .. " are still abstract."
      error(errmsg)
   else
      return true
   end
end
