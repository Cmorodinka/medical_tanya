# encoding: utf-8
class CreateAdminBanners < ActiveRecord::Migration
  def change
    create_table :admin_banners do |t|
      t.string :title
      t.string :link_to
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
