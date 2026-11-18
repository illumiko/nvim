local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin
-- NOTE: Not in use local line_end = require("luasnip.extras.expand_conditions").line_end
local cond_obj = require("luasnip.extras.conditions")

-----------------------
-- PRESET CONDITIONS --
-----------------------
--- The wordTrig flag will only expand the snippet if
--- the proceeding character is NOT %w or `_`.
--- This is quite useful. The only issue is that the characters
--- on which we negate on hard coded. See here for the actual implementation
--- https://github.com/L3MON4D3/LuaSnip/blob/c9b9a22904c97d0eb69ccb9bab76037838326817/lua/luasnip/nodes/snippet.lua#L827
---
---
--- @param pattern string valid lua pattern
local function make_trigger_does_not_follow_char(pattern)
  local condition = function(line_to_cursor, matched_trigger)
    local line_to_trigger_len = #line_to_cursor - #matched_trigger
    if line_to_trigger_len == 0 then
      return true
    end
    return not string.sub(line_to_cursor, line_to_trigger_len, line_to_trigger_len):match(pattern)
  end
  return cond_obj.make_condition(condition)
end

local ls = require("luasnip")
local trigger_does_not_follow_alpha_num_char = make_trigger_does_not_follow_char("%w")
local trigger_does_not_follow_alpha_char = make_trigger_does_not_follow_char("%a")


--- TODO: Rename to Math mode
local MATH_NODES = {
  math = true,
  formula = true,
}

--- TODO: Rename to Content mode
local TEXT_NODES = {
  text = true,
  content = true,
}

--- TODO: Rename to Code mode
local CODE_NODES = {
  code = true,
}

local in_textzone = cond_obj.make_condition(function(check_parent)
  local node = vim.treesitter.get_node({ ignore_injections = false })
  while node do
    if node:type() == "text" then
      if check_parent then
        -- For \text{}
        local parent = node:parent()
        if parent and MATH_NODES[parent:type()] then
          return false
        end
      end

      return true
    elseif MATH_NODES[node:type()] then
      return false
    end
    node = node:parent()
  end
  return true
end)

local in_codezone = cond_obj.make_condition(function()
  local node = vim.treesitter.get_node({ ignore_injections = false })
  while node do
    if CODE_NODES[node:type()] then
      return true
    elseif TEXT_NODES[node:type()] or MATH_NODES[node:type()] then
      return false
    end
    node = node:parent()
  end
  return false
end)

local in_mathzone = cond_obj.make_condition(function()
  local node = vim.treesitter.get_node({ ignore_injections = false })
  while node do
    if MATH_NODES[node:type()] then
      return true
    elseif TEXT_NODES[node:type()] or CODE_NODES[node:type()] then
      return false
    end
    node = node:parent()
  end
  return false
end)

local iv = function(i, ...)
  return d(i, get_visual, ...)
end

