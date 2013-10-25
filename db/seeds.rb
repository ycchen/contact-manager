# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create!(email: "admin@test.com", password: "foobar1234", password_confirmation: "foobar1234", display_name: 'admin')
u.add_role "admin"

u2 = User.create!(email: "moderator@test.com", password: "foobar1234", password_confirmation: "foobar1234", display_name: 'moderator')
u2.add_role "moderator"

u3 = User.create!(email: "test@test.com", password: "foobar1234", password_confirmation: "foobar1234", display_name: 'user')
u3.add_role "user"

u4 = User.create!(email: "john.gaughan@dmsva.com", password: "test1234", password_confirmation: "test1234", display_name: 'John')
u4.add_role "user"

u5 = User.create!(email: "wayne.bushell@dmsva.com", password: "test1234", password_confirmation: "test1234", display_name: 'Wayne')
u5.add_role "user"

ContactType.create!(name: 'Phone')
ContactType.create!(name: 'Email')
ContactType.create!(name: 'In Person')


p1= Post.create!(title: 'John-test1', body: 'testing body text ', user_id: u4.id, contact_id: 1, contact_type_id: 1, contact_date: Date.today)
c1= Comment.create!(body: 'comment by '+ u5.display_name, user_id: u5.id, post_id: p1.id)

p2= Post.create!(title: 'John-test2', body: 'testing body text 2', user_id: u4.id, contact_id: 2, contact_type_id: 1, contact_date: Date.today)
c2= Comment.create!(body: 'comment by '+ u5.display_name, user_id: u5.id, post_id: p2.id)

p3= Post.create!(title: 'John-test3', body: 'testing body text 3', user_id: u4.id, contact_id: 3, contact_type_id: 1, contact_date: Date.today)
c3= Comment.create!(body: 'comment by '+ u5.display_name, user_id: u5.id, post_id: p3.id)

p4= Post.create!(title: 'John-test4', body: 'testing body text 4', user_id: u4.id, contact_id: 4, contact_type_id: 1, contact_date: Date.today)
c4= Comment.create!(body: 'comment by '+ u5.display_name, user_id: u5.id, post_id: p4.id)

p5= Post.create!(title: 'John-test5', body: 'testing body text 5', user_id: u4.id, contact_id: 5, contact_type_id: 1, contact_date: Date.today)
c5= Comment.create!(body: 'comment by '+ u5.display_name, user_id: u5.id, post_id: p5.id)

p6= Post.create!(title: 'John-test6', body: 'testing body text 6', user_id: u4.id, contact_id: 6, contact_type_id: 1, contact_date: Date.today)
c6= Comment.create!(body: 'comment by '+ u5.display_name, user_id: u5.id, post_id: p6.id)

p7= Post.create!(title: 'Wayne-test1', body: 'testing body text ', user_id: u5.id, contact_id: 7, contact_type_id: 1, contact_date: Date.today)
c7= Comment.create!(body: 'comment by '+ u4.display_name, user_id: u4.id, post_id: p7.id)

p8= Post.create!(title: 'Wayne-test2', body: 'testing body text 2', user_id: u5.id, contact_id: 8, contact_type_id: 1, contact_date: Date.today)
c8= Comment.create!(body: 'comment by '+ u4.display_name, user_id: u4.id, post_id: p8.id)

p9= Post.create!(title: 'Wayne-test3', body: 'testing body text 3', user_id: u5.id, contact_id: 9, contact_type_id: 1, contact_date: Date.today)
c9= Comment.create!(body: 'comment by '+ u4.display_name, user_id: u4.id, post_id: p9.id)

p10= Post.create!(title: 'Wayne-test4', body: 'testing body text 4', user_id: u5.id, contact_id: 10, contact_type_id: 1, contact_date: Date.today)
c10= Comment.create!(body: 'comment by '+ u4.display_name, user_id: u4.id, post_id: p10.id)

p11= Post.create!(title: 'Wayne-test5', body: 'testing body text 5', user_id: u5.id, contact_id: 11, contact_type_id: 1, contact_date: Date.today)
c11= Comment.create!(body: 'comment by '+ u4.display_name, user_id: u4.id, post_id: p11.id)

p12= Post.create!(title: 'Wayne-test6', body: 'testing body text 6', user_id: u5.id, contact_id: 12, contact_type_id: 1, contact_date: Date.today)
c12= Comment.create!(body: 'comment by '+ u4.display_name, user_id: u4.id, post_id: p12.id)
