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
