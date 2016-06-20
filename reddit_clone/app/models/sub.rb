# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :text
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :moderator_id, presence: true

  has_many :post_subs,
  class_name: "PostSub",
  primary_key: :id,
  foreign_key: :sub_id,
  inverse_of: :sub

  has_many :posts,
  through: :post_subs,
  source: :post
end
