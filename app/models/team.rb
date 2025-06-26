class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  # Relations pour les matchs
  has_many :team1_matches, class_name: 'Match', foreign_key: 'team1_id', dependent: :destroy
  has_many :team2_matches, class_name: 'Match', foreign_key: 'team2_id', dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
  validates :city, presence: true

  def full?
    players.count >= 11
  end

  def player_count
    players.count
  end

  def matches
    Match.where('team1_id = ? OR team2_id = ?', id, id)
  end

  def wins
    matches.select { |match| match.winner == self }.count
  end

  def losses
    matches.select { |match| match.loser == self }.count
  end

  def draws
    matches.select { |match| match.draw? }.count
  end

  def total_points
    wins * 3 + draws * 1
  end

  def kills_scored
    team1_matches.sum(:team1_score) + team2_matches.sum(:team2_score)
  end

  def kills_received
    team1_matches.sum(:team2_score) + team2_matches.sum(:team1_score)
  end

  def kill_difference
    kills_scored - kills_received
  end

  def name_with_info
    "#{name} (#{city}) - #{player_count}/11 joueurs#{' - COMPLÈTE' if full?}"
  end
end
