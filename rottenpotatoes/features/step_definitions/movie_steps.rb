# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
     Movie.create!(movie)
  end
 
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body).to match(/#{e1}(?=[\s\S]*#{e2})/)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  ratings_list = rating_list.split(', ')
  ratings_list.each do |rating|
    if uncheck.nil? 
       check("ratings[#{rating}]") #checkbox name
    else
       uncheck("ratings[#{rating}]")
    end
  end
end

When /I press the "(.*)" button/ do |button_refresh|
  click_button button_refresh
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows = page.all('table tr').count
  expect(rows).to eq 11
end

Then /I should( not)? see these movies: (.*)/ do |see, movies|
  movies_list = movies.split(', ')
  movies_list.each do |movie|
    if see.nil?
     expect(page).to have_content(movie)
   else  
     expect(page).not_to have_content(movie)
   end
  end
end
