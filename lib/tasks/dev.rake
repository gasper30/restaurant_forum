namespace :dev do

  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(Rails.root.join("public/seed_img/#{rand(1..20)}.jpg"))
        )
    end


    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

   task fake_user: :environment do
    20.times do |i|
      user_name = FFaker::Name.first_name
      User.create!(
        name: user_name,
        email: "#{user_name}@example.com",
        password: "12345678",
        avatar: File.open(File.join(Rails.root, "public/picseed_img/#{rand(0..19)}.jpg"))
        )
    end
    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end


  task fake_comment: :environment do
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts "have created fake comments"
    puts "now you have #{Comment.count} comment data"
  end

  task fake_favorite: :environment do

    500.times do
      Favorite.create!(
        user_id: User.all.ids.sample,
        restaurant_id: Restaurant.all.ids.sample
      )
    end

    puts "have created fake favorites"
    puts "now you have #{Favorite.count} favorites' data"
  end

  task fake_followship: :environment do
    Followship.destroy_all

    User.all.each do |user|
      #where.not的用法，排除...,這裡確保不會自己加自己好友
      @users = User.where.not(id: user.id).shuffle
      5.times do
        user.followships.create!(
          following: @users.pop
        )
      end
    end

    puts "have created fake followship"
    puts "now you have #{Followship.count} followships' data"
  end
end



