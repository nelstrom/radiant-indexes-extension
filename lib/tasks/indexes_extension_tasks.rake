namespace :radiant do
  namespace :extensions do
    namespace :indexes do
      
      desc "Runs migrations, to add indexes to database."
      task :install => :migrate
      
      desc "Runs migrations, to remove indexes to database."
      task :uninstall => :environment do
        require 'radiant/extension_migrator'
        indexesExtension.migrator.migrate(0)
      end
      
      desc "Runs the migration of the indexes extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          indexesExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          indexesExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the indexes to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[indexesExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(indexesExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
