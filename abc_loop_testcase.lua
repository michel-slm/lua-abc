--[[
abc: LOOP unit tests
====================

Copyright (C) Michel Alexandre Salim.  All rights reserved.

This file is under the MIT license; see the included LICENSE.txt file.

The unit tests here verify the functioning of abc when used in conjunction
with the LOOP library\'s class mechanisms.
--]]
        
require "abc"
require "lunit"

oo = require "loop.cached"

local Foo = oo.class { f = abc.amethod }
local Bar = oo.class { g = abc.amethod }

module( "abc_loop_testcase", lunit.testcase, package.seeall )

function test_call_amethod()
   assert_error(Foo.f)
end

function test_verify_empty()
   local C = oo.class {}
   assert_pass(function () abc.verify(C) end)
end

function test_verify_abstract()
   assert_error(function () abc.verify(Foo) end)
end

function test_verify_inherit_abstract_1()
   local C = oo.class({}, Foo)
   assert_error(function () abc.verify(C) end)
end

function test_verify_inherit_abstract_2()
   local C = oo.class(Foo, {})
   assert_error(function () abc.verify(C) end)
end

function test_verify_inherit_abstract_3()
   local C = oo.class(Foo, Bar)
   function verifier () abc.verify(C) end
   assert_error(verifier)
   function C:f (...) end
   assert_error(verifier)
   function C:g (...) end
   assert_pass(verifier)
end
