require_relative "../program.rb"

describe "genre_scorer" do
  context "when called with the 'sample_genres.csv' file and the
  'sample_books.txt' file" do

    it "returns the book titles alphabetically along with the genre and score
    for their three highest scoring genres" do
      books_file = "sample_books.txt"
      genres_file = "sample_genres.csv"

      expected_string = "Hunger Games\nAction, 15.0\nSci-fi, 8.0\nBiography, 0\n\nInfinite Jest\nLiterary fiction, 12.0\nBiography, 0\nSci-fi, 0"
      expect(genre_scorer(books_file, genres_file)).to eq expected_string
    end
  end
end
