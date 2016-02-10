require "pry"
require "csv"
def genre_scorer books_json, genres_csv
  # instantiate a nested hash
  genres = Hash.new { |hash, key| hash[key] = {} }

  CSV.foreach(genres_csv, { headers: :first_row, header_converters: lambda { |f| f.strip }, converters: lambda { |f| f.strip } }) do |row|

    # Population genres this way allows for csv file not already arranged according to genres
    genres[row["Genre"]][row["Keyword"]] = row["Points"]
  end
  # string = "Hunger Games\nAction, 15\nSci-Fi, 8\nMystery, 0\n\nInfinite Jest\nLiterary Fiction, 12\nMystery, 0\nSci-Fi, 0"
  binding.pry

  
end



puts genre_scorer "blah", "sample_genres.csv"

hash = {
  "action" => { "fight" => 3, "loud" => 7 },
  "sci-fi" => { "future" => 4 }
}
