Instructions:

To execute the method from the command line, simply navigate to the root folder "genre-scorer", open up an irb shell making sure to require the program:
~irb -r "./program.rb"
Then execute the function and print its results:
~puts genre_scorer <books file>, <genres file>
You can execute it with the assignment test files that I've included in the directory like so:
 ~puts genre_scorer "sample_books.txt", "sample_genres.csv"

Of course you can always run the method from within the program.rb file as well by adding the line:
puts genre_scorer "sample_books.txt", "sample_genres.csv"
at the end of the file and by entering ruby program.rb from the directory in the in command line.

Happy reading!

Notes:

This took around five hours to complete. I took some extra time to write tests for my own benefit, as well as to partition out the code into multiple methods to encapsulate the code, adhere to the Single Responsibility Principle, and provide more clarity.

In the future it might be wise to favor arrays over hashes in the implementation of this program. While I think the data structure of a hash makes much more sense conceptually in depicting the genre points and scored books data, I expect there would be performance benefits for using a data structure with an integer based index i.e. the array. This might be especially true in regards to sorting as you could sort the array WHILE constructing it as opposed to making a round trip to sort an already constructed hash. This performance improvement would become more apparent when using the program with larger files. Of course with the hash you are able to index into the data with ease and don't have to write extra code to avoid duplication issues e.g. creating multiple "action" genre rows when using the collect_genre_keyword_points method. This is the same kind of problem you run into with a flat file two-dimensional table like excel as opposed to a relational database which the hash mirrors. These benefits along with the aforementioned conceptual clarity likely mean the hash is better suited, so long as the file sizes don't become too large.

The results are slightly different from the instructions as I'm not sure what kind of criteria, if any are being employed to sort the ranked output when there are fewer than 3 genres with any points (or if there is a tie for that matter). It might make sense to sort first by points and than alphabetically or to return only genres that have a score above zero even if there are less than three top genres for a given book.
