--[[
Standalone abc unit tests
=========================

Copyright (C) Michel Alexandre Salim.  All rights reserved.

This file is under the MIT license; see the included LICENSE.txt file.

The unit tests here work on standard tables; there is no additional
dependency beyond lunit
--]]

require "abc"
require "lunit"

module( "abc_testcase", lunit.testcase, package.seeall )

function call_amethod_test()
   local Foo = {}
   Foo.f = abc.amethod
   assert_error(Foo.f)
end

function verify_amethod_test()
   local Foo = {}
   Foo.f = abc.amethod
   Foo.g = abc.amethod
   assert_error(function () abc.verify(Foo) end)
end

function verify_normal_test()
   local Foo = {}
   function Foo.f (...) end
   function Foo:g (...) end
   assert_pass(function () abc.verify(Foo) end)
end
