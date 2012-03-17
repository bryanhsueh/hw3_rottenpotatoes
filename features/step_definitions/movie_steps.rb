# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie['title'], :rating => movie['rating'], :release_date => movie['release_date'])
  end
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body  is the entire content of the page as a string.
  i1 = page.body.index(e1)
  i2 = page.body.index(e2)
  assert i1 && i2 && i1 < i2
  #assert false, "Unimplmemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |rating|
    uncheck ? uncheck(rating) : check(rating)
  end
end

Then /I should not see any movie/ do
  page.all('table#movies tbody tr').count.should == 0
end

Then /I should see all of the movies/ do
  page.all('table#movies tbody tr').count.should == Movie.all.length
end
