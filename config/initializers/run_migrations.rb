Rails.logger.info "Running migrations"
ActiveRecord::Migrator.migrate(Rails.root.join("db/migrate"), nil)
