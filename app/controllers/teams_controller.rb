class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

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

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :city)
  end
end
