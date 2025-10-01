module Notifier
  class Engine < ::Rails::Engine
    isolate_namespace Notifier

    # Engine configuration that will be applied to the host application
    config.before_configuration do
      Rails.application.config.active_job.queue_adapter = :solid_queue
    end

    initializer "notifier.solid_queue_config" do |app|
      # Configure Solid Queue settings for the host application
      app.config.solid_queue.connects_to = { database: { writing: :queue } }
      app.config.solid_queue.use_skip_locked = true
      app.config.solid_queue.silence_polling = true
    end

    rake_tasks do
      namespace :notifier do
        task seed: :environment do
          load File.join(root, "db", "seeds.rb") if File.exist?(File.join(root, "db", "seeds.rb"))
        end
      end

      # Automatically run notifier seeds when db:seed is called
      Rake::Task["db:seed"].enhance ["notifier:seed"] if Rake::Task.task_defined?("db:seed")
    end
  end
end
