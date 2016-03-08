class CreateExtensions < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute "CREATE EXTENSION IF NOT EXISTS pg_trgm"
        execute "CREATE EXTENSION IF NOT EXISTS unaccent"
        execute "CREATE EXTENSION IF NOT EXISTS fuzzystrmatch"
      end

      dir.down do
        execute "DROP EXTENSION IF EXISTS pg_trgm"
        execute "DROP EXTENSION IF EXISTS unaccent"
        execute "DROP EXTENSION IF EXISTS fuzzystrmatch"
      end
    end
  end
end
