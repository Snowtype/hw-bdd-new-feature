Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Given /^I am on the (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^I select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^I press "([^"]*)"$/ do |button_name|
  click_button(button_name)
end

When /^I follow "([^"]*)"$/ do |link_name|
  click_link(link_name)
end

When /^I follow "([^"]*)" for "([^"]*)"$/ do |link_name, movie_title|
  movie = Movie.find_by(title: movie_title)
  within("tr", text: movie_title) do
    click_link(link_name)
  end
end

Then /^I should be on the (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^I should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^I should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Given /^"([^"]*)" has no director info$/ do |movie_title|
  movie = Movie.find_by(title: movie_title)
  movie.update!(director: nil)
end
