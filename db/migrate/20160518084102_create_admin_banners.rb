# encoding: utf-8
class CreateAdminBanners < ActiveRecord::Migration
  def self.up
    create_table :admin_banners do |t|
      t.string :title
      t.string :link_to
      t.text :description
      t.boolean :active
      t.attachment :banner_img
      t.datetime :started_at

      t.timestamps
    end
  end

  def self.down
      drop_table :admin_banners
  end
end

