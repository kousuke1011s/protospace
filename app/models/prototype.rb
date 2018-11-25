class Prototype < ActiveRecord::Base
  belongs_to :user
  has_many :prototype_tags, dependent: :destroy
  has_many :tags, through: :prototype_tags
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :captured_images, dependent: :destroy

  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images, allow_destroy: true

  validates :title,
            :catch_copy,
            :concept,
            presence: true

  def reject_sub_images(attributed)
    attributed['content'].blank?
  end

  def reject_tags(attributed)
    attributed['tag'].blank?
  end

  def save_tags(tags)
    current_tags = self.tags.pluck(:tag) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      prototype_tag = Tag.find_or_create_by(tag:new_name)
      self.tags << prototype_tag
    end
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end
end
