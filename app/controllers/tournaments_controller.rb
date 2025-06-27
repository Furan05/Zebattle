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

  def new
    @tournament = Tournament.new
    @teams = Team.joins(:players)
                 .group('teams.id')
                 .having('COUNT(players.id) >= 11')
                 .order(:name)
  end

  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      selected_teams = Team.where(id: params[:team_ids]).limit(8)

      if selected_teams.count >= 2
        @tournament.generate_matches(selected_teams)
        redirect_to @tournament, notice: "🏆 Tournoi créé avec succès avec #{selected_teams.count} équipes !"
      else
        @tournament.destroy
        redirect_to new_tournament_path, alert: "Vous devez sélectionner au moins 2 équipes pour créer un tournoi."
      end
    else
      @teams = Team.joins(:players)
                   .group('teams.id')
                   .having('COUNT(players.id) >= 11')
                   .order(:name)
      render :new, status: :unprocessable_entity
    end
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
