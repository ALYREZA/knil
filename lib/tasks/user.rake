require 'optparse'

namespace :user do |args|
  desc "create user with verified email address"
  task create: :environment do
    options = {}
    o = OptionParser.new
    o.banner = "Usage: rake user:create [options]"
    o.on("-e", "--user {username}","User's email address", String) do |email|
      options[:email] = email
    end
    o.on("-u", "--user {username}","User's email address", String) do |username|
      options[:username] = username
    end
    o.on("-p", "--pass {password}","User's password", String) do |pass|
      options[:pass] = pass
    end
    args = o.order!(ARGV) {}
    o.parse!(args)

    puts "creating user account..."
    u = Hash.new
    u[:email] = options[:email]
    u[:username] = options[:username] 
    u[:password] = options[:pass] ? options[:pass] : 'knil1171'
    # with some DB layer like ActiveRecord:
    # user = User.new(u); user.save!
    user = User.new
    user.email = u[:email].to_s
    user.password = u[:password]
    user.username = u[:username]
    user.status = 1
    if user.save
      puts "account created."
      puts "user: " + u.to_s
    else
      puts "account not created"
    end
    
    exit 0
  end

  desc "update email address of user"
  task update: :environment do
    options = {}
    o = OptionParser.new
    o.banner = "Usage: rake user:update [options]"
    o.on("-o", "--user {username}","User's old email address", String) do |email|
      options[:emailOld] = email
    end
    o.on("-n", "--user {username}","User's new email address", String) do |email|
      options[:emailNew] = email
    end
    args = o.order!(ARGV) {}
    o.parse!(args)
    puts "Updating email address ..."

    u = Hash.new
    u[:emailOld] = options[:emailOld]
    u[:emailNew] = options[:emailNew]

    user = User.find_by(email: u[:emailOld])
    if user
      user.email = u[:emailNew]
      if user.save
        puts "email #{u[:emailOld]} change to #{u[:emailNew]}"
      else
        puts "something went wrong"
      end
    else
      puts "does not find any user with this email address #{u[:emailOld]}"
    end
    exit 0
  end

  desc "verify email address of user"
  task verify: :environment do
    options = {}
    o = OptionParser.new
    o.banner = "Usage: rake user:create [options]"
    o.on("-e", "--user {username}","User's email address", String) do |email|
      options[:email] = email
    end
    args = o.order!(ARGV) {}
    o.parse!(args)
    puts "Verifying email address ..."
    u = Hash.new
    u[:email] = options[:email]

    user = User.find_by(email: u[:email])
    if user
      user.status = 1
      if user.save
        puts "#{u[:email]} was verified !"
      else
        puts "something went wrong"
      end
    else
      puts "does not find any user #{u[:email]}"
    end

    exit 0
  end

end
