class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all.order(created_at: :desc)
    @complete_teams = Team.joins(:players)
                         .group('teams.id')
                         .having('COUNT(players.id) = 11')
                         .count.keys.size
  end

  def show
    @tournament = Tournament.find(params[:id])
    @ranking = @tournament.ranking
    @matches = @tournament.matches.includes(:team1, :team2).order(:created_at)
  end

  def generate_auto
    begin
      @tournament = Tournament.generate_auto_tournament
      redirect_to @tournament, notice: "🏆 Tournoi automatique généré avec succès ! 8 équipes créées avec 11 joueurs chacune."
    rescue => e
      redirect_to tournaments_path, alert: "Erreur lors de la génération: #{e.message}"
    end
  end

  def generate_faker
    begin
      @tournament = Tournament.generate_faker_tournament
      redirect_to tournament_path(@tournament), notice: "🎲 Tournoi Faker généré avec succès ! 8 équipes créatives avec 11 joueurs chacune."
    rescue => e
      redirect_to tournaments_path, alert: "Erreur lors de la génération Faker: #{e.message}"
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name)
  end
end
