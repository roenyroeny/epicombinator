local combinator = table.deepcopy(data.raw["item"]["arithmetic-combinator"])
combinator.name = "signal-filter-combinator"
combinator.place_result="signal-filter-combinator"
combinator.order = "b[combinators]-d[signal-filter-combinator]"
combinator.icon = "__epicombinator__/graphics/icons/filter-combinator.png"
data:extend{combinator}

local fish_science_pack = table.deepcopy(data.raw["tool"]["automation-science-pack"])
fish_science_pack.name = "fish-science-pack"
--fish_science_pack.order = "b[combinators]-d[signal-filter-combinator]"
fish_science_pack.icon = "__epicombinator__/graphics/icons/fish-science-pack.png"
data:extend{fish_science_pack}
