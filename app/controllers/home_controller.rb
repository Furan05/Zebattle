class HomeController < ApplicationController
  layout 'home'

  def index
    # Statistiques pour la home page
    @stats = {
      total_teams: Team.count,
      total_players: Player.count,
      total_tournaments: Tournament.count,
      complete_teams: Team.joins(:players).group('teams.id').having('COUNT(players.id) = 11').count.size,
      total_matches: Match.count,
      total_kills: Match.sum(:team1_score) + Match.sum(:team2_score)
    }

    # Derniers tournois pour l'aperçu
    @recent_tournaments = Tournament.includes(:matches)
                                   .where(status: 'completed')
                                   .order(created_at: :desc)
                                   .limit(3)

    # Top équipes basé sur les wins
    if Match.exists?
      @top_teams = Team.joins('LEFT JOIN matches m1 ON teams.id = m1.team1_id')
                      .joins('LEFT JOIN matches m2 ON teams.id = m2.team2_id')
                      .select('teams.*,
                              COUNT(CASE WHEN (m1.team1_score > m1.team2_score) OR (m2.team2_score > m2.team1_score) THEN 1 END) as wins_count')
                      .group('teams.id')
                      .order('wins_count DESC')
                      .limit(5)
    else
      @top_teams = []
    end

    # Statistiques par poste
    @position_stats = {
      'Tank' => Player.where(position: 'Tank').count,
      'Heal' => Player.where(position: 'Heal').count,
      'DPS' => Player.where(position: 'DPS').count
    }
  end
end
