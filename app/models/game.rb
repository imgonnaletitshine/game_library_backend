class Game < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :min_age, numericality: { only_integer: true }, allow_blank: true
    validates :max_age, numericality: { only_integer: true }, allow_blank: true
    validates :min_duration, numericality: { only_integer: true }, allow_blank: true
    validates :max_duration, numericality: { only_integer: true }, allow_blank: true

    has_and_belongs_to_many :categories

    scope :where_or_null, -> (column, value) { where(column => value).or where column => nil }

    scope :search, -> (params) {
        ret = all
        if params.key? :search_term
            ret = ret.where(
                '`games`.`title` LIKE :search_term OR ' +
                '`games`.`description` LIKE :search_term',
                search_term: "%#{params[:search_term]}%"
            )
        end
        if params.key? :categories
            ret = ret.joins(:categories).where(categories: {id: params[:categories]})
        end

        ret = ret.where_or_null(min_age: ..params[:min_age]) if params.key? :min_age
        ret = ret.where_or_null(max_age: params[:max_age]..) if params.key? :max_age

        ret = ret.where_or_null(min_duration: params[:min_duration]..) if params.key? :min_duration
        ret = ret.where_or_null(max_duration: ..params[:max_duration]) if params.key? :max_duration

        limit = params.fetch :count, 3
        ret.order('RAND()').limit limit
    }
end
