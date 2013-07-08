# This migration comes from refinery_settings (originally 20100913234710)
class CreateRefinerycmsSettingsSchema < ActiveRecord::Migration
  def change
    create_table :refinery_settings do |t|
      t.string :name, :null => false
      t.text :value
      t.boolean :destroyable, :null => false, :default => true
      t.string :scoping, :limit => 32
      t.boolean :restricted, :null => false, :default => false
      t.string :form_value_type,
                  :null => false,
                  :limit => 32,
                  :default => Refinery::Setting::DEFAULT_VALUE_TYPE
      t.string :slug, :null => false

      t.timestamps
    end

    add_index :refinery_settings, [:name, :scoping], :unique => true
    add_index :refinery_settings, :slug, :unique => true
  end
end
