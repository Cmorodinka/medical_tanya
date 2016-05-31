class AddAttachmentImgUrlToAdminBanners < ActiveRecord::Migration
  def self.up
    change_table :admin_banners do |t|
      t.attachment :banner_img
    end
  end

  def self.down
    drop_attached_file :admin_banners, :banner_img
  end
end
