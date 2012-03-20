Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each { | movie |
    Movie.create(movie)
  }
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  page.body =~ /Details about #{title}.*Director:\s+#{director}/
end
