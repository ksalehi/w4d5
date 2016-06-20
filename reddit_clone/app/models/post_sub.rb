class PostSub < ActiveRecord::Base
  validates :sub, :post, presence: true

  belongs_to :post,
  class_name: :Post,
  primary_key: :id,
  foreign_key: :post_id,
  inverse_of: :post_subs

  belongs_to :sub,
  class_name: :Sub,
  primary_key: :id,
  foreign_key: :sub_id,
  inverse_of: :post_subs
end
