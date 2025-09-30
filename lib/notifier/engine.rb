module Notifier
  class Engine < ::Rails::Engine
    isolate_namespace Notifier

    rake_tasks do
      namespace :notifier do
        task seed: :environment do
          load File.join(root, "db", "seeds.rb") if File.exist?(File.join(root, "db", "seeds.rb"))
        end
      end

      # Automatically run notifier seeds when db:seed is called
      if Rake::Task.task_defined?("db:seed")
        Rake::Task["db:seed"].enhance ["notifier:seed"]
      end
    end
  end
end
