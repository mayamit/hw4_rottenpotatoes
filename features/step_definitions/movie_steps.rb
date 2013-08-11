# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
#  if Movie.find(:all, :conditions => ['title = ?', movie['title']]).nil?
   Movie.create(movie)
#    end
  end
#flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert(page.body.index(e1)<page.body.index(e2))
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

# For checking the director of a movie
#
Then /the director of "(.*)" should be "(.*)"/ do |movname, dir|
  step "I should see \"#{movname}\""
  step "I should see \"#{dir}\""
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |r|
    step "I #{uncheck}check \"ratings[#{r.strip}]\""
  end
end

Then /^I should see all of the movies$/ do
  count=Movie.count
  actual_count=page.all('#movies tr').size-1
  actual_count.should==count
end

Then /^I should not see any of the movies$/ do
  count=0
  actual_count=page.all('#movies tr').size-1
  actual_count.should==count
end
