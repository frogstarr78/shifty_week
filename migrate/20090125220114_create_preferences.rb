class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.references :admin_user
      t.string :week_day_start
      t.string :perspective
      t.boolean :follow_day,    :default => false
      t.boolean :follow_time,   :default => false
      t.boolean :military_time, :default => false
      t.timestamps
    end

    Preference.create :week_day_start => 'Mon', :perspective => 'Month', :admin_user_id => 20, :follow_day => true, :military_time => true, :follow_time => true
  end

  def self.down
    drop_table :preferences
  end
end
