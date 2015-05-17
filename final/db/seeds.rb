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
Subject.delete_all


User.create([{user_name: 'Baoge', pass_word: 'beimeijitouwang', email:'baoge@example.com', user_type:'reader'}, 
	         {user_name: 'Gyoza', pass_word: 'zhecu', email:'gyoza@example.com', user_type:'reader'},
	         {user_name: 'admin', pass_word: 'admin', email:'admin@example.com', user_type:'admin'},
	         {user_name: 'godliang', pass_word: 'godliang', email:'godliang@example.com', user_type:'reporter'},
	         {user_name: 'test', pass_word: 'test', email:'test@example.com', user_type:'reader'}])

Tag.create([{tag_name: 'sports'},
	        {tag_name: 'IT'},
	        {tag_name: 'fashion'},
	        {tag_name: 'social'}])

reporter = User.find_by(user_name:'godliang')
Report.create([{title: 'Bulls Win the First Game of the Series', content: 'Rose should be the MVP in this game!', posted_date:Time.now, user_ID:reporter.id}, 
	           {title: 'New iPad is Comming', content: 'It will have a 12.9 inch screen!', posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Bulls lost the games', content: '2:4!!!', posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Life is hard', content: 'Life is hard!', posted_date:Time.now, user_ID:reporter.id}])

report = Report.find_by(:title => 'Bulls Win the First Game of the Series')
tag = Tag.find_by(:tag_name => 'sports')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Bulls lost the games')
tag = Tag.find_by(:tag_name => 'sports')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'New iPad is Comming')
tag = Tag.find_by(:tag_name => 'IT')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Life is hard')
tag = Tag.find_by(:tag_name => 'social')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

user = User.find_by(:user_name => 'Baoge')
tag = Tag.find_by(:tag_name => 'social')
preference = Preference.new
preference.user_ID = user.id
preference.tag_ID = tag.id
preference.save

user = User.find_by(:user_name => 'admin')
tag = Tag.find_by(:tag_name => 'IT')
preference = Preference.new
preference.user_ID = user.id
preference.tag_ID = tag.id
preference.save

user = User.find_by(:user_name => 'godliang')
tag = Tag.find_by(:tag_name => 'IT')
preference = Preference.new
preference.user_ID = user.id
preference.tag_ID = tag.id
preference.save

user = User.find_by(:user_name => 'test')
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

