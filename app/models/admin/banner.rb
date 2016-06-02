class Admin::Banner < ActiveRecord::Base
  attr_accessible :description, :link_to, :title, :active, :banner_img, :started_at

  has_attached_file :banner_img, :styles => { :small => "292x36", :big => "730x90" }, :default_url => "/assets/paperclip/missing_banner_:style.png"
  
  # validates_presence_of :title, :link_to, :banner_img

  scope :active, -> { where(active: true) }


end
