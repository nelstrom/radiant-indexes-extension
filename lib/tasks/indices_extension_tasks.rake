namespace :radiant do
  namespace :extensions do
    namespace :indices do
      
      desc "Runs migrations, to add indices to database."
      task :install => :migrate
      
      desc "Runs migrations, to remove indices to database."
      task :uninstall => :environment do
        require 'radiant/extension_migrator'
        IndicesExtension.migrator.migrate(0)
      end
      
      desc "Runs the migration of the Indices extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          IndicesExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          IndicesExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Indices to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[IndicesExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(IndicesExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end  
    end
  end
end
