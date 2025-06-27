class Tournament < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :teams, -> { distinct }, through: :matches, source: :team1

  validates :name, presence: true, uniqueness: true
  validates :status, inclusion: { in: %w[pending completed] }

  def self.generate_auto_tournament
    tournament_id = Time.current.strftime('%Y%m%d%H%M%S')
    tournament = create!(
      name: "Tournoi Auto #{Time.current.strftime('%Y-%m-%d %H:%M:%S')}"
    )

    team_names = [
      "Dragons de Feu", "Titans de Glace", "Guerriers du Vent", "Maîtres de l'Ombre",
      "Héros de Lumière", "Gardiens du Temps", "Légendes d'Acier", "Champions Éternels"
    ]

    cities = ["Paris", "Lyon", "Marseille", "Toulouse", "Nice", "Nantes", "Strasbourg", "Montpellier"]

    8.times do |i|
      team = Team.create!(
        name: "#{team_names[i]} #{tournament_id}",
        city: cities[i]
      )

      positions_needed = ["Tank", "Tank", "Heal", "Heal", "Heal", "DPS", "DPS", "DPS", "DPS", "DPS", "DPS"]

      11.times do |j|
        team.players.create!(
          name: generate_player_name,
          position: positions_needed[j]
        )
      end
    end

    new_teams = Team.last(8)
    tournament.generate_matches(new_teams)
    tournament
  end

  def self.generate_faker_tournament
    tournament_id = Time.current.strftime('%Y%m%d%H%M%S')
    tournament = create!(
      name: "Tournoi #{Faker::Game.title} #{Time.current.strftime('%Y-%m-%d %H:%M')}"
    )

    8.times do |i|
      base_team_name = case rand(4)
                       when 0 then "#{Faker::Creature::Animal.name.capitalize} #{Faker::Fantasy::Tolkien.location}"
                       when 1 then "#{Faker::Games::LeagueOfLegends.champion}s de #{Faker::Fantasy::Tolkien.location}"
                       when 2 then "#{Faker::Superhero.name.split.first} #{Faker::Color.color_name.capitalize}"
                       else "#{Faker::Ancient.god} #{Faker::Military.army_rank.capitalize}s"
                       end

      # Ensure uniqueness by adding tournament_id
      team_name = "#{base_team_name} #{tournament_id}"

      team = Team.create!(
        name: team_name,
        city: Faker::Address.city
      )

      positions_needed = ["Tank", "Tank", "Heal", "Heal", "Heal", "DPS", "DPS", "DPS", "DPS", "DPS", "DPS"]

      11.times do |j|
        player_name = case rand(5)
                      when 0 then "#{Faker::Name.first_name} #{Faker::Games::Witcher.monster}"
                      when 1 then "#{Faker::Fantasy::Tolkien.character}"
                      when 2 then "#{Faker::Games::LeagueOfLegends.champion}"
                      when 3 then "#{Faker::Superhero.name}"
                      else "#{Faker::Name.first_name} le #{Faker::Ancient.titan}"
                      end

        team.players.create!(
          name: player_name,
          position: positions_needed[j]
        )
      end
    end

    new_teams = Team.last(8)
    tournament.generate_matches(new_teams)
    tournament
  end

  def generate_matches(teams)
    teams_array = teams.to_a
    teams_array.combination(2).each do |team1, team2|
      matches.create!(
        team1: team1,
        team2: team2,
        team1_score: rand(0..5),
        team2_score: rand(0..5)
      )
    end

    update!(status: 'completed')
  end

  def ranking
    team_stats = {}

    teams_in_tournament = Team.joins("LEFT JOIN matches m1 ON teams.id = m1.team1_id")
                             .joins("LEFT JOIN matches m2 ON teams.id = m2.team2_id")
                             .where("m1.tournament_id = ? OR m2.tournament_id = ?", id, id)
                             .distinct

    teams_in_tournament.each do |team|
      team_stats[team] = {
        points: 0,
        kills_scored: 0,
        kills_received: 0
      }
    end

    matches.each do |match|
      if match.team1_score > match.team2_score
        team_stats[match.team1][:points] += 3
      elsif match.team1_score < match.team2_score
        team_stats[match.team2][:points] += 3
      else
        team_stats[match.team1][:points] += 1
        team_stats[match.team2][:points] += 1
      end

      team_stats[match.team1][:kills_scored] += match.team1_score
      team_stats[match.team1][:kills_received] += match.team2_score
      team_stats[match.team2][:kills_scored] += match.team2_score
      team_stats[match.team2][:kills_received] += match.team1_score
    end

    team_stats.sort_by do |team, stats|
      [-stats[:points], -(stats[:kills_scored] - stats[:kills_received])]
    end
  end

  def total_matches
    8 * 7 / 2
  end

  private

  def self.generate_player_name
    first_names = [
      "Aragorn", "Legolas", "Gimli", "Gandalf", "Boromir", "Faramir",
      "Eowyn", "Arwen", "Galadriel", "Elrond", "Theoden", "Denethor"
    ]

    suffixes = ["le Brave", "l'Intrépide", "le Sage", "le Puissant", "l'Agile",
                "le Noble", "le Fier", "l'Audacieux", "le Vaillant", "le Loyal"]

    "#{first_names.sample} #{suffixes.sample}"
  end
end
