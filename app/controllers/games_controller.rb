class GamesController < ApplicationController
  def create
    Game.create! game_params
  rescue ActiveRecord::RecordInvalid => e
    render json: { messages: e.as_json }, status: :unprocessable_entity
  end

  def index
    limit = params.fetch(:per_page, DEFAULT_PER_PAGE).to_i
    page = params.fetch(:page, 1).to_i
    offset = (page - 1) * limit
    games = Game.limit(limit).offset(offset)
    games_json = games.map &:as_json_for_list
    render json: { games: games_json }
  end

  def search
    games = Game.search(params.require :q)
    games_json = games.map &:as_json_for_list
    render json: { games: games_json }
  end

  def show
    game = Game.find params[:id]
    render json: { game: game.as_json }
  rescue ActiveRecord::RecordNotFound
    render status: 404
  end

  private

    def game_params
      params.require(:game).permit(
        :title, :description,
        :min_age, :max_age,
        :min_duration, :max_duration,
        category_ids: [],
      )
    end
end
