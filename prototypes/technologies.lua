data:extend{{
    name = "epicombinator",
    type = "technology",
    icon = "__epicombinator__/graphics/technology/epicombinator.png",
    icon_mipmaps = 0,
    icon_size = 256,
    order = "a-d-e",
    prerequisites = {
        "circuit-network"
    },
    effects = {
        {
            type = "unlock-recipe",
            recipe = "epicombinator"
        }
    },
    unit = {
        time = 600,
        count = 2,
        ingredients = {
          {
            "fish-science-pack",
            1
          }
        }
    }
}}


table.insert(data.raw.lab.lab.inputs, "fish-science-pack")
