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


User.create([{user_name: 'reporter', password: 'reporter', email:'reporter@example.com', user_type:'reporter'}, 
	         {user_name: 'reader', password: 'reader', email:'reader@example.com', user_type:'reader'},
	         {user_name: 'admin', password: 'admin', email:'admin@example.com', user_type:'admin'},
	         {user_name: 'godliang', password: 'godliang', email:'godliang@example.com', user_type:'reporter'},
	         {user_name: 'test', password: 'test', email:'test@example.com', user_type:'reader'}])

Tag.create([{tag_name: 'sports'},
	        {tag_name: 'IT'},
	        {tag_name: 'bussiness'}])

reporter = User.find_by(user_name:'reporter')
Report.create([{title: 'Apple iPhone bug can also affect Twitter and Snapchat', content: 'If you’re a victim of Apple’s text messaging bug and have suffered an iPhone crash, there is more shock in store. The bug that can strike with simple text, also affects Twitter and permanently breaks Snapchat text chat. The malware causes Apple’s text handling system to choke on certain characters from Arabic, Marathi and Chinese and crashes the iPhone, iPad, Apple Watch or Mac. It also affects apps running on iOS, The Guardian reported.', posted_date:Time.now, user_ID:reporter.id}, 
	           {title: 'Nvidia GeForce GTX 980 Ti review: A ferocious graphics card at a ferocious price', content: 'Nvidia’s GeForce GTX 980 already trumps the Radeon R9 290X in virtually every gaming benchmark—solidly in some tests, by a hair in others—while also running far cooler, quieter, and more efficiently than AMD’s aging flagship. But with a new generation of powerful Radeons buoyed by cutting-edge high-bandwidth memory (HBM) and a rumored new Fiji GPU right around the corner, Nvidia couldn’t stand still. So the question stands: How do you make one of the best graphics cards even better?', posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Sony Promises Ultra Street Fighter IV Patch for PS4 Next Week', content: 'Complaints regarding Ultra Street Fighter IV for the PlayStation 4 have piled up in recent days – according to players, the game has been laggy, glitchy, and all sorts of buggy, with weird errors such as a nonexistent button the start screen asks players to press.  Sony, however, is aware of the problems and promised on a recent tweet to roll out a patch for Ultra Street Fighter IV.', posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Uber updates privacy policy with the new track feature', content: 'Uber has now introduced a cool new feature in its taxi app. It will help the taxi drivers to reach the users by tracking their location, and pick them up. The app will seek permission from the user asking whether they would like to share their location or not. The company says the new feature will help them to increase the speed of the pick up considerably, making them a lot quicker than the conventional method of hinting location.', posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Recycling firm looking for woman who tossed Apple computer worth $200k', content: 'A recycling firm is looking for a woman who, in early April, dropped off boxes of electronics that she had cleaned out from her house after her husband died. About two weeks later, the firm, Clean Bay Area, discovered inside one of the boxes a rare find: a vintage Apple I, one of only about 200 first-generation desktop computers put together by Steve Jobs, Steve Wozniak and Ron Wayne in 1976.', posted_date:Time.now, user_ID:reporter.id}])

Report.create([{title: 'Cases for and against LeBron James as the NBA’s greatest', content: 'LeBron’s 2015 playoff averages are astounding — 27.6 points, 10.4 rebounds and 8.3 assists per game, numbers not seen since Oscar Robertson put up 31.8, 13.0 and 9.0 per game in 1963 with the Cincinnati Royals.', posted_date:Time.now, user_ID:reporter.id}, 
	           {title: "Kevin Love tells Kelly Olynyk, ‘it’s all good’", content: 'Love, who has missed out on a large chunk of the Cleveland Cavaliers’ run to the NBA Finals after his shoulder was dislocated by the Celtics power forward in the first round of the playoffs, told reporters in Cleveland on Sunday that he texted Olynyk to say “hey, it’s all good” about a week after he suffered the injury. This comes after he referred to the play as “bush-league” and reportedly wouldn’t accept any apologies or mea cuplas from Olynyk earlier this month.', posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Gluck: Wins pile up for Jimmie Johnson, lofty records in focus', content: "DOVER, Del. — Jimmie Johnson is beyond the point where he's simply piling up wins while being seemingly unbeatable at certain tracks. He's still doing that. Johnson drove to victory lane Sunday at Dover International Speedway for a record 10th time.", posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Boston Red Sox - PlayerWatch', content: 'INF Jeff Bianchi elected to become a free agent rather than go to Triple-A Pawtucket after clearing waivers. LHP Wade Miley (4-5) suffered the loss against Texas on Saturday. The left-hander gave up six runs (five earned), nine hits and two walks in four innings.', posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Johnny Manziel harassed at golf tournament; no charges filed', content: "According to police, an 18-year-old autograph seeker may have badgered Manziel, a former star at Texas A&M, for a couple of hours. The result was a dust up at the pool of the Four Seasons Resort and Club Dallas, site of this week's stop on the PGA Tour.", posted_date:Time.now, user_ID:reporter.id}])

Report.create([{title: 'Capturing a Prize in Cable', content: "STAMFORD, Conn. — Thomas M. Rutledge declared victory last week when Charter Communications struck a $56.7 billion deal to acquire its much larger rival Time Warner Cable. From a corporate takeover standpoint, Charter had publicly battled for control of Time Warner Cable for the last two years. For Mr. Rutledge, Charter’s chief executive, it was the conclusion of a personal quest that goes back more than a decade.", posted_date:Time.now, user_ID:reporter.id}, 
	           {title: "Chobani CEO joins in pledging to donate wealth", content: "NEW YORK — Chobani founder and CEO Hamdi Ulukaya says he will join some of the world's richest individuals in pledging to give away at least half his wealth, which has been estimated at $1.41 billion. The Turkish-born Ulukaya said he is joining The Giving Pledge, created by Berkshire Hathaway CEO Warren Buffett and Microsoft founder Bill Gates. The Giving Pledge asks billionaires to commit to giving away more than half their wealth in their lifetimes or in their wills.", posted_date:Time.now, user_ID:reporter.id},
	           {title: 'RPT-Wall St Week Ahead-Strong sales could shift Ford, GM to higher gear', content: "Investors are closely awaiting next week's May sales data, expected to come in near record levels. Meeting those forecasts could be enough to lift the sector - among the cheapest in the market - putting the sting of product recalls and tepid recent growth in the rear view mirror.", posted_date:Time.now, user_ID:reporter.id},
	           {title: 'OPEC’s Pricing Leverage Is Weakening', content: "Oil prices have plummeted in the past eight months because of a half-decade surge in U.S. production and weak international demand. Brent crude for July delivery ended Friday near $65 a barrel on London’s ICE Futures exchange, far below the $100 needed by several members of the Organization of the Petroleum Exporting Countries to balance their budgets.", posted_date:Time.now, user_ID:reporter.id},
	           {title: 'Greek call with France, Germany ‘went well’', content: "Greek prime minister Alexis Tsipras had a conference call last night with the leaders of France and Germany to discuss progress in the talks between Athens and its lenders, officials said.", posted_date:Time.now, user_ID:reporter.id}])

report = Report.find_by(:title => 'Capturing a Prize in Cable')
tag = Tag.find_by(:tag_name => 'bussiness')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => "Chobani CEO joins in pledging to donate wealth")
tag = Tag.find_by(:tag_name => 'bussiness')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'RPT-Wall St Week Ahead-Strong sales could shift Ford, GM to higher gear')
tag = Tag.find_by(:tag_name => 'bussiness')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'OPEC’s Pricing Leverage Is Weakening')
tag = Tag.find_by(:tag_name => 'bussiness')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Greek call with France, Germany ‘went well’')
tag = Tag.find_by(:tag_name => 'bussiness')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Cases for and against LeBron James as the NBA’s greatest')
tag = Tag.find_by(:tag_name => 'sports')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => "Kevin Love tells Kelly Olynyk, ‘it’s all good’")
tag = Tag.find_by(:tag_name => 'sports')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Gluck: Wins pile up for Jimmie Johnson, lofty records in focus')
tag = Tag.find_by(:tag_name => 'sports')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Boston Red Sox - PlayerWatch')
tag = Tag.find_by(:tag_name => 'sports')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Johnny Manziel harassed at golf tournament; no charges filed')
tag = Tag.find_by(:tag_name => 'sports')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Apple iPhone bug can also affect Twitter and Snapchat')
tag = Tag.find_by(:tag_name => 'IT')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Nvidia GeForce GTX 980 Ti review: A ferocious graphics card at a ferocious price')
tag = Tag.find_by(:tag_name => 'IT')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Sony Promises Ultra Street Fighter IV Patch for PS4 Next Week')
tag = Tag.find_by(:tag_name => 'IT')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Uber updates privacy policy with the new track feature')
tag = Tag.find_by(:tag_name => 'IT')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

report = Report.find_by(:title => 'Recycling firm looking for woman who tossed Apple computer worth $200k')
tag = Tag.find_by(:tag_name => 'IT')
subject = Subject.new
subject.report_ID = report.id
subject.tag_ID = tag.id
subject.save

user = User.find_by(:user_name => 'reader')
tag = Tag.find_by(:tag_name => 'sports')
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

user = User.find_by(:user_name => 'reporter')
tag = Tag.find_by(:tag_name => 'bussiness')
preference = Preference.new
preference.user_ID = user.id
preference.tag_ID = tag.id
preference.save

