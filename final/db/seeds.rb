# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Report.delete_all
User.delete_all
Tag.delete_all
Preference.delete_all
Containing.delete_all

Report.create([{title: 'Bulls Win the First Game of the Series', content: 'Rose should be the MVP in this game!'}, {title: 'New iPad is Comming', content: 'It will have a 12.9 inch screen!'}])

User.create([{user_name: 'Baoge', pass_word: 'beimeijitouwang'}, {user_name: 'Gyoza', pass_word: 'zhecu'}])

Tag.create([{tag_name: 'sports'}, {tag_name: 'IT'}])

report = Report.find_by(:title => 'Bulls Win the First Game of the Series')
tag = Tag.find_by(:tag_name => 'sports')
containing = Containing.new
containing.report_ID = report.id
containing.tag_ID = tag.id
containing.save

report = Report.find_by(:title => 'New iPad is Comming')
tag = Tag.find_by(:tag_name => 'IT')
containing = Containing.new
containing.report_ID = report.id
containing.tag_ID = tag.id
containing.save

user = User.find_by(:user_name => 'Baoge')
tag = Tag.find_by(:tag_name => 'IT')
preference = Preference.new
preference.user_ID = user.id
preference.tag_ID = tag.id
preference.save

user = User.find_by(:user_name => 'Gyoza')
tag = Tag.find_by(:tag_name => 'sports')
preference = Preference.new
preference.user_ID = user.id
preference.tag_ID = tag.id
preference.save

