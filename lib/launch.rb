
if ARGV.size < 2
  puts
  puts 'USAGE:'
  puts
  puts '  . launch.sh {count} {nick}'
  puts
  puts '  count:'
  puts '    the number of workflow instances to launch'
  puts '  nick:'
  puts '    the nickname for the run (result of the run'
  puts '    the result of the run is placed in results/{nick}.txt'
  puts
  exit 1
end

require 'fileutils'
require 'yajl'
require 'ruote'
#require 'ruote-redis'
require 'ruote/fs'

#ruote =
#  Ruote::Dashboard.new(
#    Ruote::Redis::Storage.new(:db => 15, :thread_safe => true))
ruote =
  Ruote::Dashboard.new(
    Ruote::FsStorage.new('ruote_work'))

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
    terminate :if => '${f:errors.step3}'

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

    stopwatch
  end

count = ARGV[0].to_i
nick = ARGV[1]

FileUtils.rm_f("results/#{nick}.txt")

fields = { 'step5' => %w[ a b c d ], 'nick' => nick }

count.times do |i|

  wfid =
    ruote.launch(
      pdef,
      fields.merge(:count => "#{i + 1}/#{count}", :ts => Time.now.to_f))

  puts "launched workflow instance #{wfid} (#{i + 1}/#{count})"
end

