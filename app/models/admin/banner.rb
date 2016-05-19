class Admin::Banner < ActiveRecord::Base
  attr_accessible :description, :img_url, :link_to, :title
end
