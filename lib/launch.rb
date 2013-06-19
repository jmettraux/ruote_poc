
if ARGV.size < 1
  puts
  puts 'USAGE:'
  puts
  puts '  . launch.sh {nick}'
  puts
  puts ' where "nick" is the nickname for the flow to launch'
  puts
  exit 1
end

require 'yajl'
require 'ruote'
require 'ruote-redis'

ruote =
  Ruote::Dashboard.new(
    Ruote::Redis::Storage.new(:db => 15, :thread_safe => true))

#pdef =
#  Ruote.define do
#    toto
#  end
pdef =
  Ruote.define do

    participant 'step1'
    terminate :if => '${f:errors.step1}'

    participant 'step2'
    terminate :if => '${f:errors.step2}'

    participant 'step3'
    terminate :if => '${f:errors.step3'

    concurrence :merge_type => 'concat' do

      participant 'step4'

      sequence do
        participant 'step5'
        concurrent_iterator :on => '$f:step5', :to => 'pdp_id' do
          participant 'step6'
        end
      end

      participant 'step7'
      participant 'step8'
      participant 'step9'
      participant 'step10'
    end

    participant 'step11'
  end

fields = { 'nick' => ARGV[0], 'step5' => %w[ a b c d ] }

wfid = ruote.launch(pdef, fields)
puts "launched workflow instance #{wfid}"

