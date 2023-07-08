class Game < ApplicationRecord
    DEFAULT_SEARCH_RESULT_COUNT = 3

    validates :title, presence: true
    validates :description, presence: true
    validates :min_age, numericality: { only_integer: true }, allow_blank: true
    validates :max_age, numericality: { only_integer: true }, allow_blank: true
    validates :min_duration, numericality: { only_integer: true }, allow_blank: true
    validates :max_duration, numericality: { only_integer: true }, allow_blank: true

    has_and_belongs_to_many :categories

    scope :where_or_null, -> (conditions) {
        conditions.inject all do |ret, (column, value)|
            ret.where(column => value).or where column => nil
        end
    }

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

        ret = ret.where_or_null(min_age: ..params[:min_age], max_age: params[:min_age]..) if params.key? :min_age
        ret = ret.where_or_null(min_age: ..params[:max_age], max_age: params[:max_age]..) if params.key? :max_age

        ret = ret.where_or_null(min_duration: ..params[:duraton], max_duration: params[:duration]..) if params.key? :duration

        limit = params.fetch :count, DEFAULT_SEARCH_RESULT_COUNT
        ret.order('RAND()').limit limit
    }

    def category_names
        categories.map &:name
    end

    def as_json **options
        super.merge 'categories' => category_names
    end

    def as_json_for_list
        {
            id: id,
            title: title,
            truncatedDescription: description.truncate(100),
        }
    end
end
