require "guard/guard"

module ::Guard

  class CoffeeScript < ::Guard::Guard
    def run_on_change(paths)
      print "recompiling #{paths.join(', ')}... "
      system("coffee -co public/scripts app/scripts")
      puts "done!"
    end
  end

  class Compass < ::Guard::Guard
    def run_on_change(paths)
      print "recompiling #{paths.join(', ')}... "
      system "bundle exec compass compile -q"
      puts "done!"
    end
  end

end

guard 'coffee_script' do
  watch(/app\/scripts\/(.+)\.coffee/)
end

guard 'compass' do
  watch(/app\/styles\/(.+)\.sass/)
end