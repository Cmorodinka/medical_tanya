class FixDefaulDescriptiontForCategory < ActiveRecord::Migration
  def up
  	change_column :categories, :description, :text 
    # :default => "", :null => false
  end

  def down
  	change_column :categories, :description, :text, :default => nil
  end
end
