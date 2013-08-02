require 'dragonfly'

app = Dragonfly[:images]
mconfig = YAML.load_file(File.join(Rails.root,'config','mongoid.yml'))[Rails.env]
app.datastore = Dragonfly::DataStorage::MongoDataStore.new
app.datastore.configure do |c|
  cfg = mconfig['sessions']['default']
  if cfg['hosts'].size < 2
    c.host = cfg['hosts'].first.split(':').first
    c.port = cfg['hosts'].first.split(':').second
  else
    c.hosts = cfg['hosts']
  end
  c.database = cfg['database']
  c.username = cfg['username']
  c.password = cfg['password']
end
# Allow all mongoid models to use the macro 'image_accessor'
app.define_macro_on_include(Mongoid::Document, :image_accessor)
app.configure_with(:imagemagick)
app.configure_with(:rails)
# ... any other setup, see Rails docs
