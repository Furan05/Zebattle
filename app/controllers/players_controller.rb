class PlayersController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_player, only: [:show, :edit, :update, :destroy]

  # Routes globales (sans équipe spécifique)
  def index
    @players = Player.includes(:team).order(:name)
    @teams = Team.all.order(:name)
  end

  def new
    # Route globale : /players/new
    if params[:team_id].blank?
      @player = Player.new
      @teams = Team.all.order(:name)
      render :global_new
    else
      # Route imbriquée : /teams/:team_id/players/new
      @team = Team.find(params[:team_id])
      @player = @team.players.build

      if @team.full?
        redirect_to @team, alert: 'Cette équipe est déjà complète (11 joueurs maximum).'
        return
      end
      render :new
    end
  end

  def create
    # Route globale : POST /players
    if params[:team_id].blank?
      @player = Player.new(global_player_params)
      @teams = Team.all.order(:name)

      if @player.save
        redirect_to @player.team, notice: 'Joueur ajouté avec succès à l\'équipe.'
      else
        render :global_new, status: :unprocessable_entity
      end
    else
      # Route imbriquée : POST /teams/:team_id/players
      @team = Team.find(params[:team_id])
      @player = @team.players.build(player_params)

      if @player.save
        redirect_to @team, notice: 'Joueur ajouté avec succès.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # Routes pour les équipes spécifiques (existantes)
  def show
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to @team, notice: 'Joueur mis à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player.destroy
    redirect_to @team, notice: 'Joueur supprimé avec succès.'
  end

  private

  def set_team
    @team = Team.find(params[:team_id]) if params[:team_id]
  end

  def set_player
    if @team
      @player = @team.players.find(params[:id])
    else
      @player = Player.find(params[:id])
    end
  end

  def player_params
    params.require(:player).permit(:name, :position)
  end

  def global_player_params
    params.require(:player).permit(:name, :position, :team_id)
  end
end
