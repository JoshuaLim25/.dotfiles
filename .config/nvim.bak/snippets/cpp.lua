-- https://github.com/madskjeldgaard/cheeky-snippets.nvim/blob/main/lua/cheeky/snippets/cpp.lua
local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local fmt = require('luasnip.extras.fmt').fmt
local m = require('luasnip.extras').m
local lambda = require('luasnip.extras').l
local parse = ls.parser.parse_snippet
local rep = require('luasnip.extras').rep

local common = require 'cheeky.common'

return {
  parse(
    'main',
    [[#include <iostream>

int main(int argc, char **argv) {
  using namespace std;
  int ret = 0;

  // your code goes here

  return ret;
}]]
  ),
  ----------------------------------------------------------------------
  --                             Pointers                             --
  ----------------------------------------------------------------------
  -- https://en.cppreference.com/w/cpp/memory
  s('up', fmt([[std::unique_ptr<{}> {}]], { i(1, 'int'), i(2, 'myint') })),
  s('sp', fmt([[std::shared_ptr<{}> {}]], { i(1, 'int'), i(2, 'myint') })),
  s('wp', fmt([[std::weak_ptr<{}> {}]], { i(1, 'int'), i(2, 'myint') })),

  ----------------------------------------------------------------------
  --                             Printing                             --
  ----------------------------------------------------------------------
  s('cout', fmt([[cout << "{}" << endl;]], { i(1, 'somestuff') })),
  s('cin', fmt([[cin >> {};]], { i(1, 'variable') })),

  ----------------------------------------------------------------------
  --                            Shorthands                            --
  ----------------------------------------------------------------------
  parse('c', 'const'),

  s('sc', fmt('static_cast<{}>({})', { i(1, 'int'), i(2, 'val') })),
  s('sa', fmt('static_assert({}, {})', { i(1, 'true == true'), i(2, [["true!"]]) })),
  parse('ca', 'const auto'),
  s('ce', fmt('constexpr {} {} = {};', { i(1, 'auto'), i(2, 'int'), i(3, '1') })),

  s(
    'f',
    fmt('[] []([]) { [] };', { i(1, 'int'), i(2, 'newfunc'), i(3, 'int i'), i(4, 'return i * 2;') }, {
      delimiters = '[]',
    })
  ),

  ----------------------------------------------------------------------
  --                              ratios                              --
  ----------------------------------------------------------------------
  s('ratio', fmt('std::ratio<{}, {}>', { i(1, '5'), i(2, '1') })),
  parse('atto', [[std::ratio<1, 1000000000000000000>]]),
  parse('femto', [[std::ratio<1, 1000000000000000>]]),
  parse('pico', [[std::ratio<1, 1000000000000>]]),
  parse('nano', [[std::ratio<1, 1000000000>]]),
  parse('micro', [[std::ratio<1, 1000000>]]),
  parse('milli', [[std::ratio<1, 1000>]]),
  parse('centi', [[std::ratio<1, 100>]]),
  parse('deci', [[std::ratio<1, 10>]]),
  parse('deca', [[std::ratio<10, 1>]]),
  parse('hecto', [[std::ratio<100, 1>]]),
  parse('kilo', [[std::ratio<1000, 1>]]),
  parse('mega', [[std::ratio<1000000, 1>]]),
  parse('giga', [[std::ratio<1000000000, 1>]]),
  parse('tera', [[std::ratio<1000000000000, 1>]]),
  parse('peta', [[std::ratio<1000000000000000, 1>]]),
  parse('exa', [[std::ratio<1000000000000000000, 1>]]),

  ----------------------------------------------------------------------
  --                           preprocessor                           --
  ----------------------------------------------------------------------
  -- Arm neon detection
  s(
    'ifneon',
    fmt(
      [[#ifdef __ARM_NEON__
{}
#endif
		]],
      {
        i(1, '// ARM NEON Intrinsics here... '),
      }
    )
  ),

  s(
    'pragmamessage',
    fmt([[#pragma message("{}") ]], {
      i(1, 'Hello!'),
    })
  ),

  ----------------------------------------------------------------------
  --                          STL Algorithms                          --
  ----------------------------------------------------------------------

  -- All of
  s(
    'allof',
    fmt([[std::all_of({}.cbegin(), {}.cend(), {});]], {
      i(1, 'v'),
      rep(1),
      i(2, '[](int i){ return i % 2 == 0; }'),
    })
  ),

  -- Any of
  s(
    'anyof',
    fmt([[std::any_of({}.cbegin(), {}.cend(), {});]], {
      i(1, 'v'),
      rep(1),
      i(2, [[[](int i){ return i % 2 == 0; }]]),
    })
  ),

  -- None of
  s(
    'noneof',
    fmt([[std::none_of({}.cbegin(), {}.cend(), {});]], {
      i(1, 'v'),
      rep(1),
      i(2, '[](int i){ return i % 2 == 0; }'),
    })
  ),

  -- Find
  s(
    'find',
    fmt([[std::find(begin({}), end({}), {});]], {
      i(1, 'v'),
      rep(1),
      i(2, '3'),
    })
  ),

  -- Find if
  s(
    'findif',
    fmt([[std::find_if(begin({}), end({}), {});]], {
      i(1, 'v'),
      rep(1),
      i(2, '[](int i){ return i%2 == 0; }'),
    })
  ),

  -- For each
  s(
    'foreach',
    fmt([[std::for_each(begin({}), end({}), {});]], {
      i(1, 'v'),
      rep(1),
      i(2, '[this](int& n) { printf(n); }'),
    })
  ),

  -- Transform
  s(
    'transform',
    fmt([[std::transform({}.cbegin(), {}.cend(), {}.begin(),  {});]], {
      i(1, 'v'),
      rep(1),
      rep(1),
      i(2, '[](unsigned char c) { return std::toupper(c); }'),
    })
  ),

  -- Copy
  s(
    'copy',
    fmt([[std::copy({}.begin(), {}.end(), std::back_inserter({}));]], {
      i(1, 'from_vector'),
      rep(1),
      i(2, 'to_vector'),
    })
  ),

  -- Copy if
  s(
    'copyif',
    fmt([[std::copy_if({}.begin(), {}.end(), std::back_inserter({}), {});]], {
      i(1, 'from_vector'),
      rep(1),
      i(2, 'to_vector'),
      i(3, '[](int x) { return x % 3 == 0; }'),
    })
  ),

  -- Remove
  s(
    'remove',
    fmt([[std::remove({}.begin(), {}.end(), {});]], {
      i(1, 'from_vector'),
      rep(1),
      i(2, '2'),
    })
  ),

  -- Remove if
  s(
    'removeif',
    fmt([[std::remove_if({}.begin(), {}.end(), {});]], {
      i(1, 'myvector'),
      rep(1),
      i(2, '[](int x) { return x % 3 == 0; }'),
    })
  ),
  -- Iota
  s(
    'iota',
    fmt([[std::iota({}.begin(), {}.end(), {});]], {
      i(1, 'myvector'),
      rep(1),
      i(2, '4'),
    })
  ),
  -- Reverse
  s(
    'reverse',
    fmt([[std::reverse({}.begin(), {}.end());]], {
      i(1, 'myvector'),
      rep(1),
    })
  ),
  -- Sort
  s(
    'sort',
    fmt([[std::sort({}.begin(), {}.end());]], {
      i(1, 'myvector'),
      rep(1),
    })
  ),
  -- Shuffle
  s(
    'shuffle',
    fmt(
      [[std::random_device rd;
std::mt19937 g(rd());
std::shuffle({}.begin(), {}.end(), {});]],
      {
        i(1, 'myvector'),
        rep(1),
        i(2, 'g'),
      }
    )
  ),
  -- Sample
  s(
    'sample',
    fmt(
      [[std::random_device rd;
std::mt19937 g(rd());
std::sample({}.begin(), {}.end(), {}, {}, {});]],
      {
        i(1, 'myvector'),
        rep(1),
        i(2, 'std::back_inserter(out)'),
        i(3, 'numSamples'),
        i(4, 'g'),
      }
    )
  ),

  -- Rotate
  s(
    'rotate',
    fmt([[std::rotate({}.begin(), {}.end() + {}, {}.end());]], {
      i(1, 'myvector'),
      rep(1),
      i(2, '1'),
      rep(3),
    })
  ),

  -- TODO
  -- Equal
  -- Mismatch
  -- Previous permutation
  -- Next permutation
  -- Max element
  -- Min element
  -- Set_*
  -- Partial sort

  ----------------------------------------------------------------------
  --                         STL containers                           --
  ----------------------------------------------------------------------
  -- See all here: https://en.cppreference.com/w/cpp/container

  -- Map
  s(
    'map',
    fmt([[std::map<[], []> []{{[], []}, {[], []}};]], {
      i(1, 'std::string'),
      i(2, 'int'),
      i(3, 'mapname'),
      i(4, [["GPU"]]),
      i(5, '5'),
      i(6, [["CPU"]]),
      i(7, '15'),
    }, { delimiters = '[]' })
  ),

  s(
    'unorderedmap',
    fmt([[std::unordered_map<[], []> []{{[], []}, {[], []}};]], {
      i(1, 'std::string'),
      i(2, 'int'),
      i(3, 'mapname'),
      i(4, [["GPU"]]),
      i(5, '5'),
      i(6, [["CPU"]]),
      i(7, '15'),
    }, { delimiters = '[]' })
  ),

  -- Array
  s(
    'arr',
    fmt('std::array<{}, {}> {} = {};', {
      i(1, 'int'),
      i(2, '3'),
      i(3, 'name'),
      i(4, '{1,2,3}'),
    })
  ),

  -- Span
  s(
    'span',
    fmt('std::span<{}> {}({});', {
      i(1, 'int'),
      i(2, 'mySpan'),
      i(3, 'myArray'),
    })
  ),
  -- Vector
  s(
    'vec',
    fmt('std::vector<{}> {} = {};', {
      i(1, 'int'),
      i(2, 'name'),
      i(3, '{1,2,3}'),
    })
  ),

  ----------------------------------------------------------------------
  --                            Functions                             --
  ----------------------------------------------------------------------

  -- Lambda
  s('lam', {
    t '[',
    i(1, 'x'),
    t ']',
    t '(',
    i(2, 'int y'),
    t ')',
    t ' { ',
    i(3, 'return x * y > 55;'),
    t ' }',
  }),

  ----------------------------------------------------------------------
  --                        Control structures                        --
  ----------------------------------------------------------------------
  -- If else
  s(
    'ifelse',
    fmt(
      [[if([])
	{[]}
else
	{[]};]],
      {
        i(1, 'condition'),
        i(2, 'true'),
        i(3, 'false'),
      },
      {
        delimiters = '[]',
      }
    )
  ),

  -- Class
  s(
    'class',
    fmt(
      [[
#pragma once
#ifndef []
#define []

namespace []{

/**
 * @brief []
 * @author []
 * @date []
 * @details []
 */

class [] {
public:
	[]();
	~[]();
private:
};

} // namespace []
#endif
]],
      {

        -- d(6, function(_,_) return i(nil, string.upper(fileNoExt())) end),
        common.ifilenameNoExtUpper(6),
        rep(6),

        i(1, 'mk'),
        -- Use file name to set class
        common.ifilenameNoExtUpper(2),
        i(3, 'Mads Kjeldgaard'),
        i(4, os.date '%d-%m-%Y'),
        i(5, 'longer description'),
        rep(2),
        rep(2),
        rep(2),
        rep(1),
      },
      {
        delimiters = '[]',
      }
    )
  ),

  ----------------------------------------------------------------------
  --                           Preprocessor                           --
  ----------------------------------------------------------------------

  -- #ifndef
  s(
    'ifndef',
    fmt(
      [[#pragma once
#ifndef {}
#define {}

#endif
		]],
      { i(1, 'YO'), rep(1) }
    )
  ),

  ----------------------------------------------------------------------
  --                          Supercollider                           --
  ----------------------------------------------------------------------

  -- Supercollider specific stuff
  s('rtalloc', {
    t '(',
    i(1, 'float'),
    t '*)RTAlloc(',
    i(2, 'unit->mWorld'),
    t ',',
    i(3, 'unit->bufsize'),
    t '* sizeof(',
    i(4, 'float'),
    t ')',
  }),

  -- Smoothing control signals
  s('slopeinit', fmt('SlopeSignal<{}> {} = makeSlope(in0({}), {});', { i(1, 'float'), i(2, 'controlRateFreq'), i(3, '1'), i(4, 'm_freq_past') })),

  s(
    'slopeconsume',
    fmt(
      [[const auto {} = {}.consume();
{} = {};
			]],
      { i(1, 'freq'), i(2, 'controlRateFreq'), i(3, 'm_freq_past'), rep(1) }
    )
  ),

  ----------------------------------------------------------------------
  --                              catch2                              --
  ----------------------------------------------------------------------
  s(
    'testcase',
    fmt(
      [[TEST_CASE( "[]", "[]" ) {
	[]
}]],
      { i(1, [[Factorials are computed]]), i(2, '[factorial]'), i(3, '') },
      { delimiters = '[]' }
    )
  ),

  s('require', fmt('REQUIRE({});', { i(1, '2 == 3') })),
  s('requirethat', fmt('REQUIRE_THAT({}, {});', { i(1, 'inval'), i(2, 'Catch::WithinRel(2.0)') })),
  s('check', fmt('CHECK({});', { i(1, '2 == 3') })),
  s(
    'benchmark',
    fmt(
      [[BENCHMARK("[]") {
        return [];
    };]],
      { i(1, [[my_benchmark is cool]]), i(2, '1+1') },
      { delimiters = '[]' }
    )
  ),
}
