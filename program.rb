require "csv"
require "json"

def genre_scorer books_json, genres_csv
  genres_hash = collect_genre_keyword_points genres_csv

  books_array = File.open(books_json) { |f| JSON.parse(File.read f) }

  books_score = score_books genres_hash, books_array

  print_string = format_books_output books_score
end

def collect_genre_keyword_points genres_csv
  genres = Hash.new{ |hash, key| hash[key] = {} }

  CSV.foreach(genres_csv, { headers: :first_row, header_converters: lambda { |f| f.strip }, converters: lambda { |f| f.strip } }) do |row|
    genres[row["Genre"]][row["Keyword"]] = row["Points"]
  end

  genres
end

def score_books genres_hash, books_array
  books_score = Hash.new
  books_array.each do |book|
    title = book["title"]
    books_score[title] = {}
    # create the outer hash with the book title pointing to the inner score hash
    genres_hash.each do |genre, keywords_hash|
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
      books_score[title][genre] = genre_score
    end
    books_score[title] = Hash[books_score[title].sort_by {|k,v| v}.reverse]
    # sort inner hash by value (score) in descending order
  end
  keys = books_score.keys.sort
  books_score = Hash[keys.zip(books_score.values_at(*keys))]
  # sort outer hash by key (title) in ascending order
end

def format_books_output books_score_hash
  print_string = []

  books_score_hash.each do |title, genre_hash|
    index = 0
    genre_scores = []

    genre_hash.each do |genre, score|
      break if index > 2
      index += 1
      genre_scores << "#{genre.split.map(&:capitalize).join(' ')}, #{score}"
    end

    print_string << "#{title}\n" + genre_scores.join("\n")
  end

  print_string.join("\n\n")
end
