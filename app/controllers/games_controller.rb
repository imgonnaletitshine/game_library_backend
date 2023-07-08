class GamesController < ApplicationController
  def create
    Game.create! game_params
  rescue ActiveRecord::RecordInvalid => e
    render json: { messages: e.as_json }, status: :unprocessable_entity
  end

  def index
    limit = params[:per_page]
    offset = (params[:page].to_i - 1) * limit
    games = Game.limit(limit).offset(offset)
    games_json = games.map do |game|
      {
        id: game.id,
        title: game.title,
        truncatedDescription: game.description.truncate(100),
      }
    end
    render json: { games: games_json }
  end

  def search
    games = Game.search(params.require :q)
    games_json = games.map do |game|
      {
        id: game.id,
        title: game.title,
        truncatedDescription: game.description.truncate(100),
      }
    end
    render json: { games: games_json }
  end

  def show
    game = Game.find params[:id]
    render json: { game: game.as_json(only: %i[id title description min_age max_age min_duration max_duration]) }
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
