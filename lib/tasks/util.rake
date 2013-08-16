Rails.env = ENV['e']
namespace :admin do
  desc 'Specific Admin tasks'
  task :test_picture_url, [:arg1] => :environment do |t, args|
    puts "===> Rails Env: #{Rails.env}"
    puts "===> Total Cards Count: #{Card.count}"
    Card.all.each do |card|
      puts "Card #{card.ref_id}"
      card.pictures.each {|p| puts p.card_image.thumb(Mycards::Application.config.thumbsize).url}
    end
  end
end