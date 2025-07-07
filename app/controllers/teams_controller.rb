class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :complete_team]

  def index
    @teams = Team.all.order(:name)
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to @team, notice: 'Équipe créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Équipe mise à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    begin
      @team.destroy
      redirect_to teams_url, notice: 'Équipe supprimée avec succès.'
    rescue ActiveRecord::InvalidForeignKey => e
      redirect_to teams_url, alert: 'Impossible de supprimer cette équipe car elle est utilisée dans des matchs.'
    rescue => e
      redirect_to teams_url, alert: 'Une erreur est survenue lors de la suppression de l\'équipe.'
    end
  end

  def complete_team
    if @team.full?
      redirect_to @team, alert: 'Cette équipe est déjà complète.'
      return
    end

    missing_count = @team.missing_players_count

    begin
      ActiveRecord::Base.transaction do
        missing_count.times do
          @team.players.create!(
            name: generate_random_name,
            position: random_position
          )
        end
      end

      redirect_to @team, notice: "#{missing_count} joueur#{'s' if missing_count > 1} #{missing_count > 1 ? 'ont été ajoutés' : 'a été ajouté'} automatiquement à l'équipe."
    rescue => e
      redirect_to @team, alert: 'Une erreur est survenue lors de la génération des joueurs.'
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :city)
  end

  def generate_random_name
    first_names = [
      'Alexandre', 'Baptiste', 'Clément', 'Damien', 'Étienne', 'Fabien', 'Gabriel', 'Hugo',
      'Julien', 'Kevin', 'Louis', 'Martin', 'Nicolas', 'Olivier', 'Pierre', 'Quentin',
      'Romain', 'Sébastien', 'Thomas', 'Vincent', 'William', 'Xavier', 'Yves', 'Zacharie',
      'Amélie', 'Béatrice', 'Camille', 'Delphine', 'Émilie', 'Fanny', 'Gabrielle', 'Hélène',
      'Isabelle', 'Julie', 'Karine', 'Laure', 'Marie', 'Nathalie', 'Océane', 'Pauline',
      'Quitterie', 'Rachel', 'Sophie', 'Tiphaine', 'Ursula', 'Valérie', 'Wendy', 'Xena',
      'Yasmine', 'Zoé', 'Adrien', 'Bastien', 'Céline', 'David', 'Elodie', 'Florian',
      'Gaëlle', 'Henri', 'Inès', 'Jérôme', 'Kévin', 'Luc', 'Maxime', 'Nathan'
    ]

    # Générer un nom unique pour cette équipe
    loop do
      name = first_names.sample
      break name unless @team.players.exists?(name: name)
    end
  end

  def random_position
    Player::POSITIONS.sample
  end
end
