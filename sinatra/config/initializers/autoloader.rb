paths = [
  'app/**/*.rb',
  'config/initializers/*.rb'
]

paths.each do |path|
  Dir[File.join(SinatraApi::App.root, path)].each do |file|
    next if file.include?('initializers/autoloader')
    require file
  end
end