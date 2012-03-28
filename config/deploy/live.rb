role :web, "164.177.147.111"                          # Your HTTP server, Apache/etc
role :app, "164.177.147.111"
role :db,  "164.177.147.111", :primary => true