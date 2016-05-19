class CreateAdminBanners < ActiveRecord::Migration
  def change
    create_table :admin_banners do |t|
      t.string :title
      t.string :img_url
      t.string :link_to
      t.text :description

      t.timestamps
    end
  end
end
