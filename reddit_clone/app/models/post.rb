# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  sub_id     :integer          not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :content, :author_id, presence: true

  has_many :post_subs,
  class_name: "PostSub",
  primary_key: :id,
  foreign_key: :post_id,
  inverse_of: :post

  has_many :subs,
  through: :post_subs,
  source: :sub

  has_many :comments, dependent: :destroy
end