-- Generating functions for Matrix/Cases - thanks L3MON4D3!
local generate_matrix = function(args, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" , "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ ";", "" }))
  end
  -- fix last node.
  nodes[#nodes] = t(";")
  return sn(nil, nodes)
end

-- update for cases
local generate_cases = function(args, snip)
  local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
  local cols = 2 -- fix to 2 cols
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ ",", "" }))
  end
  -- fix last node.
  table.remove(nodes, #nodes)
  return sn(nil, nodes)
end

return {
  -- NOTE: Remove auto snippet in the future,
  s({ trig = ";:toc", snippetType = "autosnippet" }, t("#outline()"), { condition = line_begin }),
  s(
    { trig = "#grid", snippetType = "autosnippet" },
    fmta(
      [[
#subpar.grid(
  columns: <>,
  inset: (top: 2em, left: 2em, right: 2em, bottom: 2em),
  gutter: 20pt,
  <>
  caption: [<>]
)<>
]],
      { i(1, "(1fr, 1fr)"), i(2), iv(3), i(0) }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "#figure", snippetType = "autosnippet" },
    fmta(
      [[
#figure(
caption: [<>],
supplement: <>,
<>
)<>
]],
      { i(1), i(2, "[Figure]"), iv(3), i(0) }
    ),
    { condition = line_begin }
  ),
  -- FIXME: This is not working reproduce by adding figure as an arg to a subgrid
  s(
    { trig = "figure", snippetType = "autosnippet" },
    fmta(
      [[
figure(
caption: [<>],
supplement: <>,
<>
)<>
]],
      { i(1), i(2, "[Figure]"), iv(3), i(0) }
    ),
    { condition = in_codezone }
  ),
  -- SUBSCRIPT
  -- s(
  --   { trig = "([%w%)%]%}|])ss", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  --   fmta("<>_(<>)", {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     d(1, get_visual),
  --   }),
  --   { condition = in_mathzone }
  -- ),
  s(
    {
      trig = "([%w%)%]%}|])jj",
      desc = "Subscript(no ambiguity)",
      wordTrig = false,
      regTrig = true,
      snippetType = "autosnippet",
    },
    fmta("<>_(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- s(
  --   { trig = "([%w%)%]%}|])s([ijknmt])", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  --   fmta("<>_(<>)<>", {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     f(function(_, snip)
  --       return snip.captures[2]
  --     end),
  --     i(0),
  --   }),
  --   { condition = in_mathzone }
  -- ),
  s(
    {
      trig = "([%w%)%]%}|])j([ijknmtvd])",
      wordTrig = false,
      desc = "subscript",
      regTrig = true,
      snippetType = "autosnippet",
    },
    fmta("<>_(<>)<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  -- SUBSCRIPT
  -- s(
  --   { trig = "([%w%)%]%}|])s(%d+)", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  --   fmta("<>_(<>)<>", {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     f(function(_, snip)
  --       return snip.captures[2]
  --     end),
  --     i(0),
  --   }),
  --   { condition = in_mathzone }
  -- ),
  -- SUBSCRIPT
  s(
    { trig = "([%w%)%]%}|])j(%d+)", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>_(<>)<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    {
      trig = "([%w%)%]%}|])J",
      desc = "Subscript(no ambiguity)",
      wordTrig = false,
      regTrig = true,
      snippetType = "autosnippet",
    },
    fmta("<>_(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- -- SUPERSCRIPT
  -- s(
  --   { trig = "([%w%)%]%}%|])aa", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  --   fmta("<>^(<>)<>", {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     d(1, get_visual),
  --     i(0),
  --   }),
  --   { condition = in_mathzone }
  -- ),
  s(
    { trig = "([%w%)%]%}|])kk", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- s(
  --   { trig = "([%w%)%]%}|])a(%d+)", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  --   fmta("<>^(<>)<>", {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     f(function(_, snip)
  --       return snip.captures[2]
  --     end),
  --     i(0),
  --   }),
  --   { condition = in_mathzone }
  -- ),
  s(
    { trig = "([%w%)%]%}|])k(%d+)", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^(<>)<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  --- TODO: Conflicts with mat no t then
  -- s(
  --   { trig = "([%w%)%]%}|])a([ijknm])", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
  --   fmta("<>^(<>)<>", {
  --     f(function(_, snip)
  --       return snip.captures[1]
  --     end),
  --     f(function(_, snip)
  --       return snip.captures[2]
  --     end),
  --     i(0),
  --   }),
  --   { condition = in_mathzone }
  -- ),
  s(
    { trig = "([%w%)%]%}|])k([ijknmtvd])", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^(<>)<>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "([%w%)%]%}|])K", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>^(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = in_mathzone }
  ),
  -- INVERSE
  s(
    { trig = "([%w%)%]%}])inv", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta([[<>^(-1)<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  -- DAGGER
  s(
    { trig = "([%w%)%]%}])dagger", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta([[<>^(dagger)<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  --- This kinda works with \infty and \int too!
  --- NOTE: This won't expand on newline but I tried a regTrig and that did not work
  --- its probably because trigger_does_not_follow_alpha_char has a bug on newlines
  -- s(
  --   { trig = "in ", wordTrig = false, snippetType = "autosnippet" },
  --   t("\\in "),
  --   { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  -- ),
  s(
    { trig = "int", wordTrig = false, snippetType = "autosnippet" },
    fmta("integral_(<>)^(<>)<>", {
      d(1, get_visual),
      i(2),
      i(0),
    }),
    { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  ),
  --- https://github.com/michaelfortunato/luasnip-latex-snippets.nvim/blob/main/lua/luasnip-latex-snippets/math_iA.lua
  --- Again, all of these are covered correctly by Typst!
  -- s({ trig = "RR", snippetType = "autosnippet" }, t("\\mathbb{R}"), { condition = in_mathzone }),
  -- s({ trig = "QQ", snippetType = "autosnippet" }, t("\\mathbb{Q}"), { condition = in_mathzone }),
  -- s({ trig = "NN", snippetType = "autosnippet" }, t("\\mathbb{N}"), { condition = in_mathzone }),
  -- s({ trig = "ZZ", snippetType = "autosnippet" }, t("\\mathbb{Z}"), { condition = in_mathzone }),
  --- Relations
  s({ trig = "implies", snippetType = "autosnippet" }, t("==>"), { condition = in_mathzone }),
  s({ trig = "neq", snippetType = "autosnippet" }, t("!="), { condition = in_mathzone }),
  s({ trig = "leq", snippetType = "autosnippet" }, t("<="), { condition = in_mathzone }),
  s({ trig = "geq", snippetType = "autosnippet" }, t(">="), { condition = in_mathzone }),
  s({ trig = "isomorphism", snippetType = "autosnippet" }, t("tilde.equiv"), { condition = in_mathzone }),
  -- s({ trig = "-->", snippetType = "autosnippet" }, t(" arrow.r.long"), { condition = in_mathzone }),
  -- s({ trig = ">=", snippetType = "autosnippet" }, t("gt.eq"), { condition = in_mathzone }),
  -- s({ trig = "<=", snippetType = "autosnippet" }, t("\\leq"), { condition = in_mathzone }),
  s({ trig = "~~", snippetType = "autosnippet" }, t("tilde.op"), { condition = in_mathzone }),
  s({ trig = "sim", snippetType = "autosnippet" }, t("tilde.op"), { condition = in_mathzone }),
  s({ trig = "to ", snippetType = "autosnippet" }, t("-> "), { condition = in_mathzone }),
  --- TODO: See if I actually use these
  s({ trig = "<|", snippetType = "autosnippet" }, t("lt.tri"), { condition = in_mathzone }),
  s({ trig = "<j", snippetType = "autosnippet" }, t("lt.tri.eq"), { condition = in_mathzone }),
  -- s({ trig = "lt.tri.eq", snippetType = "autosnippet" }, t("lt.tri.eq"), { condition = in_mathzone }),
  -- s({ trig = "lt.tri", snippetType = "autosnippet" }, t("lt.tri "), { condition = in_mathzone }),
  s({ trig = "normalsubgroup", snippetType = "autosnippet" }, t("lt.tri.eq"), { condition = in_mathzone }),
  s({ trig = "normalpsubgroup", snippetType = "autosnippet" }, t("lt.tri"), { condition = in_mathzone }),
  -- Operators
  s({ trig = "||", snippetType = "autosnippet" }, fmta("norm(<>)<>", { i(1), i(0) }), { condition = in_mathzone }),
  --- FIXME: This one is tricky, I think this works though smoothly so long as I put the space back `\mid `
  s({ trig = "| ", snippetType = "autosnippet" }, t("bar.v "), { condition = in_mathzone }),
  -- Interesting...
  s(
    { trig = "|([^%s][^|]*)|", regTrig = true, snippetType = "autosnippet" },
    fmta("abs(<>)<>", { f(function(_, snip)
      return snip.captures[1]
    end), i(0) }),
    { condition = in_mathzone }
  ),
  -- --- Let "@" namespace operators
  s({ trig = "@g", snippetType = "autosnippet" }, t("nabla"), { condition = in_mathzone }),
  s({ trig = "@p", snippetType = "autosnippet" }, t("partial"), { condition = in_mathzone }),
  s({ trig = "@c", snippetType = "autosnippet" }, t("compose"), { condition = in_mathzone }),
  s(
    { trig = "dxdy", snippetType = "autosnippet" },
    fmta([[frac(d <>, d <>)<>]], {
      iv(1),
      i(2),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "ddx", snippetType = "autosnippet" },
    fmta([[frac(d, d <>)<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "pxpy", snippetType = "autosnippet" },
    fmta([[frac(partial <>, partial <>)<>]], {
      d(1, get_visual),
      i(2),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "ppx", snippetType = "autosnippet" },
    fmta([[frac(partial, partial <>)<>]], {
      iv(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "lr(", wordTrig = false, snippetType = "autosnippet" },
    fmta("lr(( <> ))<>", {
      iv(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "lr{", wordTrig = false, snippetType = "autosnippet" },
    fmta("lr({ <> })<>", {
      iv(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "lr[", wordTrig = false, snippetType = "autosnippet" },
    fmta("lr([ <> ])<>", {
      iv(1),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  -- NOTE: Typst is the same!
  -- s(
  --   { trig = "exists", wordTrig = false, snippetType = "autosnippet" },
  --   t("\\exists"),
  --   { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  -- ),
  -- NOTE: Typst is the same!
  -- s(
  --   { trig = "forall", wordTrig = false, snippetType = "autosnippet" },
  --   t("\\forall"),
  --   { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  -- ),
  --- Accents - Tilde
  s(
    { trig = "tilde", wordTrig = false, snippetType = "autosnippet" },
    fmta("tilde(<>)<>", {
      iv(1),
      i(0),
    }),
    { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  ),
  --- Accents - hat
  s(
    { trig = "hat", wordTrig = false, snippetType = "autosnippet" },
    fmta("hat(<>)<>", {
      iv(1),
      i(0),
    }),
    { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  ),
  --- BAR
  --   TODO: Which is faster? These two? or the dynamic node one?
  --- Enter display mode quickly
  s(
    { trig = "MM", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
$
  <>
$<>]],
      {
        d(1, get_visual),
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  s(
    { trig = "MM", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
    fmta(
      [[

$
  <>
$<>]],
      {
        d(1, get_visual),
        i(0),
      },
      { trim_empty = false }
    ),
    { condition = -line_begin * trigger_does_not_follow_alpha_char }
  ),
  --  TODO: Which is faster?
  --   s(
  --     { trig = "MM", wordTrig = false, regTrig = false, snippetType = "autosnippet" },
  --     fmta(
  --       [[<>
  --   <>
  -- $<>]],
  --       {
  --         d(1, function()
  --           local line = vim.api.nvim_get_current_line()
  --           if line:sub(1, -(2 + 1)):match("^%s*$") then
  --             return sn(nil, t({ "$" })) -- Just start of math
  --           else
  --             return sn(nil, t({ "", "$" })) -- Newline + start of math
  --           end
  --         end, {}),
  --         d(2, get_visual),
  --         i(0),
  --       }
  --     ),
  --     { condition = trigger_does_not_follow_alpha_char }
  --   ),
  --- Enter inline mathmode quickly
  s(
    { trig = "mm", wordTrig = false, snippetType = "autosnippet" },
    fmta([[$<>$<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = trigger_does_not_follow_alpha_char }
  ),
  s(
    { trig = "(%a)mb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[upright(bold(<>))<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "mb", wordTrig = false, snippetType = "autosnippet" },
    fmta([[upright(bold(<>))<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  ),
  s(
    { trig = "mB", wordTrig = false, snippetType = "autosnippet" },
    fmta([[bb(<>)<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  ),
  s(
    { trig = "(%a)mB", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[bb(<>)<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "mf", wordTrig = false, snippetType = "autosnippet" },
    fmta([[frak(<>)<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  ),
  s(
    { trig = "(%a)mf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[frak(<>)<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  -- FRACTION
  s(
    { trig = "ff", wordTrig = false, snippetType = "autosnippet" },
    fmta("frac(<>,<>)<>", {
      d(1, get_visual),
      i(2),
      i(0),
    }),
    { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  ),
  -- SUMMATION
  s(
    { trig = "sum", wordTrig = false, snippetType = "autosnippet" },
    fmta("sum_(<>)^(<>)<>", {
      d(1, get_visual),
      i(2),
      i(0),
    }),
    { condition = in_mathzone * trigger_does_not_follow_alpha_char }
  ),
  s(
    { trig = "mc", wordTrig = false, snippetType = "autosnippet" },
    fmta([[cal(<>)<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "mcal", wordTrig = false, snippetType = "autosnippet" },
    fmta([[cal(<>)<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  s(
    { trig = "cal", wordTrig = false, snippetType = "autosnippet" },
    fmta([[cal(<>)<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = in_mathzone }
  ),
  -- SECTION
  s(
    { trig = "h1", snippetType = "autosnippet" },
    fmta(
      [[= <> <<sec:<>>>
<>]],
      {
        iv(1),
        l(l._1:gsub("%s", "-"), 1),
        i(0),
      }
    ),
    { condition = in_textzone }
  ),
  -- SUBSECTION
  s(
    { trig = "h2", snippetType = "autosnippet" },
    fmta(
      [[== <>  <<subsec:<>>>
<>]],
      {
        iv(1),
        l(l._1:gsub("%s", "-"), 1),
        i(0),
      }
    ),
    { condition = in_textzone }
  ),
  -- SUBSUBSECTION
  s(
    { trig = "h3", snippetType = "autosnippet" },
    fmta(
      [[=== <>  <<subsubsec:<>>>
<>]],
      {
        iv(1),
        l(l._1:gsub("%s", "-"), 1),
        i(0),
      }
    ),
    { condition = in_textzone }
  ),
  s(
    { trig = "h4", snippetType = "autosnippet" },
    fmta(
      [[par(
  // leading: length,
  // spacing: length,
  // justify: bool,
  // linebreaks: autostr,
  // first-line-indent: lengthdictionary,
  // hanging-indent: length,
  <>) <<paragraph:<>>>
<>]],
      {
        iv(1),
        l(l._1:gsub("%s", "-"), 1),
        i(0),
      }
    ),
    { condition = in_textzone }
  ),
  --   Not supported in typst
  --   s(
  --     { trig = "h5", snippetType = "autosnippet" },
  --     fmta([[\subparagraph{<>}]], {
  --       d(1, get_visual),
  --     }),
  --     { condition = in_textzone }
  --   ),
  --- PART (only applicable to book document class)
  s(
    { trig = "tt", wordTrig = false, snippetType = "autosnippet" },
    fmta([["<>"<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = trigger_does_not_follow_alpha_char * in_mathzone }
  ),
  s(
    { trig = "tii", wordTrig = false, snippetType = "autosnippet" },
    fmta([[italic(<>)<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = trigger_does_not_follow_alpha_char * in_mathzone }
  ),
  s(
    { trig = "tii", wordTrig = false, snippetType = "autosnippet" },
    fmta([[_<>_<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = trigger_does_not_follow_alpha_char * in_textzone }
  ),
  s(
    { trig = "tbb", wordTrig = false, snippetType = "autosnippet" },
    fmta([[bold(<>)<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = trigger_does_not_follow_alpha_char * in_mathzone }
  ),
  s(
    { trig = "tbb", wordTrig = false, snippetType = "autosnippet" },
    fmta([[*<>*<>]], {
      d(1, get_visual),
      i(0),
    }),
    { condition = trigger_does_not_follow_alpha_char * in_textzone }
  ),
  --- GREEK BEGIN
  s({ trig = ";a", wordTrig = false, snippetType = "autosnippet" }, {
    t("alpha"),
  }),
  s({ trig = ";b", wordTrig = false, snippetType = "autosnippet" }, {
    t("beta"),
  }),
  s({ trig = ";g", wordTrig = false, snippetType = "autosnippet" }, {
    t("gamma"),
  }),
  s({ trig = ";G", wordTrig = false, snippetType = "autosnippet" }, {
    t("Gamma"),
  }),
  s({ trig = ";d", wordTrig = false, snippetType = "autosnippet" }, {
    t("delta"),
  }),
  s({ trig = ";D", wordTrig = false, snippetType = "autosnippet" }, {
    t("Delta"),
  }),
  s({ trig = ";e", wordTrig = false, snippetType = "autosnippet" }, {
    t("epsilon"),
  }),
  s({ trig = ";ve", wordTrig = false, snippetType = "autosnippet" }, {
    t("varepsilon"),
  }),
  s({ trig = ";z", wordTrig = false, snippetType = "autosnippet" }, {
    t("zeta"),
  }),
  s({ trig = ";h", wordTrig = false, snippetType = "autosnippet" }, {
    t("eta"),
  }),
  s({ trig = ";o", wordTrig = false, snippetType = "autosnippet" }, {
    t("theta"),
  }),
  s({ trig = ";vo", wordTrig = false, snippetType = "autosnippet" }, {
    t("vartheta"),
  }),
  s({ trig = ";O", wordTrig = false, snippetType = "autosnippet" }, {
    t("Theta"),
  }),
  s({ trig = ";k", wordTrig = false, snippetType = "autosnippet" }, {
    t("kappa"),
  }),
  s({ trig = ";l", wordTrig = false, snippetType = "autosnippet" }, {
    t("lambda"),
  }),
  s({ trig = ";L", wordTrig = false, snippetType = "autosnippet" }, {
    t("Lambda"),
  }),
  s({ trig = ";m", wordTrig = false, snippetType = "autosnippet" }, {
    t("mu"),
  }),
  s({ trig = ";n", wordTrig = false, snippetType = "autosnippet" }, {
    t("nu"),
  }),
  s({ trig = ";x", wordTrig = false, snippetType = "autosnippet" }, {
    t("xi"),
  }),
  s({ trig = ";X", wordTrig = false, snippetType = "autosnippet" }, {
    t("Xi"),
  }),
  s({ trig = ";i", wordTrig = false, snippetType = "autosnippet" }, {
    t("pi"),
  }),
  s({ trig = ";I", wordTrig = false, snippetType = "autosnippet" }, {
    t("Pi"),
  }),
  s({ trig = ";r", wordTrig = false, snippetType = "autosnippet" }, {
    t("rho"),
  }),
  s({ trig = ";s", wordTrig = false, snippetType = "autosnippet" }, {
    t("sigma"),
  }),
  s({ trig = ";S", wordTrig = false, snippetType = "autosnippet" }, {
    t("Sigma"),
  }),
  s({ trig = ";t", wordTrig = false, snippetType = "autosnippet" }, {
    t("tau"),
  }),
  s({ trig = ";f", wordTrig = false, snippetType = "autosnippet" }, {
    t("phi"),
  }),
  s({ trig = ";vf", wordTrig = false, snippetType = "autosnippet" }, {
    t("varphi"),
  }),
  s({ trig = ";F", wordTrig = false, snippetType = "autosnippet" }, {
    t("Phi"),
  }),
  s({ trig = ";c", wordTrig = false, snippetType = "autosnippet" }, {
    t("chi"),
  }),
  s({ trig = ";p", wordTrig = false, snippetType = "autosnippet" }, {
    t("psi"),
  }),
  s({ trig = ";P", wordTrig = false, snippetType = "autosnippet" }, {
    t("Psi"),
  }),
  s({ trig = ";w", wordTrig = false, snippetType = "autosnippet" }, {
    t("omega"),
  }),
  s({ trig = ";W", wordTrig = false, snippetType = "autosnippet" }, {
    t("Omega"),
  }),
  --   s(
  --     { trig = "al", snippetType = "autosnippet" },
  --     fmta(
  --       [[
  -- $
  --   <> & <> \
  --   <>
  -- $
  --       ]],
  --       {
  --         i(1),
  --         i(2),
  --         i(0),
  --       }
  --     ),
  --     { condition = line_begin }
  --   ),
  s(
    { trig = "bb", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
        #<>[
<>
]<>
      ]],
      {
        i(1),
        d(2, get_visual),
        i(0),
      }
    ),
    { condition = line_begin }
  ),
  -- Matrices and Cases
  s(
    {
      trig = "([bBpvV]?)mat(%d+)x(%d+)",
      name = "[bBpvV]matrix",
      desc = "matrices",
      regTrig = true,
      snippetType = "autosnippet",
    },
    fmta(
      [[
mat(delim:<>,
<>
)<>]],
      {
        f(function(_, snip)
          local prefix = snip.captures[1] or ""
          if (prefix == "b") or (prefix == "B") then
            return '"["'
          elseif (prefix == "p") or prefix == "v" or prefix == "V" then
            return '"("'
          else
            return '"["'
          end
        end),
        d(1, generate_matrix),
        i(0),
      }
    ),
    { condition = in_mathzone }
  ),

  s(
    { trig = "(%d?)cases", name = "cases", desc = "cases", regTrig = true, snippetType = "autosnippet" },
    fmta(
      [[
cases(
<>
)<>]],
      { d(1, generate_cases), i(0) }
    ),
    { condition = in_mathzone }
  ),

  s(
    { trig = "plotf", name = "Plot Function", desc = "Plot a function using Cetz", snippetType = "autosnippet" },
    fmta(
      [[
canvas({
plot.plot(size: (5, 5), {
    plot.add(domain: (<>, <>), { x =>> <> })
})})<>]],
      { i(1, "0"), i(2, "5"), i(3, "calc.pow(x,2)"), i(0) }
    ),
    { condition = -in_mathzone }
  ),

  s(
    {
      trig = "#imagefig",
      name = "Image Function",
      desc = "Adds a figure showing an image",
      snippetType = "autosnippet",
    },
    fmta(
      [[
#figure(
  image(<>),
  caption: [<>]
)]],
      { iv(1), i(2) }
    ),
    { condition = -in_mathzone }
  ),
}
