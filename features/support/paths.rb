module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^home\s?page$/
      '/'

    when /^edit page for "(.+)"$/
      movie = Movie.find_by(title: $1)
      edit_movie_path(movie)

    when /^details page for "(.+)"$/
      movie = Movie.find_by(title: $1)
      movie_path(movie)

    when /^Similar Movies page for "(.+)"$/
      movie = Movie.find_by(title: $1)
      similar_movie_path(movie)

    when /^new movie page$/
      new_movie_path

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
