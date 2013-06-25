# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Comment.delete_all
Comment.create([
                {message: 'Great movie!', commented_time: 1000},
                {message: 'Wonderful music!', commented_time: 2000},
                {message: 'I like this song very much!', commented_time: 3000}
               ])
