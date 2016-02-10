require "pry"
require "csv"
require "json"

def genre_scorer books_json, genres_csv
  # instantiate a nested hash
  genres = Hash.new { |hash, key| hash[key] = {} }

  CSV.foreach(genres_csv, { headers: :first_row, header_converters: lambda { |f| f.strip }, converters: lambda { |f| f.strip } }) do |row|

    # Population genres this way allows for csv file not already arranged according to genres
    genres[row["Genre"]][row["Keyword"]] = row["Points"]
  end
  # string = "Hunger Games\nAction, 15\nSci-Fi, 8\nMystery, 0\n\nInfinite Jest\nLiterary Fiction, 12\nMystery, 0\nSci-Fi, 0"

  books_array = File.open(books_json) { |f| JSON.parse(File.read f) }

  books_score = Hash.new
  books_array.each do |book|
    title = book["title"]
    books_score[title] = {}
    # create the outer hash with the book title pointing to the inner score hash
    genres.each do |genre, keywords_hash|
      regex = /\b#{keywords_hash.keys.join("|")}/i
      matched_words = book["description"].scan regex
      points = []
      matched_words.uniq.each do |unique_word|
        points << keywords_hash[unique_word].to_f
      end
      genre_score = 0
      unless points.empty?
        avg_points = points.inject { |sum, point| sum + point } / points.size
        genre_score = avg_points * matched_words.size
      end
      #NOTE might be faster way by skipping all but top three, but this way is building
      # for the future, as you may likely want to see all the genre scores for a book
      books_score[title][genre] = genre_score
    end
  end
  books_score = Hash[book_score.sort]

end
# NOTE could be cleaner to write separate sorting code outside of loop using
# built in methods, but this means another round trip. why not sort while already
# in the loop?


puts genre_scorer "sample_books.txt", "sample_genres.csv"

hash = {
  "Hunger Games" => {
    "Action" => 10,
    "Sci-Fi" => 8,
    "Myster" => 0
  },
  "Infinite Jest" => {
    "Literary Fiction" => 12,
    "Mystery" => 0,
    "Sci-Fi" => 0
  }
}
# hash = {
#   "action" => { "fight" => 3, "loud" => 7 },
#   "sci-fi" => { "future" => 4 }
# }
