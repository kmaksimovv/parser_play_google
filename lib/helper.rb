#helpers method

def check_data_app(find_app, gps)
  find_app.update(ref_icon: gps.ref_icon) if find_app.ref_icon != gps.ref_icon
  find_app.update(category: gps.category) if find_app.category != gps.category
  find_app.update(dowload_count: gps.dowload_count) if find_app.dowload_count != gps.dowload_count
  find_app.update(author: gps.author) if find_app.author != gps.author
  find_app.update(author_email: gps.author_email) if find_app.author_email != gps.author_email
end

def show_parse_app(gps)
  puts "name: #{gps.name.downcase},
        ref_icon: #{gps.ref_icon},
        category: #{gps.category},
        rating: #{gps.rating},
        dowload_count: #{gps.dowload_count},
        author: #{gps.author},
        author_email: #{gps.author_email}"
end

def app_history_ratings(app, *app_ratings)
  puts "##########################"
  puts "###AppName: #{app.name}###"
  puts "##########################"
  app_ratings.each { |rat| puts "rating: #{rat.rating}, date: #{rat.created_at}" }
end

def display_error(attr)
  puts "No attribute #{attr} found on page"
end
