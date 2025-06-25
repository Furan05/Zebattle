class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :team1, class_name: 'Team'
  belongs_to :team2, class_name: 'Team'

  validates :team1_score, :team2_score, presence: true,
            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validate :different_teams

  def winner
    return nil if team1_score == team2_score
    team1_score > team2_score ? team1 : team2
  end

  def loser
    return nil if team1_score == team2_score
    team1_score < team2_score ? team1 : team2
  end

  def draw?
    team1_score == team2_score
  end

  def result_for_team(team)
    if team == team1
      opponent = team2
      our_score = team1_score
      opponent_score = team2_score
    elsif team == team2
      opponent = team1
      our_score = team2_score
      opponent_score = team1_score
    else
      return nil
    end

    if our_score > opponent_score
      { result: 'V', points: 3, our_score: our_score, opponent_score: opponent_score, opponent: opponent }
    elsif our_score < opponent_score
      { result: 'D', points: 0, our_score: our_score, opponent_score: opponent_score, opponent: opponent }
    else
      { result: 'N', points: 1, our_score: our_score, opponent_score: opponent_score, opponent: opponent }
    end
  end

  def match_summary
    "#{team1.name} #{team1_score}-#{team2_score} #{team2.name}"
  end

  private

  def different_teams
    errors.add(:team2, "doit être différente de l'équipe 1") if team1_id == team2_id
  end
end
