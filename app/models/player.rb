class Player < ApplicationRecord
  belongs_to :team

  POSITIONS = %w[Heal Tank DPS].freeze

  validates :name, presence: true, uniqueness: { scope: :team_id }
  validates :position, presence: true, inclusion: { in: POSITIONS }
  validates :team_id, presence: true
  validate :team_not_full
  validate :team_exists

  scope :tanks, -> { where(position: 'Tank') }
  scope :heals, -> { where(position: 'Heal') }
  scope :dps, -> { where(position: 'DPS') }

  def display_name
    "#{name} (#{position})"
  end

  def team_info
    "#{team.name} - #{team.city}"
  end

  private

  def team_not_full
    return unless team_id && new_record?

    selected_team = Team.find_by(id: team_id)
    return unless selected_team

    if selected_team.players.count >= 11
      errors.add(:team, "est déjà complète (11 joueurs maximum)")
    end
  end

  def team_exists
    return unless team_id

    unless Team.exists?(team_id)
      errors.add(:team, "n'existe pas")
    end
  end
end
