local error, pairs, table = error, pairs, table
local allmembers = pcall(require, "loop.cached") and loop.cached.allmembers or pairs


module "abc"

function amethod (...) error("Abstract method called.") end
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
