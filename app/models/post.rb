class Post < ApplicationRecord
include Visible

    has_rich_text :content

    has_many :comments, dependent: :destroy

    validates :title, presence: true
    validates :content, presence: true, length: {minimum: 10}

    VALID_STATUSES = ['public','private','archived']

    validates :status, inclusion: {in: VALID_STATUSES}

    def archived?
        status == 'archived'
    end
    scope :sorted, ->{ order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc)}
    scope :draft, -> {where(published_at: nil)}
    scope :published, -> {where("published_at <= ?", Time.current)}
    scope :scheduled, -> {where("published_at > ?", Time.current)}

    def draft?
        published_at.nil?
    end

    def published?
        published_at? && published_at <= Time.current
    end

    def scheduled?
        published_at? && published_at > Time.current
    end
end

    
