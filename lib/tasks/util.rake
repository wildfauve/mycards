namespace :user do
  desc 'Some User tasks'
  task :picture_url => :environment do
    Card.all.each do |card|
      puts "Card #{card.ref_id}"
      card.pictures.each {|p| puts p.card_image.thumb(Mycards::Application.config.thumbsize).url}
    end
  end
end