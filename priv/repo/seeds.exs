# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NouRau.Repo.insert!(%NouRau.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias NouRau.Collections.{Category,Document}
alias NouRau.Repo

%Document{ name: "Document without description" } |> Repo.insert!
%Category{ name: "Category without description" } |> Repo.insert!

for n <- 1..20 do
  document_name = "Document #{n}"
  category_name = "Category #{n}"
  description = "Description for #{n}"

  %Document{
    name: document_name,
    description: description,
    category: %Category{
      name: category_name,
      description: description
    }
  } |> Repo.insert!
end
