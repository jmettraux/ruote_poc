
require 'yajl'
require 'ruote'
require 'ruote-redis'

ruote =
  Ruote::Dashboard.new(
    Ruote::Worker.new(
      Ruote::Redis::Storage.new(:db => 15, :thread_safe => true)))

ruote.noisy = ENV['NOISY'] == 'true'

class PocParticipant < Ruote::Participant
  def on_workitem
    puts '>' + ('=' * 79)
    puts 'PocParticipant:'
    puts "#{workitem.participant_name} / #{workitem.fei.sid}"
    puts workitem.fields.inspect
    puts ('=' * 79) + '<'
    reply
  end
end

ruote.register do
  catchall PocParticipant
end

puts "worker running, pid: #{$$}"

ruote.join

