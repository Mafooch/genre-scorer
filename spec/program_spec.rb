require_relative "../program.rb"

describe "genre_scorer" do
  context "when called with the 'sample_genres.csv' file and the
    'sample_books.json' file" do
    it "returns the book titles alphabetically along with the genre and score
      for their three highest scoring genres" do
      expected_string = "Hunger Games\nAction, 15\nSci-Fi, 8\nMystery, 0\n\nInfinite Jest\nLiterary Fiction, 12\nMystery, 0\nSci-Fi, 0"
      expect(genre_scorer "blah").to eq expected_string
    end
  end
end
