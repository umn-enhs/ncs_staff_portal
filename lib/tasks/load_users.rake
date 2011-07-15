require 'fastercsv'

namespace :users do
  desc "loads the users from static auth file to application"
  task :load_to_portal => :environment do
    hash = YAML.load_file("/etc/nubic/ncs/staff_portal_users.yml")
    hash['users'].each do |username, value| 
      unless Staff.find(:first, :conditions => {:netid => username})
        name = value['first_name']
        if value['last_name']
          name << " " << value['last_name']
        end
        Staff.create( :name => name, 
                      :netid => username,
                      :email => value['email'],
                      :study_center => STUDY_CENTER["id"])
      end
    end
  end
  
  desc "loads the users from csv file to static auth file"
  task :load_to_file, :file, :needs => :environment do |t, args|
    FILE = args[:file]
    raise "Please pass the path to file with csv extension.e.g 'rake users:load_to_file[path_to_file]'" unless FILE
    users = {} 
    users_list = {}
    FasterCSV.foreach("#{FILE}", :headers => true) do |csv|
      first_name, last_name = csv["NAME"].split ' '
      users[csv["NetID"]] = { "portals" => [{"StaffPortal" => ["staff"]}],
                              "first_name" => first_name, 
                              "last_name" => last_name, 
                              "email" => csv["EMAIL"]
                            }
    end
    users_list["groups"] = {"StaffPortal" => ["staff","supervisor"]}
    users_list["users"] = users
    File.open("#{RAILS_ROOT}/tmp/staff_portal_users.yml", 'w') {|f| f.write(users_list.to_yaml) }
  end
end
