# require "rails_helper"
# require "timeout"
# require "fileutils"
#
# RSpec.describe "Warmup on server boot", :slow do
#   it "runs WarmupService when starting Rails server" do
#     marker_path = Rails.root.join("tmp", "warmup_marker.txt").to_s
#     FileUtils.rm_f(marker_path)
#
#     env = {
#       "RAILS_ENV" => "test",
#       "WARMUP_TEST_MARKER_PATH" => marker_path
#     }
#
#     port = "4100"
#     cmd  = "bundle exec rails server -e test -p #{port}"
#
#     pid = Process.spawn(env, cmd, out: "/dev/null", err: "/dev/null")
#
#     begin
#       # Wait up to 60s for warmup to run and create the file
#       Timeout.timeout(60) do
#         until File.exist?(marker_path)
#           sleep 1
#         end
#       end
#     ensure
#       # Stop the server
#       Process.kill("TERM", pid) rescue nil
#       Process.wait(pid) rescue nil
#     end
#
#     expect(File).to exist(marker_path)
#   end
# end
